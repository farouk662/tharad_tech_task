import 'package:flutter/material.dart';
import 'package:tharad_flutter_task/core/themes/app_text_styles.dart';
import '../themes/app_colors.dart';

void showSnackMessage(
    BuildContext context, {
      required String message,
      bool isError = false,
    }) {
  final backgroundColor = isError ? AppColors.error : AppColors.textLink;

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            message,
            style: AppTextStyles.snackBarMessage,
          ),
        ),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
      ),
    );
}
