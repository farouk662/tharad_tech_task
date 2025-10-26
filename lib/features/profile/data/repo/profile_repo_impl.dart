import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:tharad_flutter_task/core/error/failure.dart';
import 'package:tharad_flutter_task/core/network/dio_service.dart';
import 'package:tharad_flutter_task/core/network/endpoints.dart';
import 'package:tharad_flutter_task/core/services/hive_service.dart';
import 'package:tharad_flutter_task/features/profile/data/models/user_model.dart';

import 'package:tharad_flutter_task/features/profile/domain/entities/user_entity.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/services/logger_service.dart';
import '../../domain/repo/profile_repo.dart';
import '../models/user_response_model.dart';

class ProfileRepoImpl implements ProfileRepo {
  final DioService _dioService;

  ProfileRepoImpl(this._dioService);

  @override
  Future<Either<Failure, UserEntity>> getProfile() async {
    try {
      final response = await _dioService.get(EndPoints.profileDetails);
      final responseModel = UserResponseModel.fromJson(response);

      if (responseModel.status == "success" && responseModel.data != null) {
        final user = responseModel.data!;
        // ✅ Save profile in cache
        await HiveService.saveProfile(user.toJson());
        return right(user.toEntity());
      } else {
        return left(ServerFailure(responseModel.message));
      }
    } on NetworkException catch (e) {
      logger.error("getProfile error: ${e.message}");

      // ✅ Try to get profile from cache when API fails
      final cachedProfile = HiveService.getProfile();
      if (cachedProfile != null) {
        final user = UserModel.fromJson(cachedProfile);
        return right(user.toEntity());
      }
      // No cache found
      return left(ServerFailure(e.message));
    } catch (e) {
      logger.error("Unexpected getProfile error: $e");
      return left(const ServerFailure("Unexpected error occurred. Try again."));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProfile({
    required String username,
    required String email,
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
    required File image,
  }) async {
    try {
      final response = await _dioService.post(
        EndPoints.updateProfile,
        data: {
          "username": username,
          "email": email,
          "password": oldPassword.isEmpty ? null : oldPassword,
          "new_password": newPassword,
          "new_password_confirmation": confirmNewPassword,
          "image": image,
          "_method": "PUT",
        },
      );
      final responseModel = UserResponseModel.fromJson(response);

      if (responseModel.status == "success" && responseModel.data != null) {
        final user = responseModel.data!;
        // ✅ Save profile in cache
        await HiveService.saveProfile(user.toJson());
        return right(unit);
      } else {
        return left(ServerFailure(responseModel.message));
      }
    } on NetworkException catch (e) {
      logger.error("updateProfile error: ${e.message}");
      // No cache found
      return left(ServerFailure(e.message));
    } catch (e) {
      logger.error("Unexpected updateProfile error: $e");
      return left(const ServerFailure("Unexpected error occurred. Try again."));
    }
  }
}
