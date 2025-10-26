import '../../domain/entities/register_entity.dart';

class RegisterResponseModel extends RegisterEntity {
  final String message;
  final String status;

  const RegisterResponseModel({
    required this.message,
    required this.status,
    required super.email,
    required super.username,
    required super.image,
    required super.otp,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return RegisterResponseModel(
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      email: data?['email'] ?? '',
      username: data?['username'] ?? '',
      image: data?['image'] ?? '',
      otp: data?['otp'] ?? 0,
    );
  }
}
