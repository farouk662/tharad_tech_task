class AppStrings {
  AppStrings._(); // prevent instantiation

  //  Authentication
  static const String login = 'تسجيل الدخول';
  static const String register = 'إنشاء حساب جديد';
  static const String forgotPassword = 'هل نسيت كلمة المرور؟';
  static const String email = 'البريد الإلكتروني';
  static const String password = 'كلمة المرور';
  static const String confirmPassword = 'تأكيد كلمة المرور';
  static const String oldPassword = 'كلمة المرور القديمة';
  static const String newPassword = 'كلمة المرور الجديدة';
  static const String confirmNewPassword = 'تأكيد كلمة المرور الجديدة';
  static const String username = 'اسم المستخدم';
  static const String rememberMe = 'تذكرني';
  static const String haveAccount = 'لديك حساب؟';
  static const String dontHaveAccount = 'ليس لديك حساب؟';
  static const String logout = 'تسجيل الخروج';

  //  Profile
  static const String profile = 'الملف الشخصي';
  static const String profileImage = 'الصورة الشخصية';
  static const String follow = 'المتابعة';
  static const String saveChanges = 'حفظ التغيرات';
  static const String changesSavedSuccessfully = 'تم حفظ التغيرات بنجاح';
  //  OTP / Verification
  static const String verificationCode = 'رمز التحقق';
  static const String resend = 'إعادة ارسال';
  static const String codeNotReceived = 'لم يصلك رمز ؟';
  static const String completeAccountMessage =
      'لاستكمال فتح حسابك ادخل رمز التحقق المرسل عبر البريد الإلكتروني';

  //  Common Buttons
  static const String continueText = 'المتابعة';
  static const String logoutSuccess="وداعًا مؤقتًا! تم تسجيل خروجك بنجاح.";


  //  Text Field Hints
  static const String emailHint = 'أدخل بريدك الإلكتروني';
  static const String passwordHint = 'أدخل كلمة المرور';
  static const String confirmPasswordHint = 'أعد إدخال كلمة المرور';
  static const String usernameHint = 'أدخل اسم المستخدم';
  static const String oldPasswordHint = 'أدخل كلمتك القديمة';
  static const String newPasswordHint = 'أدخل كلمة المرور الجديدة';

  // pick image
  static const String chooseImage = 'اختر الصورة';
  static const String pickFromGallery = 'اختر من المعرض';
  static const String pickFromGallerySubtitle = 'اختر صورة من معرض الصور';
  static const String takePhoto = 'التقط صورة';
  static const String takePhotoSubtitle = 'التقط صورة جديدة بالكاميرا';
  static const String invalidImage = 'الرجاء اختيار صورة صالحة';
  static const String pleasePickedImage="نحتاج إلى صورة الملف الشخصي لإتمام التحديث، الرجاء اختيار صورة";
  static const String imageTooLarge = 'حجم الصورة يجب أن يكون أقل من 5 ميغابايت';
  static const String failedToPickImage = 'فشل اختيار الصورة';
  static const String maxFileSize = 'الحد الأقصى : 5MB';
  static const String allowedFiles = 'الملفات المسموح بها : JPEG , PNG';

}
