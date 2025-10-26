import 'package:flutter/material.dart';
import 'package:tharad_flutter_task/core/themes/app_text_styles.dart';
import 'package:tharad_flutter_task/core/utils/app_strings.dart';

class ResendOtpText extends StatelessWidget {
  const ResendOtpText({super.key});

  @override
  Widget build(BuildContext context) => Text.rich(
    TextSpan(
      text: '${AppStrings.codeNotReceived} ',
      style: AppTextStyles.subText,
      children: [TextSpan(text: AppStrings.resend, style: AppTextStyles.link)],
    ),
    textAlign: TextAlign.center,
  );
}
