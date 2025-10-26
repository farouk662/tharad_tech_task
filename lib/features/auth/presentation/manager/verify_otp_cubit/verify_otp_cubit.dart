import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repo/auth_repo.dart';
import 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  final AuthRepo authRepo;

  VerifyOtpCubit(this.authRepo) : super(VerifyOtpInitial());
  final otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();


  Future<void> verifyOtp({required String email, required String otp}) async {
    emit(VerifyOtpLoading());
    final result = await authRepo.verifyOtp(email: email, otp: otp);

    result.fold(
      (failure) => emit(VerifyOtpFailure(failure.message)),
      (otpEntity) => emit(VerifyOtpSuccess(otpEntity)),
    );
  }

  @override
  Future<void> close() {
    // otpController.dispose();
    return super.close();
  }
}
