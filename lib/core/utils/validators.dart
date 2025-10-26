class Validators {
  Validators._(); // Private constructor to prevent instantiation

  // Validates if the input is not empty
  static String? required(String? value, {String errorMessage = 'هذا الحقل مطلوب'}) {
    if (value == null || value.trim().isEmpty) {
      return errorMessage;
    }
    return null;
  }

  // Validates email format
  static String? email(String? value, {String errorMessage = 'أدخل عنوان بريد إلكتروني صالح'}) {
    if (value == null || value.trim().isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return errorMessage;
    }
    return null;
  }

  // Validates password (minimum length, complexity)
  static String? password(
    String? value, {
    String errorMessage = 'كلمة المرور يجب أن تكون 8 أحرف على الأقل مع رقم وحرف خاص',
    int minLength = 8,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    if (value.length < minLength) {
      return 'كلمة المرور يجب أن تكون $minLength أحرف على الأقل';
    }
    final hasNumber = RegExp(r'[0-9]').hasMatch(value);
    // final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
    // if (!hasNumber || !hasSpecialChar) {
    //   return errorMessage;
    // }
    return null;
  }

  // Validates confirm password (matches original password)
  static String? confirmPassword(
    String? value, {
    required String originalPassword,
    String errorMessage = 'كلمة المرور التأكيدية لا تتطابق مع كلمة المرور الأصلية',
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'تأكيد كلمة المرور مطلوب';
    }
    if (value.trim() != originalPassword.trim()) {
      return errorMessage;
    }
    return null;
  }

  // Combines multiple validators for a single field
  static String? combine(List<String? Function(String?)> validators, String? value) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}
