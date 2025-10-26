part of 'profile_cubit.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final UserEntity user;

  ProfileLoaded(this.user);
}

final class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}


final class ProfileUpdated extends ProfileState {}
final class ProfileUpdateLoading extends ProfileState {}

final class ProfileImageUpdated extends ProfileState {}
