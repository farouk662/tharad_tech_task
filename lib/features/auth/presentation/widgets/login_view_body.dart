import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tharad_flutter_task/core/routing/app_router.dart';
import 'package:tharad_flutter_task/core/utils/app_strings.dart';
import 'package:tharad_flutter_task/core/utils/constants.dart';
import 'package:tharad_flutter_task/core/widgets/custom_button.dart';
import 'package:tharad_flutter_task/core/widgets/custom_text_form_field.dart';
import 'package:tharad_flutter_task/features/auth/presentation/manager/login_cubit/login_cubit.dart';

import '../../../../../core/utils/validators.dart';
import '../../../../../core/widgets/app_logo.dart';
import '../../../../core/helpers/show_snack_message.dart';
import '../../../../core/themes/app_text_styles.dart';
import '../../../../core/widgets/custom_loading_indicator.dart';
import '../../../profile/presentation/manager/profile_cubit.dart';
import '../manager/login_cubit/login_state.dart';
import 'dont_have_account_text.dart';
import 'forget_password_text_button.dart';
import 'remember_me_check_box.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<LoginCubit, LoginState>(
    listener: (context, state) {
      if (state is LoginSuccess) {
        FocusScope.of(context).unfocus();
        context.go(AppRouter.profileRoute);
        context.read<ProfileCubit>().fetchProfile();
      } else if (state is LoginFailure) {
        showSnackMessage(context, message: state.message, isError: true);
        if (state.message.contains('Please verify your OTP before logging in')) {
          Future.delayed(const Duration(seconds: 2), () {
            context.push(AppRouter.otpRoute, extra: context.read<LoginCubit>().emailController.text);
          });
        }
      }
    },
    builder: (context, state) {
      final cubit = context.read<LoginCubit>();
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
          child: Form(
            key: cubit.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 90.h),
                // app logo
                const AppLogo(),
                SizedBox(height: 100.h),
                // login title
                Text(AppStrings.login, style: AppTextStyles.pageTitle),
                SizedBox(height: 25.h),
                // email text form field
                CustomTextFormField(
                  labelText: AppStrings.email,
                  hintText: AppStrings.emailHint,
                  controller: cubit.emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                ),
                SizedBox(height: 12.h),
                // password text form field
                CustomTextFormField(
                  labelText: AppStrings.password,
                  hintText: AppStrings.passwordHint,
                  keyboardType: TextInputType.visiblePassword,
                  controller: cubit.passwordController,
                  validator: Validators.password,
                  obscureText: true,
                ),
                SizedBox(height: 8.h),
                // remember me checkbox and forget password text button
                const Row(children: [RememberMeCheckBox(), Spacer(), ForgetPasswordTextButton()]),
                SizedBox(height: 40.h),
                // login button
                state is LoginLoading
                    ? const CustomLoadingIndicator()
                    : CustomButton(
                        text: AppStrings.login,
                        onPressed: () {
                          if (cubit.formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            cubit.login();
                          }
                        },
                      ),
                SizedBox(height: 12.h),
                // don't have account text
                const DontHaveAccountText(),
              ],
            ),
          ),
        ),
      );
    },
  );
}
