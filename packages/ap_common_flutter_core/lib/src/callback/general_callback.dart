import 'package:ap_common_core/ap_common_core.dart';
import 'package:ap_common_flutter_core/src/l10n/ap_localizations.dart';
import 'package:ap_common_flutter_core/src/utilities/ui_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

export 'package:dio/dio.dart';

typedef DioExceptionCallback = Function(DioException);
typedef GeneralResponseCallback = Function(GeneralResponse);

///TODO: 放此原因是配合 i18n 相關需要，並且此 API 未來會移除，故不放在 `ap_common_core`
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
      onFailure: (DioException e) {
        if (e.i18nMessage case final String message?) {
          UiUtil.instance.showToast(context, message);
        }
      },
      onError: (GeneralResponse e) =>
          UiUtil.instance.showToast(context, e.message),
      onSuccess: onSuccess,
    );
  }

  final Function(DioException e) onFailure;
  final Function(GeneralResponse response) onError;
  final Function(T data) onSuccess;

  static DioExceptionCallback onFailureCallback(BuildContext context) =>
      (DioException dioException) {
        if (dioException.i18nMessage case final String message?) {
          UiUtil.instance.showToast(context, message);
        }
      };

  static GeneralResponseCallback onErrorCallback(BuildContext context) =>
      (GeneralResponse generalResponse) =>
          UiUtil.instance.showToast(context, generalResponse.message);
}
