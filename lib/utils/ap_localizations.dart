import 'package:ap_common/resources/ap_icon.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../l10n/l10n.dart';

export 'package:ap_common/models/ap_support_language.dart';
export 'package:ap_common/l10n/l10n.dart';
export 'package:intl/intl.dart';

extension ApExtension on ApLocalizations {
  String get dateTimeLocale {
    if (Intl.defaultLocale.contains('TW'))
      return 'zh-TW';
    else
      return 'en-US';
  }

  String get locale {
    if (Intl.defaultLocale.contains('TW'))
      return 'zh-TW';
    else
      return 'en-US';
  }

  String get iconText {
    switch (ApIcon.code) {
      case ApIcon.FILLED:
        return filled;
      case ApIcon.OUTLINED:
      default:
        return outlined;
    }
  }

  List<String> get weekdaysCourse => [
        mon,
        tue,
        wed,
        thu,
        fri,
        sat,
        sun,
      ];

  List<String> get weekdays => [
        sunday,
        monday,
        tuesday,
        wednesday,
        thursday,
        friday,
        saturday,
      ];

  @deprecated
  String dioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.DEFAULT:
        return noInternet;
      case DioErrorType.CONNECT_TIMEOUT:
      case DioErrorType.RECEIVE_TIMEOUT:
      case DioErrorType.SEND_TIMEOUT:
        return timeoutMessage;
        break;
      case DioErrorType.RESPONSE:
        return dioError.message;
        break;
      case DioErrorType.CANCEL:
      default:
        return null;
    }
  }
}

extension DioErrorI18nExtension on DioError {
  String get i18nMessage {
    switch (type) {
      case DioErrorType.DEFAULT:
        return ApLocalizations.current.noInternet;
      case DioErrorType.CONNECT_TIMEOUT:
      case DioErrorType.RECEIVE_TIMEOUT:
      case DioErrorType.SEND_TIMEOUT:
        return ApLocalizations.current.timeoutMessage;
        break;
      case DioErrorType.RESPONSE:
        if (response.data is Map<String, dynamic>)
          return response.data['title'] ?? message;
        else
          return message;
        break;
      case DioErrorType.CANCEL:
      default:
        return null;
    }
  }
}
