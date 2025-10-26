import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tharad_flutter_task/core/themes/app_colors.dart';
import 'package:tharad_flutter_task/core/themes/app_text_styles.dart';
import 'package:tharad_flutter_task/core/utils/app_assets.dart';
import 'package:tharad_flutter_task/core/utils/app_strings.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) => Container(
    decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
    padding: EdgeInsets.symmetric(vertical: 16.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Container()),
        const SizedBox(width: 50),
        Text(AppStrings.profile, style: AppTextStyles.appBarTitle),
        const Spacer(),
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xffe9eeee).withValues(alpha: .2),
              ),
              child: SvgPicture.asset(AppAssets.notificationIcon, width: 16.w, height: 16.h),
            ),
            onPressed: () {},
          ),
        ),
      ],
    ),
  );
}
