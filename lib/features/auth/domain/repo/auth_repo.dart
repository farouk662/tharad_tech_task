import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/login_entity.dart';
import '../entities/otp_entity.dart';
import '../entities/register_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, LoginEntity>> login({required String email, required String password});

  Future<Either<Failure, RegisterEntity>> register({
    required String email,
    required String password,
    required String username,
    required String confirmPassword,
    required File image,
  });

  Future<Either<Failure, OtpEntity>> verifyOtp({required String email, required String otp});
  Future<Either<Failure, Unit>> logout();

}
