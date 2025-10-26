import '../../../domain/entities/otp_entity.dart';

abstract class VerifyOtpState {}

class VerifyOtpInitial extends VerifyOtpState {}

class VerifyOtpLoading extends VerifyOtpState {}

class VerifyOtpSuccess extends VerifyOtpState {
  final OtpEntity otpEntity;

  VerifyOtpSuccess(this.otpEntity);
}

class VerifyOtpFailure extends VerifyOtpState {
  final String message;

  VerifyOtpFailure(this.message);
}
