import 'dart:ui';

class L10n {
  static final all = [
    const Locale('en', 'US'),
    const Locale('ja', 'JP'),
  ];

  static String? getFlag(String code) {
    switch (code) {
      case 'en':
        return '🇺🇸';
      case 'ja':
        return '🇯🇵';
      default:
        return '🇺🇸';
    }
  }
}
