import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tharad_flutter_task/core/routing/app_router.dart';
import 'package:tharad_flutter_task/core/utils/app_strings.dart';

import '../../../../../core/themes/app_text_styles.dart';

class HaveAccountText extends StatelessWidget {
  const HaveAccountText({super.key});

  @override
  Widget build(BuildContext context) => Text.rich(
    textAlign: TextAlign.center,
    TextSpan(
      text: '${AppStrings.haveAccount} ',
      style: AppTextStyles.subText,
      children: [
        TextSpan(
          text: AppStrings.login,
          recognizer: TapGestureRecognizer()..onTap = () => context.push(AppRouter.loginRoute),
          style: AppTextStyles.link,
        ),
      ],
    ),
  );
}
