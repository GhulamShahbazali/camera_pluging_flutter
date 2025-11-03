
import '../constants/app/api_constants.dart';

class Validators {
  /// Validates phone number format
  static bool isValidPhone(String phone) {
    final phoneRegex = RegExp(r'^\+?[\d\s-()]{10,}$');
    return phoneRegex.hasMatch(phone);
  }

  /// Validates scan type
  static bool isValidScanType(String scanType) {
    const validScanTypes = [
      ApiConstants.thermal,
      ApiConstants.ultrasonic,
      ApiConstants.magnetic,
      ApiConstants.optical,
      ApiConstants.pressure
    ];
    return validScanTypes.contains(scanType.toLowerCase());
  }

  /// Validates if string is not empty
  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// Validates if string has minimum length
  static bool hasMinLength(String value, int minLength) {
    return value.length >= minLength;
  }

  /// Validates if string has maximum length
  static bool hasMaxLength(String value, int maxLength) {
    return value.length <= maxLength;
  }
}
