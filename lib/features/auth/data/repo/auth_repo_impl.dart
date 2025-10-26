import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tharad_flutter_task/core/services/hive_service.dart';
import 'package:tharad_flutter_task/core/services/logger_service.dart';
import 'package:tharad_flutter_task/features/auth/domain/entities/otp_entity.dart';
import 'package:tharad_flutter_task/features/auth/domain/entities/register_entity.dart';

import '../../../../../core/network/dio_service.dart';
import '../../../../../core/network/endpoints.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/services/get_it_service.dart';
import '../../data/models/login_response_model.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repo/auth_repo.dart';
import '../models/otp_response_model.dart';
import '../models/register_response_model.dart';

class AuthRepoImpl implements AuthRepo {
  final DioService _dioService;

  AuthRepoImpl(this._dioService);

  @override
  Future<Either<Failure, LoginEntity>> login({required String email, required String password}) async {
    try {
      final response = await _dioService.post(
        EndPoints.login,
        data: {"email": email, "password": password},
      );

      final model = LoginResponseModel.fromJson(response);

      if (model.status == "success") {
        // cache the token
        await HiveService.saveToken(model.token);
        _dioService.setAuthToken(model.token);
        return right(model);
      } else {
        return left(ServerFailure(model.message));
      }
    } on NetworkException catch (e) {
      logger.error("Login error: ${e.message}");
      return left(ServerFailure((e.message)));
    } catch (e) {
      logger.error("Unexpected login error: $e");
      return left(const ServerFailure("حدث خطأ غير متوقع. حاول مرة أخرى."));
    }
  }

  @override
  Future<Either<Failure, RegisterEntity>> register({
    required String email,
    required String password,
    required String username,
    required String confirmPassword,
    required File image,
  }) async {
    try {
      final response = await _dioService.post(
        EndPoints.register,
        data: {
          "email": email,
          "password": password,
          "username": username,
          "password_confirmation": confirmPassword,
          "image": image,
        },
      );

      final model = RegisterResponseModel.fromJson(response);

      if (model.status == "success") {
        return right(model);
      } else {
        return left(ServerFailure(model.message));
      }
    } on NetworkException catch (e) {
      logger.error("Register error: ${e.message}");
      return left(ServerFailure(e.message));
    } catch (e) {
      logger.error("Unexpected register error: $e");
      return left(const ServerFailure("حدث خطأ غير متوقع. حاول مرة أخرى."));
    }
  }

  @override
  Future<Either<Failure, OtpEntity>> verifyOtp({required String email, required String otp}) async {
    try {
      final response = await _dioService.get(
        EndPoints.verifyOtp,
        queryParameters: {"email": email, "otp": otp},
      );

      final model = OtpResponseModel.fromJson(response);

      if (model.status == "success") {
        return right(model);
      } else {
        return left(ServerFailure(model.message));
      }
    } on NetworkException catch (e) {
      logger.error("OTP error: ${e.message}");
      return left(ServerFailure(e.message));
    } catch (e) {
      logger.error("Unexpected OTP error: $e");
      return left(const ServerFailure("حدث خطأ غير متوقع. حاول مرة أخرى."));
    }
  }
  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      // Call logout endpoint
      final response = await _dioService.delete(EndPoints.logout);

      // Check response status
      if (response['status'] == 'success') {
        // Clear cached token and profile
        await HiveService.clearAuthData();
        _dioService.clearAuthToken();
        return right(unit);
      } else {
        return left(ServerFailure(response['message'] ?? 'Logout failed'));
      }
    } on NetworkException catch (e) {
      logger.error("logout error: ${e.message}");
      return left(ServerFailure(e.message));
    } catch (e) {
      logger.error("Unexpected logout error: $e");
      return left(const ServerFailure("Unexpected error occurred. Try again."));
    }
  }

}
