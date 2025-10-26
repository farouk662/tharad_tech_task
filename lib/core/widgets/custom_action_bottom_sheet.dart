import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';

class ActionSheetOption {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  ActionSheetOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}

Future<void> showCustomActionBottomSheet({
  required BuildContext context,
  required String title,
  required List<ActionSheetOption> options,
}) => showModalBottomSheet(
  context: context,
  backgroundColor: Colors.transparent,
  builder: (_) => Container(
    decoration: BoxDecoration(
      color: AppColors.background,
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    ),
    child: SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2.r)),
          ),

          // Title
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Text(title, style: AppTextStyles.pageTitle.copyWith(fontSize: 15.sp)),
          ),

          // Options
          ...options.map(
            (option) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  option.onTap();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.textFieldFilledColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.textFieldBorder),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(option.icon, color: Colors.white, size: 24.sp),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(option.title, style: AppTextStyles.label),
                            SizedBox(height: 4.h),
                            Text(option.subtitle, style: AppTextStyles.caption),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded, color: AppColors.icon, size: 16.sp),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    ),
  ),
);
