import '../../domain/entities/login_entity.dart';

class LoginResponseModel extends LoginEntity {
  final String message;
  final String status;

  const LoginResponseModel({
    required this.message,
    required this.status,
    required super.token,
    required super.username,
    required super.email,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return LoginResponseModel(
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      token: data['token'] ?? '',
      username: data['username'] ?? '',
      email: data['email'] ?? '',
    );
  }
}
