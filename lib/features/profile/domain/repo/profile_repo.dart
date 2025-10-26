import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tharad_flutter_task/core/error/failure.dart';
import 'package:tharad_flutter_task/features/profile/domain/entities/user_entity.dart';

abstract class ProfileRepo {
  Future<Either<Failure, UserEntity>> getProfile();

  Future<Either<Failure, Unit>> updateProfile({
    required String username,
    required String email,
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
    required File image,
  });

}
