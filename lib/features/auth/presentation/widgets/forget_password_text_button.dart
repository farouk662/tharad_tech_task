import 'package:flutter/material.dart';
import 'package:tharad_flutter_task/core/themes/app_text_styles.dart';
import 'package:tharad_flutter_task/core/utils/app_strings.dart';

class ForgetPasswordTextButton extends StatelessWidget {
  const ForgetPasswordTextButton({super.key});

  @override
  Widget build(BuildContext context) => Text(AppStrings.forgotPassword, style: AppTextStyles.link);
}
