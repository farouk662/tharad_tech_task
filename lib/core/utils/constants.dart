import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Constants {
  // Private constructor to prevent instantiation
  Constants._();

  // app padding
  static double horizontalPadding = 20.0.w;

  // Border Radius
  static double borderRadius = 8.0.r;


  // Text Fields
  static double textFieldVerticalPadding = 12.0.h;
  static double textFieldHorizontalPadding = 16.0.w;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

}
