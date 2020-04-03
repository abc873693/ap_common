import 'package:ap_common/models/general_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

export 'package:dio/dio.dart';

class GeneralCallback {
  final Function(DioError e) onFailure;
  final Function(GeneralResponse e) onError;

  GeneralCallback({
    @required this.onFailure,
    @required this.onError,
  });
}
