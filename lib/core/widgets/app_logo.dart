import 'package:flutter/material.dart';
import 'package:tharad_flutter_task/core/utils/app_assets.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Image.asset(AppAssets.appLogo,
    width: size.width * 0.55,
      fit: BoxFit.cover,
    );
  }
}
