import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharad_flutter_task/features/auth/domain/repo/auth_repo.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this._authRepo) : super(LogoutInitial());
  final AuthRepo _authRepo;

  Future<void> logout() async {
    emit(LogoutLoading());

    final result = await _authRepo.logout();

    result.fold((failure) => emit(LogoutError(failure.message)), (_) => emit(LogoutSuccess()));
  }
}
