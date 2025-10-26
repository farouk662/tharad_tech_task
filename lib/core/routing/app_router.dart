import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tharad_flutter_task/core/services/hive_service.dart';
import 'package:tharad_flutter_task/features/auth/presentation/views/login_view.dart';
import 'package:tharad_flutter_task/features/auth/presentation/views/otp_view.dart';
import 'package:tharad_flutter_task/features/auth/presentation/views/register_view.dart';
import 'package:tharad_flutter_task/features/profile/presentation/views/profile_view.dart';

import 'custom_transition_page.dart';

class AppRouter {
  static const String loginRoute = '/login';
  static const String otpRoute = '/otp';
  static const String registerRoute = '/register';
  static const String profileRoute = '/profile';
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();


  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,

    initialLocation: _getInitialRoute(),
    routes: [
      GoRoute(
        path: loginRoute,
        pageBuilder: (context, state) =>
            AppPage(child: const LoginView()),
      ),
      GoRoute(
        path: registerRoute,
        pageBuilder: (context, state) =>
            AppPage(child: const RegisterView(), transitionType: TransitionType.slideFromRight),
      ),
      GoRoute(
        path: otpRoute,
        pageBuilder: (context, state) {
          final email = state.extra as String;
          return AppPage(
            child: OtpView(email: email),
            transitionType: TransitionType.slideFromRight,
          );
        },
      ),
      GoRoute(
        path: profileRoute,
        pageBuilder: (context, state) =>
            AppPage(child: const ProfileView(), transitionType: TransitionType.slideFromRight),
      ),
    ],
  );

  /// Decide which screen to start with
  static String _getInitialRoute() {
    final token = HiveService.getToken();
    if (token != null && token.isNotEmpty) {
      return profileRoute; // user logged in
    } else {
      return loginRoute; // user not logged in
    }
  }
}
