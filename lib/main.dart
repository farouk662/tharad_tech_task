import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharad_flutter_task/core/routing/app_router.dart';
import 'package:tharad_flutter_task/core/services/get_it_service.dart';
import 'package:tharad_flutter_task/core/services/hive_service.dart';
import 'package:tharad_flutter_task/core/themes/app_theme.dart';

import 'core/services/bloc_observer_service.dart';
import 'features/profile/presentation/manager/profile_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetITService();
  await HiveService.init();
  Bloc.observer = BlocObserverService();

  runApp(
    DevicePreview(
      // ignore: avoid_redundant_argument_values
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) =>
      ScreenUtilInit(
        designSize: const Size(370, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, _) =>
            BlocProvider(
              create: (context) => getIt<ProfileCubit>(),
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                routerConfig: AppRouter.router,
                builder: (context, child) =>
                    Directionality(textDirection: TextDirection.rtl, child: child!),
              ),
            ),
      );
}
