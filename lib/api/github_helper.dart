import 'package:ap_common/callback/general_callback.dart';
import 'package:ap_common/models/ap_support_language.dart';
import 'package:ap_common/models/new_response.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/cupertino.dart';

class GitHubHelper {
  static const BASE_PATH = 'https://gist.githubusercontent.com/';

  static Dio dio;
  static CookieJar cookieJar;

  static GitHubHelper _instance;

  static bool isLogin = false;

  static GitHubHelper get instance {
    if (_instance == null) {
      _instance = GitHubHelper();
      cookieJar = CookieJar();
      dio = Dio();
      dio.interceptors.add(CookieManager(cookieJar));
      cookieJar.loadForRequest(Uri.parse(BASE_PATH));
    }
    return _instance;
  }

  Future<List<News>> getNews({
    @required String gitHubUsername,
    @required String hashCode,
    @required String languageCode,
    @required GeneralCallback<List<News>> callback,
  }) async {
    try {
      var response = await Dio().get(
        '$BASE_PATH/$gitHubUsername/$hashCode/raw/'
        'nsysu_news_$languageCode.json',
      );
      return callback?.onSuccess(NewsResponse.fromRawJson(response.data).data);
    } on DioError catch (e) {
      if (callback != null)
        callback?.onFailure(e);
      else
        throw e;
    } on Exception catch (e) {
      callback?.onError(GeneralResponse.unknownError());
      throw e;
    }
    return null;
  }
}
