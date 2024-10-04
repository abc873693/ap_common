import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common_core/ap_common_core.dart';
import 'package:flutter/widgets.dart';

export 'package:dio/dio.dart';

typedef DioExceptionCallback = Function(DioException);
typedef GeneralResponseCallback = Function(GeneralResponse);

class GeneralCallback<T> {
  GeneralCallback({
    required this.onFailure,
    required this.onError,
    required this.onSuccess,
  });

  factory GeneralCallback.simple(
    BuildContext context,
    Function(T data) onSuccess,
  ) {
    return GeneralCallback<T>(
      onFailure: (DioException e) => ApUtils.showToast(context, e.i18nMessage),
      onError: (GeneralResponse e) => ApUtils.showToast(context, e.message),
      onSuccess: onSuccess,
    );
  }

  final Function(DioException e) onFailure;
  final Function(GeneralResponse response) onError;
  final Function(T data) onSuccess;

  static DioExceptionCallback onFailureCallback(BuildContext context) =>
      (DioException dioException) =>
          ApUtils.showToast(context, dioException.i18nMessage);

  static GeneralResponseCallback onErrorCallback(BuildContext context) =>
      (GeneralResponse generalResponse) =>
          ApUtils.showToast(context, generalResponse.message);
}
