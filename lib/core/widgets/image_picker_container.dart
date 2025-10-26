
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tharad_flutter_task/core/themes/app_colors.dart';
import 'package:tharad_flutter_task/core/themes/app_text_styles.dart';
import 'package:tharad_flutter_task/core/utils/app_assets.dart';
import 'package:tharad_flutter_task/core/utils/app_strings.dart';
import 'package:tharad_flutter_task/core/utils/constants.dart';

class ImagePickerContainer extends StatelessWidget {
  const ImagePickerContainer({super.key, required this.onPressed});
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => DottedBorder(
      options: RoundedRectDottedBorderOptions(
        dashPattern: [15, 10],
        strokeWidth: 2,
        color: AppColors.primaryLight,
        radius: Radius.circular(Constants.borderRadius),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 80.h,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: AppColors.textFieldFilledColor,
            shadowColor: AppColors.textFieldFilledColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constants.borderRadius),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppAssets.cameraIcon),
              SizedBox(height: 6.h),
              Text(AppStrings.allowedFiles, style: AppTextStyles.caption),
              Text(AppStrings.maxFileSize, style: AppTextStyles.caption.copyWith(fontSize: 8.sp)),
            ],
          ),
        ),
      ),
    );
}
