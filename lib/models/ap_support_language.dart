enum ApSupportLanguage {
  system,
  zh,
  en,
}

extension ApSupportLanguageExtension on ApSupportLanguage {
  String get code {
    switch (index) {
      case 1:
        return ApSupportLanguageConstants.ZH;
      case 2:
        return ApSupportLanguageConstants.EN;
      case 0:
      default:
        return ApSupportLanguageConstants.SYSTEM;
    }
  }

  static int fromCode(String code) {
    switch (code) {
      case ApSupportLanguageConstants.ZH:
        return 1;
      case ApSupportLanguageConstants.EN:
        return 2;
      case ApSupportLanguageConstants.SYSTEM:
      default:
        return 0;
    }
  }
}

class ApSupportLanguageConstants {
  static const SYSTEM = 'system';
  static const ZH = 'zh';
  static const EN = 'en';
}
