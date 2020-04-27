import 'dart:convert';

import 'package:ap_common/callback/general_callback.dart';
import 'package:ap_common/models/new_response.dart';
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

  Future<Map<String, List<News>>> getNews({
    @required String gitHubUsername,
    @required String hashCode,
    @required String tag,
    @required GeneralCallback<Map<String, List<News>>> callback,
  }) async {
    try {
      var response = await Dio().get(
        '$BASE_PATH/$gitHubUsername/$hashCode/raw/'
            '${tag}_news.json',
      );
      Map<String, List<News>> map = Map();
      Map<String, dynamic> json = jsonDecode(response.data);
      json.forEach((key, data) {
        if (key != 'data')
          map[key] = NewsResponse
              .fromJson(data)
              .data;
      });
      return callback?.onSuccess(map);
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
