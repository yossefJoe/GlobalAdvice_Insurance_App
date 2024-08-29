import 'package:flutter/material.dart';

class FontLoader {
  static String getFontFamily(Locale locale) {
    // Default font family for English (en)
    String fontFamily = 'Gilroy-Bold';

    // Check locale and assign appropriate font family
    if (locale.languageCode == 'ar') {
      // French locale
      fontFamily = 'Kufi-Bold';
    }
    // Add more conditions for other locales as needed

    return fontFamily;
  }
}
