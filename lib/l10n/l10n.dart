import 'dart:ui';

class L10n {
  static final all = [
    const Locale('en', 'US'),
    const Locale('ja', 'JP'),
  ];

  static String? getFlag(String code) {
    switch (code) {
      case 'en':
        return 'πΊπΈ';
      case 'ja':
        return 'π―π΅';
      default:
        return 'πΊπΈ';
    }
  }
}
