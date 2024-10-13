import 'package:ap_common_flutter_core/src/l10n/intl/messages_all.dart';
import 'package:ap_common_flutter_core/src/l10n/l10n.dart';
import 'package:ap_common_flutter_core/src/ui/ap_icon.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multiple_localization/multiple_localization.dart';

export 'package:ap_common_flutter_core/src/l10n/l10n.dart';
export 'package:intl/intl.dart';

extension ApExtension on ApLocalizations {
  String get dateTimeLocale {
    if (Intl.defaultLocale!.contains('TW')) {
      return 'zh-TW';
    } else {
      return 'en-US';
    }
  }

  String get locale {
    if (Intl.defaultLocale!.contains('TW')) {
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
        return ApLocalizations.current.timeoutMessage;
      case DioExceptionType.badCertificate:
        return ApLocalizations.current.unknownError;
      case DioExceptionType.badResponse:
        if (response!.data is Map<String, dynamic>) {
          //ignore: avoid_dynamic_calls
          return (response!.data['description'] ?? message) as String;
        } else {
          return message;
        }
      case DioExceptionType.connectionError:
        return ApLocalizations.current.noInternet;
      case DioExceptionType.unknown:
        return ApLocalizations.current.unknownError;
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

const _ApLocalizationsDelegate apLocalizationsDelegate =
    _ApLocalizationsDelegate();

class _ApLocalizationsDelegate extends LocalizationsDelegate<ApLocalizations> {
  const _ApLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ApLocalizations.delegate.isSupported(locale);
  }

  @override
  Future<ApLocalizations> load(Locale locale) {
    return MultipleLocalizations.load(
      initializeMessages,
      locale,
      (String l) => ApLocalizations.load(locale),
    );
  }

  @override
  bool shouldReload(LocalizationsDelegate<ApLocalizations> old) {
    return false;
  }
}
