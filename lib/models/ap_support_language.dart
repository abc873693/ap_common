enum ApSupportLanguage {
  system,
  zh,
  en,
}

extension ApSupportLanguageExtension on ApSupportLanguage {
  String get code {
    switch (index) {
      case 1:
        return ApSupportLanguageConstants.zh;
      case 2:
        return ApSupportLanguageConstants.en;
      case 0:
      default:
        return ApSupportLanguageConstants.system;
    }
  }

  static int fromCode(String code) {
    switch (code) {
      case ApSupportLanguageConstants.zh:
        return 1;
      case ApSupportLanguageConstants.en:
        return 2;
      case ApSupportLanguageConstants.system:
      default:
        return 0;
    }
  }
}

class ApSupportLanguageConstants {
  static const String system = 'system';
  static const String zh = 'zh';
  static const String en = 'en';
}
