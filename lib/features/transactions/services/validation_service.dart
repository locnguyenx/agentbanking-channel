class ValidationService {
  /// Validates JomPAY Ref-1 account number format.
  static bool isValidRef1(String ref1) {
    if (ref1.isEmpty) return false;
    final regex = RegExp(r'^[a-zA-Z0-9]{3,20}$');
    return regex.hasMatch(ref1);
  }

  /// Validates Malaysian Biller Code format.
  static bool isValidBillerCode(String code) {
    final regex = RegExp(r'^\d{3,6}$');
    return regex.hasMatch(code);
  }

  /// Validates Malaysian Phone Number format.
  /// Format: 01x-xxxxxxx or 01x-xxxxxxxx
  static bool isValidPhoneNumber(String phone) {
    final regex = RegExp(r'^01[0-9]-?\d{7,8}$');
    return regex.hasMatch(phone);
  }
}
