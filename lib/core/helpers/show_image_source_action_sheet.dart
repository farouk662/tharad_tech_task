import 'package:flutter/material.dart';
import 'package:tharad_flutter_task/core/utils/app_strings.dart';
import 'package:tharad_flutter_task/core/widgets/custom_action_bottom_sheet.dart';

void showImageSourceActionSheet({
  required BuildContext context,
  required VoidCallback onGalleryTap,
  required VoidCallback onCameraTap,
}) {
  showCustomActionBottomSheet(
    context: context,
    title: AppStrings.chooseImage,
    options: [
      ActionSheetOption(
        icon: Icons.photo_library_outlined,
        title: AppStrings.pickFromGallery,
        subtitle: AppStrings.pickFromGallerySubtitle,
        onTap: onGalleryTap,
      ),
      ActionSheetOption(
        icon: Icons.camera_alt_outlined,
        title: AppStrings.takePhoto,
        subtitle: AppStrings.takePhotoSubtitle,
        onTap: onCameraTap,
      ),
    ],
  );
}
