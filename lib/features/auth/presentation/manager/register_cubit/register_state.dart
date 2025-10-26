
import '../../../domain/entities/register_entity.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterEntity user;

  RegisterSuccess(this.user);
}

class RegisterFailure extends RegisterState {
  final String message;

  RegisterFailure(this.message);
}

class RegisterImagePicked extends RegisterState {}
