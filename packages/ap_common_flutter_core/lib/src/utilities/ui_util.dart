import 'package:ap_common_core/injector.dart';
import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';
import 'package:flutter/widgets.dart';

abstract class UiUtil {
  static UiUtil get instance => injector.get<UiUtil>();

  void showToast(
    BuildContext context,
    String message, {
    int? gravity,
  });
}

extension ApiResultErrorHandler<T> on ApiResult<T> {
  void showErrorToast(BuildContext context) {
    switch (this) {
      case ApiSuccess<T>():
        break;
      case ApiFailure<T>(:final DioException exception):
        if (exception.i18nMessage case final String message?) {
          UiUtil.instance.showToast(context, message);
        }
      case ApiError<T>(:final GeneralResponse response):
        UiUtil.instance.showToast(context, response.message);
    }
  }

  bool get isSuccess => this is ApiSuccess<T>;
}
