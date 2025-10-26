import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharad_flutter_task/core/utils/app_strings.dart';
import 'package:tharad_flutter_task/features/profile/domain/entities/user_entity.dart';
import 'package:tharad_flutter_task/features/profile/domain/repo/profile_repo.dart';

import '../../../../core/services/image_picker_service.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._repo) : super(ProfileInitial());
  final ProfileRepo _repo;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  UserEntity? user;
  File? profileImage; // New property to store picked image

  /// Pick image from gallery
  Future<void> pickImage({bool fromGallery = true}) async {
    try {
      final imageService = ImagePickerService();
      final image = await imageService.pickImage(fromGallery: fromGallery);

      if (image == null) {
        emit(ProfileError(AppStrings.invalidImage));
        return;
      }

      if (!imageService.isFileSizeValid(image)) {
        emit(ProfileError(AppStrings.imageTooLarge));
        return;
      }

      profileImage = image;
      emit(ProfileImageUpdated());
    } catch (e) {
      emit(ProfileError(AppStrings.failedToPickImage));
    }
  }

  Future<void> fetchProfile() async {
    emit(ProfileLoading());
    final result = await _repo.getProfile();
    result.fold((failure) => emit(ProfileError(failure.message)), (data) {
      user = data;
      nameController.text = data.username;
      emailController.text = data.email;
      emit(ProfileLoaded(data));
    });
  }

  void updateProfile() async {
    emit(ProfileUpdateLoading());
    if (profileImage == null) {
      emit(ProfileError(AppStrings.pleasePickedImage));
      return;
    }

    final result = await _repo.updateProfile(
      username: nameController.text,
      email: emailController.text,
      oldPassword: oldPasswordController.text,
      newPassword: newPasswordController.text,
      image: profileImage!,
      confirmNewPassword: confirmPasswordController.text,
    );
    result.fold((failure) => emit(ProfileError(failure.message)), (_) {
      emit(ProfileUpdated());
      fetchProfile();
    });
  }


}
