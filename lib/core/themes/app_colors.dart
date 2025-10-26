import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand Colors
  static const Color primaryDark = Color(0xFF265355); // Deep teal-green
  static const Color primaryLight = Color(0xFF5CC7A3); // Mint green
  static const Color primary = primaryDark; // default primary tone

  //  Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [primaryDark, primaryLight],
  );

  // Backgrounds
  static const Color background = Colors.white;

  // Text
  static const Color textLabel = Color(0xFF1F0606); // OTP title, main dark text
  static const Color textSecondary = Color(0xFF998C8C); // for hint/subtext like "00:59 Sec"
  static const Color textPrimary = Color(0xFF0D1D1E); // labels above TextFields
  static const Color textFieldText = Color(0xFF265355); // actual input text
  static const Color textLink = Color(0xFF42867B); // “نسيت كلمة المرور؟”

  // Borders and icons
  static const Color border = Color(0xFFE5E7EB);
  static const Color icon = Color(0xFF6B7280);

  // Status colors
  static const Color success = Color(0xFF16A34A);
  static const Color error = Color(0xFFFF1020);

  // Text Field
  static const Color textFieldFilledColor = Color(0xFFF4F7F6);
  static const Color textFieldBorder = Color(0xFFF0E6DE);

  // Buttons
  static const Color buttonText = Colors.white;
}
