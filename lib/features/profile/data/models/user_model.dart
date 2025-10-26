import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.username,
    required super.email,
    required super.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
    );

  Map<String, dynamic> toJson() => { 'username': username, 'email': email, 'image': image};
  UserEntity toEntity() => UserEntity(
      username: username,
      email: email,
      image: image,
    );
}
