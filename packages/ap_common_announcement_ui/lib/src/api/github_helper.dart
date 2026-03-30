import 'dart:convert';

import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';
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

  Future<ApiResult<Map<String, List<Announcement>?>>> getAnnouncement({
    required String gitHubUsername,
    required String hashCode,
    required String tag,
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
      return ApiSuccess<Map<String, List<Announcement>?>>(map);
    } on DioException catch (e) {
      return ApiFailure<Map<String, List<Announcement>?>>(e);
    } on Exception catch (_) {
      return ApiError<Map<String, List<Announcement>?>>(
        GeneralResponse.unknownError(),
      );
    }
  }
}
