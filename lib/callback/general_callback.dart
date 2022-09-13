import 'package:ap_common/models/general_response.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:flutter/widgets.dart';

export 'package:ap_common/models/general_response.dart';
export 'package:dio/dio.dart';

typedef DioErrorCallback = Function(DioError);
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
      onFailure: (DioError e) => ApUtils.showToast(context, e.i18nMessage),
      onError: (GeneralResponse e) => ApUtils.showToast(context, e.message),
      onSuccess: onSuccess,
    );
  }

  final Function(DioError e) onFailure;
  final Function(GeneralResponse response) onError;
  final Function(T data) onSuccess;

  static DioErrorCallback onFailureCallback(BuildContext context) =>
      (DioError dioError) => ApUtils.showToast(context, dioError.i18nMessage);

  static GeneralResponseCallback onErrorCallback(BuildContext context) =>
      (GeneralResponse generalResponse) =>
          ApUtils.showToast(context, generalResponse.message);
}
