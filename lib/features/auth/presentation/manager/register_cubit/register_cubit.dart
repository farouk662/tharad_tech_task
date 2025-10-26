import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharad_flutter_task/features/auth/domain/repo/auth_repo.dart';
import '../../../../../core/services/image_picker_service.dart';
import '../../../../../core/utils/app_strings.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo registerRepo;

  RegisterCubit(this.registerRepo) : super(RegisterInitial());
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? profileImage; // New property to store picked image

  /// Pick image from gallery
  Future<void> pickImage({bool fromGallery = true}) async {
    try {
      final imageService = ImagePickerService();
      final image = await imageService.pickImage(fromGallery: fromGallery);

      if (image == null) {
        emit(RegisterFailure(AppStrings.invalidImage));
        return;
      }

      if (!imageService.isFileSizeValid(image)) {
        emit(RegisterFailure(AppStrings.imageTooLarge));
        return;
      }

      profileImage = image;
      emit(RegisterImagePicked());
    } catch (e) {
      emit(RegisterFailure(AppStrings.failedToPickImage));
    }
  }

  Future<void> register() async {
    emit(RegisterLoading());
    if (profileImage == null) {
      emit(RegisterFailure(AppStrings.pleasePickedImage));
      return;
    }

    final result = await registerRepo.register(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      confirmPassword: confirmPasswordController.text.trim(),
      username: usernameController.text.trim(),
      image: profileImage!,
    );

    result.fold(
      (failure) => emit(RegisterFailure(failure.message)),
      (user) => emit(RegisterSuccess(user)),
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
