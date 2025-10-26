import 'package:flutter/material.dart';
import 'package:tharad_flutter_task/core/themes/app_colors.dart';
import 'package:tharad_flutter_task/core/themes/app_text_styles.dart';
import 'package:tharad_flutter_task/core/utils/app_strings.dart';

class RememberMeCheckBox extends StatefulWidget {
  const RememberMeCheckBox({super.key});

  @override
  State<RememberMeCheckBox> createState() => _RememberMeCheckBoxState();
}

class _RememberMeCheckBoxState extends State<RememberMeCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          activeColor: AppColors.primary,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value!;
            });
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        Text(AppStrings.rememberMe, style: AppTextStyles.subText),
      ],
    );
}
