import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tharad_flutter_task/core/helpers/show_snack_message.dart';
import 'package:tharad_flutter_task/core/routing/app_router.dart';
import 'package:tharad_flutter_task/core/themes/app_text_styles.dart';
import 'package:tharad_flutter_task/core/utils/app_strings.dart';
import 'package:tharad_flutter_task/features/auth/presentation/manager/logout_cubit/logout_cubit.dart';

import '../../../../../core/themes/app_colors.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocListener<LogoutCubit, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            showSnackMessage(context, message: AppStrings.logoutSuccess);
            context.push(AppRouter.loginRoute);}
          else if (state is LogoutError) {
            showSnackMessage(context, message: state.message, isError: true);
          }
        },
        child: TextButton(
          onPressed: () {
            context.read<LogoutCubit>().logout();
          },
          child: Text(
            AppStrings.logout,
            style: AppTextStyles.link.copyWith(color: AppColors.error, fontSize: 12.sp),
          ),
        ),
      );
}
