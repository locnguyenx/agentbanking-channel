class OpenApiValidators {
  static String? length(String? value, {int? minLen, int? maxLen}) {
    if (value == null) return null;
    if (maxLen != null && value.length > maxLen) {
      return 'Cannot exceed $maxLen characters';
    }
    if (minLen != null && value.length < minLen) {
      return 'Must be at least $minLen characters';
    }
    return null;
  }

  static String? minMax(String? value, {num? min, num? max}) {
    if (value == null || value.isEmpty) return null;
    final numValue = num.tryParse(value);
    if (numValue == null) return 'Invalid number';
    if (min != null && numValue < min) {
      return 'Amount must be at least $min';
    }
    if (max != null && numValue > max) {
      return 'Amount cannot exceed $max';
    }
    return null;
  }

  static String? regex(String? value, String pattern) {
    if (value == null || value.isEmpty) return null;
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Invalid format';
    }
    return null;
  }
}
