class ArabicNumbers {
  static String convertToArabicNumbers(String input) {
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return input.split('').map((char) {
      if (char.contains(RegExp(r'[0-9]'))) {
        return arabicDigits[int.parse(char)];
      } else {
        return char;
      }
    }).join();
  }
}
