import '../../domain/entities/otp_entity.dart';

class OtpResponseModel extends OtpEntity {
  final String status;

  const OtpResponseModel({required super.message, required this.status});

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) => OtpResponseModel(message: json['message'] ?? '', status: json['status'] ?? '');
}
