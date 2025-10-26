import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharad_flutter_task/core/services/get_it_service.dart';
import 'package:tharad_flutter_task/features/auth/presentation/manager/logout_cubit/logout_cubit.dart';

import '../manager/profile_cubit.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: BlocProvider(
        create: (context) => getIt<LogoutCubit>(),
        child: const Column(
          children: [
            CustomAppBar(),
            Expanded(
              child: ProfileViewBody(),
            ),
          ],
        ),
      ),
    ),
  );
}
