import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharad_flutter_task/core/themes/app_text_styles.dart';
import 'package:tharad_flutter_task/core/utils/app_strings.dart';
import 'package:tharad_flutter_task/core/widgets/custom_profile_image_picker.dart';
import 'package:tharad_flutter_task/core/widgets/image_picker_container.dart';

import '../helpers/show_image_source_action_sheet.dart';

class ProfileImageSection extends StatelessWidget {
  final File? profileImage;
  final String? networkImageUrl;
  final VoidCallback onGalleryTap;
  final VoidCallback onCameraTap;

  const ProfileImageSection({
    super.key,
    required this.profileImage,
    this.networkImageUrl,
    required this.onGalleryTap,
    required this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.profileImage, style: AppTextStyles.label),
        SizedBox(height: 6.h),
        profileImage == null && networkImageUrl == null
            ? ImagePickerContainer(
                onPressed: () {
                  showImageSourceActionSheet(
                    context: context,
                    onGalleryTap: onGalleryTap,
                    onCameraTap: onCameraTap,
                  );
                },
              )
            : CustomProfileImagePicker(
                localImage: profileImage,
                networkImageUrl: networkImageUrl,
                onPickImage: () {
                  showImageSourceActionSheet(
                    context: context,
                    onGalleryTap: onGalleryTap,
                    onCameraTap: onCameraTap,
                  );
                },
              ),
      ],
    ),
  );
}
