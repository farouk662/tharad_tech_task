import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tharad_flutter_task/core/utils/app_assets.dart';

import '../themes/app_colors.dart';

class CustomProfileImagePicker extends StatelessWidget {
  final File? localImage; // If user picked an image
  final String? networkImageUrl; // If image comes from API
  final VoidCallback onPickImage; // When camera/gallery button is tapped
  final double height;
  final double radius;

  const CustomProfileImagePicker({
    super.key,
    required this.onPickImage,
    this.localImage,
    this.networkImageUrl,
    this.height = 90,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(5.r),
    decoration: BoxDecoration(
      color: AppColors.textFieldFilledColor,
      borderRadius: BorderRadius.circular(radius),
    ),
    child: Stack(
      children: [
        // Display local image or fallback to network image or placeholder
        ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: localImage != null
              ? Image.file(localImage!, height: height.h, fit: BoxFit.cover)
              : (networkImageUrl != null && networkImageUrl!.isNotEmpty)
              ? CachedNetworkImage(imageUrl: networkImageUrl!, height: height.h, fit: BoxFit.cover)
              : Container(
                  height: height.h,
                  width: double.infinity,
                  color: Colors.grey.shade200,
                  alignment: Alignment.center,
                  child: const Icon(Icons.person, color: Colors.grey, size: 40),
                ),
        ),

        // Camera button
        Positioned(
          left: -5,
          top: -6,
          child: IconButton(
            onPressed: onPickImage,
            icon: Container(
              padding: EdgeInsets.all(5.r),
              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.textLink),
              child: SvgPicture.asset(
                AppAssets.cameraIcon,
                height: 16,
                width: 16,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
