import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:ui' show Locale;

import 'package:ap_common/callback/general_callback.dart';
import 'package:ap_common/l10n/l10n.dart';
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

extension DioErrorExtension on DioError {
  bool get isUnauthorized =>
      type == DioErrorType.RESPONSE && response.statusCode == 401;

  bool get isNotPermission =>
      type == DioErrorType.RESPONSE && response.statusCode == 403;

  bool get isNotFoundAnnouncement =>
      type == DioErrorType.RESPONSE && response.statusCode == 404;
}

class AnnouncementHelper {
  static String host = 'nkust.taki.dog';
  static String tag = 'ap';
  static String organization;
  static String appleBundleId;

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
  static const TOKEN_EXPIRE = 401;
  static const NOT_PERMISSION = 403;
  static const NOT_FOUND_DATA = 404;

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
      baseUrl: 'https://$host/$tag',
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

  void setLocale(Locale locale) {
    if (locale.languageCode == 'zh' || locale.languageCode == 'en')
      dio.options.headers['locale'] = locale.languageCode;
    else
      dio.options.headers['locale'] = 'en';
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
    @required String username,
    @required String password,
    @required GeneralCallback<AnnouncementLoginData> callback,
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
      var loginData = AnnouncementLoginData.fromJson(response.data);
      setAuthorization(loginData.key);
      AnnouncementHelper.username = username;
      AnnouncementHelper.password = password;
      AnnouncementHelper.loginType = AnnouncementLoginType.normal;
      return callback == null ? loginData : callback.onSuccess(loginData);
    } on DioError catch (dioError) {
      if (callback == null)
        throw dioError;
      else {
        if (dioError.isUnauthorized)
          callback.onError(
            GeneralResponse(
              statusCode: 401,
              message: ApLocalizations.current.loginFail,
            ),
          );
        callback.onFailure(dioError);
      }
    }
    return null;
  }

  Future<AnnouncementLoginData> googleLogin({
    @required String idToken,
    @required GeneralCallback<AnnouncementLoginData> callback,
  }) async {
    try {
      var response = await dio.post(
        '/oauth2/google/token',
        data: {
          'token': idToken,
          "fcmToken": fcmToken,
        },
      );
      var loginData = AnnouncementLoginData.fromJson(response.data);
      setAuthorization(loginData.key);
      AnnouncementHelper.code = idToken;
      AnnouncementHelper.loginType = AnnouncementLoginType.google;
      return callback == null ? loginData : callback.onSuccess(loginData);
    } on DioError catch (dioError) {
      if (callback == null)
        throw dioError;
      else {
        if (dioError.isUnauthorized)
          callback.onError(
            GeneralResponse(
              statusCode: 401,
              message: dioError.response.data,
            ),
          );
        callback.onFailure(dioError);
      }
    }
    return null;
  }

  Future<AnnouncementLoginData> appleLogin({
    @required String idToken,
    @required GeneralCallback<AnnouncementLoginData> callback,
  }) async {
    try {
      var response = await dio.post(
        '/oauth2/apple/token',
        data: {
          'token': idToken,
          "fcmToken": fcmToken,
          'bundleId': appleBundleId
        },
      );
      var loginData = AnnouncementLoginData.fromJson(response.data);
      setAuthorization(loginData.key);
      AnnouncementHelper.code = idToken;
      AnnouncementHelper.loginType = AnnouncementLoginType.apple;
      return callback == null ? loginData : callback.onSuccess(loginData);
    } on DioError catch (dioError) {
      if (callback == null)
        throw dioError;
      else {
        if (dioError.isUnauthorized)
          callback.onError(
            GeneralResponse(
              statusCode: 401,
              message: dioError.response.data,
            ),
          );
        callback.onFailure(dioError);
      }
    }
    return null;
  }

  Future<List<Announcement>> getAllAnnouncements({
    @required GeneralCallback<List<Announcement>> callback,
  }) async {
    try {
      var response = await dio.get(
        "/announcements",
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

  Future<List<Announcement>> getAnnouncements({
    @required GeneralCallback<List<Announcement>> callback,
    String locale,
    List<String> tags,
  }) async {
    try {
      var response = await dio.post(
        "/announcements",
        data: {
          "tag": tags ?? [],
          "lang": locale ?? "zh",
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

  Future<Response> addAnnouncement({
    @required Announcement data,
    @required GeneralCallback<Response> callback,
  }) async {
    try {
      var response = await dio.post(
        "/announcements/add",
        data: data.toUpdateJson(),
      );
      return callback == null ? response : callback.onSuccess(response);
    } on DioError catch (dioError) {
      if (callback == null)
        throw dioError;
      else
        handleCrudError(dioError, callback);
    }
    return null;
  }

  Future<Response> updateAnnouncement({
    @required Announcement data,
    @required GeneralCallback<Response> callback,
  }) async {
    try {
      var response = await dio.put(
        "/announcements/update/${data.id}",
        data: data.toUpdateJson(),
      );
      return callback == null ? response : callback.onSuccess(response);
    } on DioError catch (dioError) {
      if (callback == null)
        throw dioError;
      else
        handleCrudError(dioError, callback);
    }
    return null;
  }

  Future<Response> deleteAnnouncement({
    @required Announcement data,
    @required GeneralCallback<Response> callback,
  }) async {
    try {
      var response = await dio.delete(
        "/announcements/delete/${data.id}",
        data: data.toUpdateJson(),
      );
      return callback == null ? response : callback.onSuccess(response);
    } on DioError catch (dioError) {
      if (callback == null)
        throw dioError;
      else
        handleCrudError(dioError, callback);
    }
    return null;
  }

  Future<List<Announcement>> getApplications({
    String locale,
    @required GeneralCallback<List<Announcement>> callback,
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
      if (callback == null)
        throw dioError;
      else
        callback.onFailure(dioError);
    }
    return null;
  }

  Future<Response> addApplication({
    @required Announcement data,
    @required GeneralCallback<Response> callback,
    String languageCode,
  }) async {
    try {
      data.tags ??= [];
      data.tags.addAll([
        languageCode ?? 'zh',
        if (organization != null) organization,
      ]);
      var response = await dio.post(
        "/application",
        data: data.toUpdateJson(),
      );
      return callback == null ? response : callback.onSuccess(response);
    } on DioError catch (dioError) {
      if (callback == null)
        throw dioError;
      else
        handleCrudError(dioError, callback);
    }
    return null;
  }

  Future<Response> approveApplication({
    @required String applicationId,
    String reviewDescription,
    @required GeneralCallback<Response> callback,
  }) async {
    try {
      var response = await dio.put(
        "/application/$applicationId/approve",
        data: {
          "description": reviewDescription ?? '',
        },
      );
      return callback == null ? response : callback.onSuccess(response);
    } on DioError catch (dioError) {
      if (callback == null)
        throw dioError;
      else
        handleCrudError(dioError, callback);
    }
    return null;
  }

  Future<Response> rejectApplication({
    @required String applicationId,
    String reviewDescription,
    @required GeneralCallback<Response> callback,
  }) async {
    try {
      var response = await dio.put(
        "/application/$applicationId/reject",
        data: {
          "description": reviewDescription ?? '',
        },
      );
      return callback == null ? response : callback.onSuccess(response);
    } on DioError catch (dioError) {
      if (callback == null)
        throw dioError;
      else
        handleCrudError(dioError, callback);
    }
    return null;
  }

  Future<Response> removeApplication({
    @required String applicationId,
    @required GeneralCallback<Response> callback,
  }) async {
    try {
      var response = await dio.delete(
        "/application/$applicationId",
      );
      return callback == null ? response : callback.onSuccess(response);
    } on DioError catch (dioError) {
      if (callback == null)
        throw dioError;
      else
        handleCrudError(dioError, callback);
    }
    return null;
  }

  Future<Response> updateApplication({
    @required Announcement data,
    @required GeneralCallback<Response> callback,
  }) async {
    try {
      var response = await dio.put(
        "/application/${data.applicationId}",
        data: data.toUpdateApplicationJson(),
      );
      return callback == null ? response : callback.onSuccess(response);
    } on DioError catch (dioError) {
      if (callback == null)
        throw dioError;
      else
        handleCrudError(dioError, callback);
    }
    return null;
  }

  void setAuthorization(String key) {
    dio.options.headers['Authorization'] = 'Bearer $key';
  }

  static void clearSetting() {
    expireTime = null;
    username = null;
    password = null;
  }

  void handleCrudError(DioError dioError, GeneralCallback<Response> callback) {
    if (dioError.isNotPermission)
      callback.onError(
        GeneralResponse(
          statusCode: NOT_PERMISSION,
          message: ApLocalizations.current.noPermissionHint,
        ),
      );
    else if (dioError.isNotFoundAnnouncement)
      callback.onError(
        GeneralResponse(
          statusCode: NOT_PERMISSION,
          message: ApLocalizations.current.notFoundData,
        ),
      );
    else
      callback.onFailure(dioError);
  }
}
