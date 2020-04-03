import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

export 'package:dio/dio.dart';

class GeneralCallback {
  final Function(DioError e) onFailure;
  final Function(dynamic e) onError;

  GeneralCallback({
    @required this.onFailure,
    @required this.onError,
  });
}
