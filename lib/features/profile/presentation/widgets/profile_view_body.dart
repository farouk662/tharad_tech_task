import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tharad_flutter_task/core/helpers/show_snack_message.dart';
import 'package:tharad_flutter_task/core/utils/app_strings.dart';
import 'package:tharad_flutter_task/core/utils/constants.dart';
import 'package:tharad_flutter_task/core/widgets/custom_button.dart';
import 'package:tharad_flutter_task/core/widgets/custom_loading_indicator.dart';
import 'package:tharad_flutter_task/core/widgets/custom_text_form_field.dart';
import 'package:tharad_flutter_task/features/profile/presentation/manager/profile_cubit.dart';
import 'package:tharad_flutter_task/features/profile/presentation/widgets/logout_button.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../core/widgets/profile_image_section.dart';
import '../../../auth/presentation/manager/logout_cubit/logout_cubit.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<ProfileCubit, ProfileState>(
    listener: (context, state) {
      // show success and error messages
      if (state is ProfileUpdated) {
        showSnackMessage(context, message: AppStrings.changesSavedSuccessfully);
      } else if (state is ProfileError) {
        showSnackMessage(context, message: state.message, isError: true);
      }
    },
    builder: (context, state) {
      final cubit = context.read<ProfileCubit>();
      final isLogoutLoading = context.select((LogoutCubit cubit) => cubit.state is LogoutLoading);

      return Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
          ),
          child: ModalProgressHUD(
            inAsyncCall: state is ProfileLoading || isLogoutLoading,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: cubit.formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
                  child: Column(
                    children: [
                      SizedBox(height: 32.h),
                      // User name field
                      CustomTextFormField(
                        labelText: AppStrings.username,
                        hintText: AppStrings.usernameHint,
                        controller: cubit.nameController,
                        validator: Validators.required,
                      ),
                      SizedBox(height: 12.h),
                      // User email field
                      CustomTextFormField(
                        labelText: AppStrings.email,
                        hintText: AppStrings.emailHint,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.email,
                        controller: cubit.emailController,
                      ),
                      SizedBox(height: 12.h),
                      // image picker widget
                      ProfileImageSection(
                        profileImage: cubit.profileImage,
                        onGalleryTap: cubit.pickImage,
                        onCameraTap: () => cubit.pickImage(fromGallery: false),
                      ),
                      SizedBox(height: 12.h),
                      // old password field
                      CustomTextFormField(
                        labelText: AppStrings.oldPassword,
                        hintText: AppStrings.passwordHint,
                        keyboardType: TextInputType.visiblePassword,
                        validator: Validators.password,
                        controller: cubit.oldPasswordController,
                        obscureText: true,
                      ),
                      SizedBox(height: 12.h),
                      // new password field
                      CustomTextFormField(
                        labelText: AppStrings.newPassword,
                        hintText: AppStrings.newPasswordHint,
                        keyboardType: TextInputType.visiblePassword,
                        controller: cubit.newPasswordController,
                        validator: Validators.password,
                        obscureText: true,
                      ),
                      SizedBox(height: 12.h),
                      // confirm new password field
                      CustomTextFormField(
                        labelText: AppStrings.confirmNewPassword,
                        hintText: AppStrings.confirmPasswordHint,
                        controller: cubit.confirmPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) => Validators.confirmPassword(
                          value,
                          originalPassword: cubit.newPasswordController.text,
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 30.h),
                      // save changes button
                      state is ProfileUpdateLoading
                          ? const CustomLoadingIndicator()
                          : CustomButton(
                              text: AppStrings.saveChanges,
                              onPressed: () {
                                if (cubit.formKey.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  cubit.updateProfile();
                                }
                              },
                            ),
                      SizedBox(height: 12.h),
                      const LogoutButton(),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
