import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tharad_flutter_task/core/helpers/show_snack_message.dart';
import 'package:tharad_flutter_task/core/routing/app_router.dart';
import 'package:tharad_flutter_task/core/themes/app_text_styles.dart';
import 'package:tharad_flutter_task/core/utils/app_strings.dart';
import 'package:tharad_flutter_task/core/widgets/custom_button.dart';
import 'package:tharad_flutter_task/core/widgets/custom_loading_indicator.dart';
import 'package:tharad_flutter_task/features/auth/presentation/manager/verify_otp_cubit/verify_otp_cubit.dart';
import 'package:tharad_flutter_task/features/auth/presentation/widgets/countdown_text.dart';
import 'package:tharad_flutter_task/features/auth/presentation/widgets/otp_text_field.dart';
import 'package:tharad_flutter_task/features/auth/presentation/widgets/resend_otp_text.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/app_logo.dart';
import '../manager/verify_otp_cubit/verify_otp_state.dart';

class OtpViewBody extends StatelessWidget {
  const OtpViewBody({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) => BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
    listener: (context, state) {
      if (state is VerifyOtpFailure) {
        showSnackMessage(context, message: state.message, isError: true);
      }
      if (state is VerifyOtpSuccess) {
        showSnackMessage(context, message: state.otpEntity.message);
        // Future.delayed(const Duration(seconds: 1), () {
          context.go(AppRouter.loginRoute);
        // });
      }
    },
    builder: (context, state) {
      final cubit = context.read<VerifyOtpCubit>();
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
        child: Form(
          key: cubit.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 120.h),
                // app logo
                const AppLogo(),
                SizedBox(height: 40.h),
                // verification code
                Text(AppStrings.verificationCode, style: AppTextStyles.pageTitle),
                SizedBox(height: 10.h),
                Text(
                  AppStrings.completeAccountMessage,
                  style: AppTextStyles.subText.copyWith(color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 100.h),
                // otp text field
                OtpTextField(controller: cubit.otpController),
                SizedBox(height: 8.h),
                // Resend otp text
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(children: [CountdownText(), Spacer(), ResendOtpText()]),
                ),
                SizedBox(height: 20.h),
                // continue button
                state is VerifyOtpLoading
                    ? const CustomLoadingIndicator()
                    : CustomButton(
                        text: AppStrings.continueText,
                        onPressed: () {
                          if (cubit.otpController.text.length == 4) {
                            cubit.verifyOtp(email: email, otp: cubit.otpController.text);
                          } else {
                            showSnackMessage(context, message: 'الرجاء إدخال 4 أرقام', isError: true);
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
