import 'package:ap_common/models/general_response.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

export 'package:dio/dio.dart';
export 'package:ap_common/models/general_response.dart';

class GeneralCallback<T> {
  final Function(DioError e) onFailure;
  final Function(GeneralResponse e) onError;
  final Function(T data) onSuccess;

  GeneralCallback({
    @required this.onFailure,
    @required this.onError,
    @required this.onSuccess,
  });

  factory GeneralCallback.simple(
      BuildContext context, Function(T data) onSuccess) {
    return GeneralCallback(
      onFailure: (DioError e) => ApUtils.handleDioError(context, e),
      onError: (GeneralResponse e) => ApUtils.showToast(context, e.message),
      onSuccess: onSuccess,
    );
  }
}
