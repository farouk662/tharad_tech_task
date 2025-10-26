import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tharad_flutter_task/core/themes/app_text_styles.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../core/utils/constants.dart';

class OtpTextField extends StatelessWidget {
  const OtpTextField({super.key, required this.controller, this.onCompleted, this.onChanged});

  final TextEditingController controller;
  final Function(String)? onCompleted;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 45.0),
    child: PinCodeTextField(
      appContext: context,
      controller: controller,
      length: 4,
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,
      cursorColor: AppColors.primaryDark,
      textStyle: AppTextStyles.label,
      autovalidateMode: AutovalidateMode.disabled,

      // Disable auto-validation
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(Constants.borderRadius),
        fieldHeight: 50,
        fieldWidth: 50,
        activeColor: AppColors.primaryDark,
        inactiveColor: AppColors.textFieldBorder,
        selectedColor: AppColors.primaryLight,
        errorBorderColor: AppColors.error,
      ),
      animationDuration: const Duration(milliseconds: 300),
      onChanged: onChanged,
      onCompleted: onCompleted,
    ),
  );
}
