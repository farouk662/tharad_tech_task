import 'user_model.dart';

class UserResponseModel {
  final String message;
  final UserModel? data;
  final String status;

  UserResponseModel({required this.message, this.data, required this.status});

  factory UserResponseModel.fromJson(Map<String, dynamic> json) => UserResponseModel(
      message: json['message']??'',
      data: json['data'] != null ? UserModel.fromJson(json['data']) : null,
      status: json['status'] ?? '',
    );
}
