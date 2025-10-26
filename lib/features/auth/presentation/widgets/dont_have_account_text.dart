import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tharad_flutter_task/core/routing/app_router.dart';
import 'package:tharad_flutter_task/core/utils/app_strings.dart';

import '../../../../../core/themes/app_text_styles.dart';

class DontHaveAccountText extends StatelessWidget {
  const DontHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) => Text.rich(
    TextSpan(
      text: '${AppStrings.dontHaveAccount} ',
      style: AppTextStyles.subText,
      children: [
        TextSpan(
          text: AppStrings.register,
          style: AppTextStyles.link,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              FocusScope.of(context).unfocus();

              context.push(AppRouter.registerRoute);},
        ),
      ],
    ),
    textAlign: TextAlign.center,
  );

}
