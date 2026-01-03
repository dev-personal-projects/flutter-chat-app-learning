import 'package:country_picker/country_picker.dart';

class PhoneFormatter {
  PhoneFormatter._();

  static String formatPhoneNumber(String phoneNumber, Country country) {
    final cleaned = phoneNumber.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    if (cleaned.startsWith(country.phoneCode)) {
      return '+$cleaned';
    }
    return '+${country.phoneCode}$cleaned';
  }

  static bool isValidPhoneNumber(String phoneNumber, Country country) {
    final cleaned = phoneNumber.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    if (cleaned.isEmpty) return false;
    if (!RegExp(r'^\d+$').hasMatch(cleaned)) return false;
    return cleaned.length >= 7 && cleaned.length <= 15;
  }

  static String removeFormatting(String phoneNumber) {
    return phoneNumber.replaceAll(RegExp(r'[\s\-\(\)\+]'), '');
  }

  static String formatForDisplay(String phoneNumber) {
    final cleaned = removeFormatting(phoneNumber);
    final buffer = StringBuffer();
    for (int i = 0; i < cleaned.length; i++) {
      if (i > 0 && i % 3 == 0) {
        buffer.write(' ');
      }
      buffer.write(cleaned[i]);
    }
    return buffer.toString();
  }
}
