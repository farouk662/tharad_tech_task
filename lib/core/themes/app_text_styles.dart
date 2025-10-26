import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // ==================== PAGE TITLES ====================
  // For main page titles like "إنشاء حساب جديد", "تسجيل الدخول"
  static TextStyle pageTitle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // ==================== LABELS ====================
  // For field labels like "رقم الهاتف", "كلمة المرور"
  static TextStyle label = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  // ==================== TEXT FIELDS ====================

  static TextStyle hint = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textFieldText,
  );

  // ==================== BUTTONS ====================
  // For button text
  static TextStyle button = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.buttonText,
  );

  // ==================== LINKS ====================
  // For clickable text like "نسيت كلمة المرور؟"
  static TextStyle link = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textLink,
    decoration: TextDecoration.underline,
  );
  static TextStyle subText = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );


  static TextStyle snackBarMessage = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  // For secondary/helper text
  static const TextStyle bodySecondary = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  // ==================== SPECIAL ====================
  // For OTP/verification code display
  static const TextStyle otpTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // For timer like "00:59 Sec"
  static const TextStyle timer = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  // For error messages
  static const TextStyle error = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.error,
    height: 1.4,
  );

  // For AppBar title
  static TextStyle appBarTitle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // For small captions
  static TextStyle caption = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
}
