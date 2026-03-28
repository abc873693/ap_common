import 'package:ap_common_flutter_core/src/l10n/strings.g.dart';
import 'package:ap_common_flutter_core/src/ui/ap_icon.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

export 'package:ap_common_flutter_core/src/l10n/strings.g.dart';
export 'package:intl/intl.dart';

/// Helper to set locale for both slang and Intl.
/// Call this from your app when changing locale.
Future<AppLocale> setApLocale(AppLocale locale) async {
  final result = await LocaleSettings.setLocale(locale);
  Intl.defaultLocale = locale.flutterLocale.toString();
  return result;
}

/// Helper to set locale from a Flutter [Locale].
Future<AppLocale> setApLocaleFromFlutter(Locale locale) async {
  final appLocale = AppLocaleUtils.parseLocaleParts(
    languageCode: locale.languageCode,
    scriptCode: locale.scriptCode,
    countryCode: locale.countryCode,
  );
  return setApLocale(appLocale);
}

/// Helper to use device locale for both slang and Intl.
Future<AppLocale> useApDeviceLocale() async {
  final result = await LocaleSettings.useDeviceLocale();
  Intl.defaultLocale = result.flutterLocale.toString();
  return result;
}

extension ApExtension on Translations {
  String get dateTimeLocale {
    final current = LocaleSettings.currentLocale;
    if (current == AppLocale.zhHantTw) {
      return 'zh-TW';
    } else {
      return 'en-US';
    }
  }

  String get locale {
    final current = LocaleSettings.currentLocale;
    if (current == AppLocale.zhHantTw) {
      return 'zh-TW';
    } else {
      return 'en-US';
    }
  }

  String get iconText {
    switch (ApIcon.code) {
      case ApIcon.filled:
        return filled;
      case ApIcon.outlined:
      default:
        return outlined;
    }
  }

  List<String> get weekdaysCourse => <String>[
        mon,
        tue,
        wed,
        thu,
        fri,
        sat,
        sun,
      ];

  List<String> get weekdays => <String>[
        sunday,
        monday,
        tuesday,
        wednesday,
        thursday,
        friday,
        saturday,
      ];
}

extension DioExceptionI18nExtension on DioException {
  String? get i18nMessage {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return t.timeoutMessage;
      case DioExceptionType.badCertificate:
        return t.unknownError;
      case DioExceptionType.badResponse:
        if (response!.data is Map<String, dynamic>) {
          //ignore: avoid_dynamic_calls
          return (response!.data['description'] ?? message) as String;
        } else {
          return message;
        }
      case DioExceptionType.connectionError:
        return t.noInternet;
      case DioExceptionType.unknown:
        return t.unknownError;
      case DioExceptionType.cancel:
        return null;
    }
  }

  bool get isJsonResponse {
    return type == DioExceptionType.badResponse &&
        response!.data is Map<String, dynamic>;
  }

  String? get falconMessage {
    // Define in falcon description
    if (isJsonResponse) {
      //ignore: avoid_dynamic_calls
      return (response!.data['description'] ?? message) as String;
    } else {
      return null;
    }
  }
}
