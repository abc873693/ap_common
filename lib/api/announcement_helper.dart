import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:ap_common/callback/general_callback.dart';
import 'package:ap_common/models/announcement_data.dart';
import 'package:ap_common/models/announcement_login_data.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

export 'package:ap_common/callback/general_callback.dart';
export 'package:ap_common/models/announcement_login_data.dart';

enum AnnouncementLoginType {
  normal,
  google,
  apple,
}

class AnnouncementHelper {
  static String host = 'nkust.taki.dog';
  static String tag = '/beta';

  static String fcmToken;

  static AnnouncementHelper _instance;
  static BaseOptions options;
  static Dio dio;
  static JsonCodec jsonCodec;
  static CancelToken cancelToken;

  static AnnouncementLoginType loginType = AnnouncementLoginType.normal;

  static String username;
  static String password;
  static String code;
  static DateTime expireTime;

  static bool isSupportCacheData =
      (!kIsWeb && (Platform.isIOS || Platform.isMacOS || Platform.isAndroid));

  //LOGIN API
  static const USER_DATA_ERROR = 1401;

  int reLoginCount = 0;

  bool get canReLogin => reLoginCount == 0;

  bool isExpire() {
    if (expireTime == null)
      return false;
    else
      return DateTime.now().isAfter(expireTime.add(Duration(hours: 8)));
  }

  static AnnouncementHelper get instance {
    if (_instance == null) {
      _instance = AnnouncementHelper();
      jsonCodec = JsonCodec();
      cancelToken = CancelToken();
    }
    return _instance;
  }

  AnnouncementHelper() {
    options = BaseOptions(
      baseUrl: 'https://$host$tag',
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );
    dio = Dio(options);
  }

  static resetInstance() {
    _instance = AnnouncementHelper();
    jsonCodec = JsonCodec();
    cancelToken = CancelToken();
  }

  Future<bool> reLogin(GeneralCallback callback) async {
    var loginData = await login(
      username: username,
      password: password,
      callback: GeneralCallback<AnnouncementLoginData>(
        onSuccess: (loginData) => AnnouncementLoginData,
        onFailure: callback?.onFailure,
        onError: callback?.onError,
      ),
    );
    return loginData != null;
  }

  Future<AnnouncementLoginData> login({
    String username,
    String password,
    GeneralCallback<AnnouncementLoginData> callback,
  }) async {
    try {
      var response = await dio.post(
        '/login',
        data: {
          'username': username,
          'password': password,
          "fcmToken": fcmToken,
        },
      );
      print(response.statusCode);
      var loginData = AnnouncementLoginData.fromJson(response.data);
      options.headers = _createBearerTokenAuth(loginData.key);
      AnnouncementHelper.username = username;
      AnnouncementHelper.password = password;
      AnnouncementHelper.loginType = AnnouncementLoginType.normal;
      return loginData;
    } on DioError catch (dioError) {
      debugPrint(dioError.response.data.toString());
      throw dioError;
    }
  }

  Future<AnnouncementLoginData> googleLogin({
    String idToken,
    GeneralCallback<AnnouncementLoginData> callback,
  }) async {
    try {
      debugPrint(idToken);
      var response = await dio.post(
        '/oauth2/google/token',
        data: {
          'token': idToken,
          "fcmToken": fcmToken,
        },
      );
      var loginData = AnnouncementLoginData.fromJson(response.data);
      options.headers = _createBearerTokenAuth(loginData.key);
      AnnouncementHelper.code = idToken;
      AnnouncementHelper.loginType = AnnouncementLoginType.google;
      return loginData;
    } on DioError catch (dioError) {
      debugPrint(dioError.response.data.toString());
      throw dioError;
    }
  }

  Future<AnnouncementLoginData> appleLogin({
    String idToken,
    GeneralCallback<AnnouncementLoginData> callback,
  }) async {
    try {
      debugPrint(idToken);
      var response = await dio.post(
        '/oauth2/apple/token',
        data: {
          'token': idToken,
          "fcmToken": fcmToken,
        },
      );
      var loginData = AnnouncementLoginData.fromJson(response.data);
      options.headers = _createBearerTokenAuth(loginData.key);
      AnnouncementHelper.code = idToken;
      AnnouncementHelper.loginType = AnnouncementLoginType.apple;
      return loginData;
    } on DioError catch (dioError) {
      debugPrint(dioError.response.data.toString());
      throw dioError;
    }
  }

  Future<Response> deleteToken() async {
    try {
      var response = await dio.delete(
        '/oauth/token',
      );
      return response;
    } on DioError catch (dioError) {
      throw dioError;
    }
  }

  Future<Response> deleteAllToken() async {
    try {
      var response = await dio.delete(
        '/oauth/token/all',
      );
      return response;
    } on DioError catch (dioError) {
      throw dioError;
    }
  }

  Future<List<Announcement>> getAllAnnouncements({
    String locale,
    GeneralCallback<List<Announcement>> callback,
  }) async {
    try {
      var response = await dio.get(
        "/announcements",
        queryParameters: {
          'lang': locale ?? '',
        },
      );
      var data = AnnouncementData(data: []);
      if (response.statusCode != 204) {
        data = AnnouncementData.fromJson(response.data);
        data.data.sort((a, b) {
          return b.weight.compareTo(a.weight);
        });
      }
      return (callback == null) ? data.data : callback.onSuccess(data.data);
    } on DioError catch (dioError) {
      if (callback == null)
        throw dioError;
      else
        callback.onFailure(dioError);
    }
    return null;
  }

  Future<Response> addAnnouncement(Announcement announcements) async {
    try {
      var response = await dio.post(
        "/announcements/add",
        data: announcements.toUpdateJson(),
      );
      return response;
    } on DioError catch (dioError) {
      throw dioError;
    }
  }

  Future<Response> updateAnnouncement(Announcement announcements) async {
    try {
      var response = await dio.put(
        "/announcements/update/${announcements.id}",
        data: announcements.toUpdateJson(),
      );
      return response;
    } on DioError catch (dioError) {
      throw dioError;
    }
  }

  Future<Response> deleteAnnouncement(Announcement announcements) async {
    try {
      var response = await dio.delete(
        "/announcements/delete/${announcements.id}",
        data: announcements.toUpdateJson(),
      );
      return response;
    } on DioError catch (dioError) {
      throw dioError;
    }
  }

  Future<List<Announcement>> getApplications({
    String locale,
    GeneralCallback<List<Announcement>> callback,
  }) async {
    try {
      var response = await dio.get(
        "/application",
      );
      var data = AnnouncementData(data: []);
      if (response.statusCode != 204) {
        data = AnnouncementData.fromJson(response.data);
        data.data.sort((a, b) {
          return b.weight.compareTo(a.weight);
        });
      }
      return (callback == null) ? data.data : callback.onSuccess(data.data);
    } on DioError catch (dioError) {
      throw dioError;
    }
  }

  Future<Response> addApplication(Announcement announcements) async {
    try {
      var response = await dio.post(
        "/application",
        data: announcements.toUpdateJson(),
      );
      return response;
    } on DioError catch (dioError) {
      throw dioError;
    }
  }

  Future<Response> approveApplication({
    @required String applicationId,
    String reviewDescription,
  }) async {
    try {
      var response = await dio.put(
        "/application/$applicationId/approve",
        data: {
          "description": reviewDescription ?? '',
        },
      );
      return response;
    } on DioError catch (dioError) {
      throw dioError;
    }
  }

  Future<Response> rejectApplication({
    @required String applicationId,
    String reviewDescription,
  }) async {
    try {
      var response = await dio.put(
        "/application/$applicationId/reject",
        data: {
          "description": reviewDescription ?? '',
        },
      );
      return response;
    } on DioError catch (dioError) {
      throw dioError;
    }
  }

  Future<Response> removeApplication(String applicationId) async {
    try {
      var response = await dio.delete(
        "/application/$applicationId",
      );
      return response;
    } on DioError catch (dioError) {
      throw dioError;
    }
  }

  Future<Response> updateApplication(Announcement announcements) async {
    try {
      print('${announcements.applicationId}');
      var response = await dio.put(
        "/application/${announcements.applicationId}",
        data: announcements.toUpdateApplicationJson(),
      );
      print(response.data);
      return response;
    } on DioError catch (dioError) {
      print(dioError.response.data);
      throw dioError;
    }
  }

  // v3 api Authorization
  _createBearerTokenAuth(String token) {
    return {
      'Authorization': 'Bearer $token',
    };
  }

  static void clearSetting() {
    expireTime = null;
    username = null;
    password = null;
  }
}

extension NewsExtension on Announcement {
  Map<String, dynamic> toUpdateJson() => {
        "title": title,
        "weight": weight ?? 0,
        "imgUrl": imgUrl,
        "url": url,
        "description": description,
        "expireTime": expireTime,
      };
}
