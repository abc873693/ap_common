import 'dart:async';
import 'dart:convert';
import 'dart:ui' show Locale;

import 'package:ap_common/callback/general_callback.dart';
import 'package:ap_common/l10n/l10n.dart';
import 'package:ap_common/models/announcement_data.dart';
import 'package:ap_common/models/announcement_login_data.dart';

export 'package:ap_common/callback/general_callback.dart';
export 'package:ap_common/models/announcement_login_data.dart';

enum AnnouncementLoginType {
  normal,
  google,
  apple,
}

extension DioErrorExtension on DioError {
  bool get isUnauthorized =>
      type == DioErrorType.badResponse && response?.statusCode == 401;

  bool get isNotPermission =>
      type == DioErrorType.badResponse && response?.statusCode == 403;

  bool get isNotFoundAnnouncement =>
      type == DioErrorType.badResponse && response?.statusCode == 404;
}

class AnnouncementHelper {
  AnnouncementHelper() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://$host/$tag',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  }

  // ignore: prefer_constructors_over_static_methods
  static AnnouncementHelper get instance {
    return _instance ??= AnnouncementHelper();
  }

  static const int useDataError = 1401;
  static const int tokenExpire = 401;
  static const int notPermission = 403;
  static const int notFoundData = 404;

  static AnnouncementHelper? _instance;

  static String host = 'nkust.taki.dog';
  static String tag = 'ap';

  late Dio dio;

  AnnouncementLoginType loginType = AnnouncementLoginType.normal;

  String? username;
  String? password;

  String? code;

  ///organization tag name
  String? organization;

  ///Apple bundle identifier for apple sign in
  String? appleBundleId;

  ///firebase cloud message token
  String? fcmToken;

  static void reInstance({
    String? host,
    String? tag,
  }) {
    if (host != null) AnnouncementHelper.host = host;
    if (tag != null) AnnouncementHelper.tag = tag;
    _instance = AnnouncementHelper();
  }

  void setLocale(Locale locale) {
    if (locale.languageCode == 'zh' || locale.languageCode == 'en') {
      dio.options.headers['lapplicationocale'] = locale.languageCode;
    } else {
      dio.options.headers['locale'] = 'en';
    }
  }

  Future<bool> reLogin(GeneralCallback<GeneralResponse> callback) async {
    final AnnouncementLoginData? loginData = await login(
      username: username,
      password: password,
      callback: GeneralCallback<AnnouncementLoginData>(
        onSuccess: (AnnouncementLoginData loginData) => AnnouncementLoginData,
        onFailure: callback.onFailure,
        onError: callback.onError,
      ),
    );
    return loginData != null;
  }

  Future<AnnouncementLoginData?> login({
    required String? username,
    required String? password,
    GeneralCallback<AnnouncementLoginData>? callback,
  }) async {
    try {
      final Response<Map<String, dynamic>> response = await dio.post(
        '/login',
        data: <String, String?>{
          'username': username,
          'password': password,
          'fcmToken': fcmToken,
        },
      );
      final AnnouncementLoginData loginData =
          AnnouncementLoginData.fromJson(response.data!);
      setAuthorization(loginData.key);
      this.username = username;
      this.password = password;
      loginType = AnnouncementLoginType.normal;
      if (callback != null) {
        callback.onSuccess(loginData);
      }
      return loginData;
    } on DioError catch (dioError) {
      if (callback == null) {
        rethrow;
      } else {
        if (dioError.isUnauthorized) {
          callback.onError(
            GeneralResponse(
              statusCode: 401,
              message: ApLocalizations.current.loginFail,
            ),
          );
        } else {
          callback.onFailure(dioError);
        }
      }
    }
    return null;
  }

  Future<AnnouncementLoginData?> googleLogin({
    required String? idToken,
    GeneralCallback<AnnouncementLoginData>? callback,
  }) async {
    try {
      final Response<Map<String, dynamic>> response = await dio.post(
        '/oauth2/google/token',
        data: <String, String?>{
          'token': idToken,
          'fcmToken': fcmToken,
        },
      );
      final AnnouncementLoginData loginData =
          AnnouncementLoginData.fromJson(response.data!);
      setAuthorization(loginData.key);
      code = idToken;
      loginType = AnnouncementLoginType.google;
      if (callback != null) {
        callback.onSuccess(loginData);
      }
      return loginData;
    } on DioError catch (dioError) {
      if (callback == null) {
        rethrow;
      } else {
        if (dioError.isUnauthorized) {
          callback.onError(
            GeneralResponse(
              statusCode: 401,
              message: dioError.response?.data as String? ??
                  ApLocalizations.current.unknownError,
            ),
          );
        }
        callback.onFailure(dioError);
      }
    }
    return null;
  }

  Future<AnnouncementLoginData?> appleLogin({
    required String idToken,
    GeneralCallback<AnnouncementLoginData>? callback,
  }) async {
    try {
      final Response<Map<String, dynamic>> response = await dio.post(
        '/oauth2/apple/token',
        data: <String, String?>{
          'token': idToken,
          'fcmToken': fcmToken,
          'bundleId': appleBundleId
        },
      );
      final AnnouncementLoginData loginData =
          AnnouncementLoginData.fromJson(response.data!);
      setAuthorization(loginData.key);
      code = idToken;
      loginType = AnnouncementLoginType.apple;
      if (callback != null) {
        callback.onSuccess(loginData);
      }
      return loginData;
    } on DioError catch (dioError) {
      if (callback == null) {
        rethrow;
      } else {
        if (dioError.isUnauthorized) {
          callback.onError(
            GeneralResponse(
              statusCode: 401,
              message: dioError.response?.data as String? ??
                  ApLocalizations.current.unknownError,
            ),
          );
        }
        callback.onFailure(dioError);
      }
    }
    return null;
  }

  Future<List<Announcement>?> getAllAnnouncements({
    GeneralCallback<List<Announcement>?>? callback,
  }) async {
    try {
      final Response<Map<String, dynamic>> response = await dio.get(
        '/announcements',
      );
      AnnouncementData data = AnnouncementData(data: <Announcement>[]);
      if (response.statusCode != 204) {
        data = AnnouncementData.fromJson(response.data!);
        data.data.sort((Announcement a, Announcement b) {
          return b.weight.compareTo(a.weight);
        });
      }
      if (callback != null) {
        callback.onSuccess(data.data);
      }
      return data.data;
    } on DioError catch (dioError) {
      if (callback == null) {
        rethrow;
      } else {
        callback.onFailure(dioError);
      }
    }
    return null;
  }

  Future<List<Announcement>?> getAnnouncements({
    GeneralCallback<List<Announcement>?>? callback,
    String? locale,
    List<String>? tags,
    bool sortAndRandom = true,
  }) async {
    try {
      final Response<Map<String, dynamic>> response = await dio.post(
        '/announcements',
        data: <String, dynamic>{
          'tag': tags ?? <String>[],
          'lang': locale ?? 'zh',
        },
      );
      AnnouncementData data = AnnouncementData(data: <Announcement>[]);
      if (response.statusCode != 204) {
        data = AnnouncementData.fromJson(response.data!);
        if (sortAndRandom) data.sortAndRandom();
      }
      if (callback != null) {
        callback.onSuccess(data.data);
      }
      return data.data;
    } on DioError catch (dioError) {
      if (callback == null) {
        rethrow;
      } else {
        callback.onFailure(dioError);
      }
    }
    return null;
  }

  Future<Announcement?> getAnnouncement({
    required int id,
    String? locale,
    GeneralCallback<Announcement>? callback,
  }) async {
    try {
      final Response<Map<String, dynamic>> response = await dio.get(
        '/announcements/$id',
      );
      final Announcement data = Announcement.fromJson(
        response.data!['data'] as Map<String, dynamic>,
      );
      if (callback != null) {
        callback.onSuccess(data);
      }
      return data;
    } on DioError catch (dioError) {
      if (callback == null) {
        rethrow;
      } else {
        callback.onFailure(dioError);
      }
    }
    return null;
  }

  Future<Response<dynamic>?> addAnnouncement({
    required Announcement data,
    GeneralCallback<Response<dynamic>>? callback,
    String? languageCode,
  }) async {
    try {
      data.tags ??= <String>[];
      data.tags!.addAll(
        <String>[
          languageCode ?? 'zh',
          if (organization != null) organization!,
        ],
      );
      final Response<dynamic> response = await dio.post(
        '/announcements/add',
        data: data.toUpdateJson(),
      );
      if (callback != null) {
        callback.onSuccess(response);
      }
      return response;
    } on DioError catch (dioError) {
      if (callback == null) {
        rethrow;
      } else {
        handleCrudError(dioError, callback);
      }
    }
    return null;
  }

  Future<Response<dynamic>?> updateAnnouncement({
    required Announcement data,
    GeneralCallback<Response<dynamic>>? callback,
  }) async {
    try {
      final Response<dynamic> response = await dio.put(
        '/announcements/update/${data.id}',
        data: data.toUpdateJson(),
      );
      if (callback != null) {
        callback.onSuccess(response);
      }
      return response;
    } on DioError catch (dioError) {
      if (callback == null) {
        rethrow;
      } else {
        handleCrudError(dioError, callback);
      }
    }
    return null;
  }

  Future<Response<dynamic>?> deleteAnnouncement({
    required Announcement data,
    GeneralCallback<Response<dynamic>>? callback,
  }) async {
    try {
      final Response<dynamic> response = await dio.delete(
        '/announcements/delete/${data.id}',
        data: data.toUpdateJson(),
      );
      if (callback != null) {
        callback.onSuccess(response);
      }
      return response;
    } on DioError catch (dioError) {
      if (callback == null) {
        rethrow;
      } else {
        handleCrudError(dioError, callback);
      }
    }
    return null;
  }

  Future<List<Announcement>?> getApplications({
    String? locale,
    GeneralCallback<List<Announcement>?>? callback,
  }) async {
    try {
      final Response<Map<String, dynamic>> response = await dio.get(
        '/application',
      );
      AnnouncementData data = AnnouncementData(data: <Announcement>[]);
      if (response.statusCode != 204) {
        data = AnnouncementData.fromJson(response.data!);
        data.data.sort((Announcement a, Announcement b) {
          return b.weight.compareTo(a.weight);
        });
      }
      if (callback != null) {
        callback.onSuccess(data.data);
      }
      return data.data;
    } on DioError catch (dioError) {
      if (callback == null) {
        rethrow;
      } else {
        callback.onFailure(dioError);
      }
    }
    return null;
  }

  Future<Announcement?> getApplication({
    required String id,
    String? locale,
    GeneralCallback<Announcement>? callback,
  }) async {
    try {
      final Response<Map<String, dynamic>> response = await dio.get(
        '/application/$id',
      );
      final Announcement data = Announcement.fromJson(response.data!);
      if (callback != null) {
        callback.onSuccess(data);
      }
      return data;
    } on DioError catch (dioError) {
      if (callback == null) {
        rethrow;
      } else {
        callback.onFailure(dioError);
      }
    }
    return null;
  }

  Future<Response<dynamic>?> addApplication({
    required Announcement data,
    GeneralCallback<Response<dynamic>>? callback,
    String? languageCode,
  }) async {
    try {
      data.tags ??= <String>[];
      data.tags?.addAll(
        <String>[
          languageCode ?? 'zh',
          if (organization != null) organization!,
        ],
      );
      final Response<dynamic> response = await dio.post(
        '/application',
        data: data.toUpdateJson(),
      );
      if (callback != null) {
        callback.onSuccess(response);
      }
      return response;
    } on DioError catch (dioError) {
      if (callback == null) {
        rethrow;
      } else {
        handleCrudError(dioError, callback);
      }
    }
    return null;
  }

  Future<Response<dynamic>?> approveApplication({
    required String? applicationId,
    String? reviewDescription,
    GeneralCallback<Response<dynamic>>? callback,
  }) async {
    try {
      final Response<dynamic> response = await dio.put(
        '/application/$applicationId/approve',
        data: <String, String>{
          'description': reviewDescription ?? '',
        },
      );
      if (callback != null) {
        callback.onSuccess(response);
      }
      return response;
    } on DioError catch (dioError) {
      if (callback == null) {
        rethrow;
      } else {
        handleCrudError(dioError, callback);
      }
    }
    return null;
  }

  Future<Response<dynamic>?> rejectApplication({
    required String? applicationId,
    String? reviewDescription,
    GeneralCallback<Response<dynamic>>? callback,
  }) async {
    try {
      final Response<dynamic> response = await dio.put(
        '/application/$applicationId/reject',
        data: <String, String>{
          'description': reviewDescription ?? '',
        },
      );
      if (callback != null) {
        callback.onSuccess(response);
      }
      return response;
    } on DioError catch (dioError) {
      if (callback == null) {
        rethrow;
      } else {
        handleCrudError(dioError, callback);
      }
    }
    return null;
  }

  Future<Response<dynamic>?> removeApplication({
    required String applicationId,
    GeneralCallback<Response<dynamic>>? callback,
  }) async {
    try {
      final Response<dynamic> response = await dio.delete(
        '/application/$applicationId',
      );
      if (callback != null) {
        callback.onSuccess(response);
      }
      return response;
    } on DioError catch (dioError) {
      if (callback == null) {
        rethrow;
      } else {
        handleCrudError(dioError, callback);
      }
    }
    return null;
  }

  Future<Response<dynamic>?> updateApplication({
    required Announcement data,
    GeneralCallback<Response<dynamic>>? callback,
  }) async {
    try {
      final Response<dynamic> response = await dio.put(
        '/application/${data.applicationId}',
        data: data.toUpdateApplicationJson(),
      );
      if (callback != null) {
        callback.onSuccess(response);
      }
      return response;
    } on DioError catch (dioError) {
      if (callback == null) {
        rethrow;
      } else {
        handleCrudError(dioError, callback);
      }
    }
    return null;
  }

  Future<void> getBlackList({
    required GeneralCallback<List<String>> callback,
  }) async {
    try {
      final Response<String> response = await dio.get<String>(
        '/ban',
      );
      final List<dynamic> list = jsonDecode(response.data!) as List<dynamic>;
      callback.onSuccess(list.map((dynamic e) => e as String).toList());
    } on DioError catch (dioError) {
      handleCrudError(dioError, callback);
    } catch (e) {
      callback.onError(GeneralResponse.unknownError());
      rethrow;
    }
  }

  Future<Response<dynamic>?> addBlackList({
    required String username,
    GeneralCallback<Response<dynamic>>? callback,
  }) async {
    try {
      final Response<dynamic> response = await dio.put(
        '/ban/',
        data: <String, String>{
          'username': username,
        },
      );
      if (callback != null) {
        callback.onSuccess(response);
      }
      return response;
    } on DioError catch (dioError) {
      if (callback == null) {
        rethrow;
      } else {
        handleCrudError(dioError, callback);
      }
    }
    return null;
  }

  Future<Response<dynamic>?> removeFromBlackList({
    required String username,
    GeneralCallback<Response<dynamic>>? callback,
  }) async {
    try {
      final Response<dynamic> response = await dio.delete(
        '/ban/',
        data: <String, String>{
          'username': username,
        },
      );
      if (callback != null) {
        callback.onSuccess(response);
      }
      return response;
    } on DioError catch (dioError) {
      if (callback == null) {
        rethrow;
      } else {
        handleCrudError(dioError, callback);
      }
    }
    return null;
  }

  void setAuthorization(String? key) {
    dio.options.headers['Authorization'] = 'Bearer $key';
  }

  void clearSetting() {
    username = null;
    password = null;
  }

  void handleCrudError(
    DioError dioError,
    GeneralCallback<dynamic> callback,
  ) {
    if (dioError.isNotPermission) {
      callback.onError(
        GeneralResponse(
          statusCode: notPermission,
          message: ApLocalizations.current.noPermissionHint,
        ),
      );
    } else if (dioError.isNotFoundAnnouncement) {
      callback.onError(
        GeneralResponse(
          statusCode: notPermission,
          message: ApLocalizations.current.notFoundData,
        ),
      );
    } else {
      callback.onFailure(dioError);
    }
  }
}
