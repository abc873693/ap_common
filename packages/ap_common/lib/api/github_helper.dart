import 'dart:convert';

import 'package:ap_common/callback/general_callback.dart';
import 'package:ap_common_core/ap_common_core.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class GitHubHelper {
  GitHubHelper() {
    cookieJar = CookieJar();
    dio = Dio();
    dio.interceptors.add(CookieManager(cookieJar));
    cookieJar.loadForRequest(Uri.parse(basePath));
  }

  static GitHubHelper? get instance {
    return _instance ??= GitHubHelper();
  }

  static const String basePath = 'https://gist.githubusercontent.com/';

  static GitHubHelper? _instance;

  late Dio dio;

  late CookieJar cookieJar;

  Future<Map<String, List<Announcement>>?> getAnnouncement({
    required String gitHubUsername,
    required String hashCode,
    required String tag,
    GeneralCallback<Map<String, List<Announcement>?>>? callback,
  }) async {
    try {
      final Response<String> response = await dio.get(
        '$basePath/$gitHubUsername/$hashCode/raw/'
        '${tag}_announcement.json',
      );
      final Map<String, List<Announcement>?> map =
          <String, List<Announcement>>{};
      final dynamic json = jsonDecode(response.data!);
      if (json is Map<String, Map<String, dynamic>>) {
        json.forEach((String key, Map<String, dynamic> data) {
          if (key != 'data') {
            map[key] = AnnouncementData.fromJson(data).data;
          }
        });
      }
      return callback?.onSuccess(map) as Map<String, List<Announcement>>;
    } on DioException catch (e) {
      if (callback != null) {
        callback.onFailure(e);
      } else {
        rethrow;
      }
    } on Exception catch (_) {
      callback?.onError(GeneralResponse.unknownError());
      rethrow;
    }
    return null;
  }
}
