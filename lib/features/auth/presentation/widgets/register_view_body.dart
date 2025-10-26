import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tharad_flutter_task/core/helpers/show_snack_message.dart';
import 'package:tharad_flutter_task/core/routing/app_router.dart';
import 'package:tharad_flutter_task/core/themes/app_text_styles.dart';
import 'package:tharad_flutter_task/core/utils/app_strings.dart';
import 'package:tharad_flutter_task/core/utils/constants.dart';
import 'package:tharad_flutter_task/core/widgets/custom_button.dart';
import 'package:tharad_flutter_task/core/widgets/custom_loading_indicator.dart';
import 'package:tharad_flutter_task/core/widgets/custom_text_form_field.dart';
import 'package:tharad_flutter_task/core/widgets/profile_image_section.dart';
import 'package:tharad_flutter_task/features/auth/presentation/manager/register_cubit/register_cubit.dart';

import '../../../../../core/utils/validators.dart';
import '../../../../../core/widgets/app_logo.dart';
import '../manager/register_cubit/register_state.dart';
import 'have_account_text.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<RegisterCubit, RegisterState>(
    listener: (context, state) {
      if (state is RegisterFailure) {
        showSnackMessage(context, message: state.message, isError: true);
      } else if (state is RegisterSuccess) {
        FocusScope.of(context).unfocus();
        context.push(AppRouter.otpRoute, extra: state.user.email);
      }
    },
    builder: (context, state) {
      final cubit = context.read<RegisterCubit>();
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
            child: Form(
              key: cubit.formKey,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30.h),
                    // App Logo
                    const AppLogo(),
                    SizedBox(height: 40.h),
                    // Register Text
                    Text(AppStrings.register, style: AppTextStyles.pageTitle),
                    SizedBox(height: 25.h),
                    // Profile Image Section
                    ProfileImageSection(
                      profileImage: cubit.profileImage,
                      onGalleryTap: cubit.pickImage,
                      onCameraTap: () => cubit.pickImage(fromGallery: false),
                    ),
                    SizedBox(height: 12.h),
                    // Username TextFormField
                    CustomTextFormField(
                      labelText: AppStrings.username,
                      hintText: AppStrings.usernameHint,
                      controller: cubit.usernameController,
                      validator: Validators.required,
                    ),
                    SizedBox(height: 12.h),
                    // Email TextFormField
                    CustomTextFormField(
                      labelText: AppStrings.email,
                      hintText: AppStrings.emailHint,
                      controller: cubit.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.email,
                    ),
                    SizedBox(height: 12.h),
                    // Password TextFormField
                    CustomTextFormField(
                      labelText: AppStrings.password,
                      hintText: AppStrings.passwordHint,
                      controller: cubit.passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: Validators.password,
                      obscureText: true,
                    ),
                    SizedBox(height: 12.h),
                    // Confirm Password TextFormField
                    CustomTextFormField(
                      labelText: AppStrings.confirmPassword,
                      controller: cubit.confirmPasswordController,
                      hintText: AppStrings.confirmPasswordHint,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) => Validators.confirmPassword(
                        value,
                        originalPassword: cubit.passwordController.text,
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 30.h),
                    // Register Button
                    state is RegisterLoading
                        ? const CustomLoadingIndicator()
                        : CustomButton(
                            text: AppStrings.register ,
                            onPressed: () {
                              if (cubit.formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                cubit.register();
                              }
                            },
                          ),
                    SizedBox(height: 12.h),
                    // Have Account Text Button
                    const HaveAccountText(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
