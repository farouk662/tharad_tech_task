import 'package:get_it/get_it.dart';
import 'package:tharad_flutter_task/features/auth/data/repo/auth_repo_impl.dart';
import 'package:tharad_flutter_task/features/auth/presentation/manager/logout_cubit/logout_cubit.dart';
import 'package:tharad_flutter_task/features/auth/presentation/manager/verify_otp_cubit/verify_otp_cubit.dart';
import 'package:tharad_flutter_task/features/profile/data/repo/profile_repo_impl.dart';
import 'package:tharad_flutter_task/features/profile/domain/repo/profile_repo.dart';
import '../../features/auth/domain/repo/auth_repo.dart';
import '../../features/auth/presentation/manager/login_cubit/login_cubit.dart';
import '../../features/auth/presentation/manager/register_cubit/register_cubit.dart';
import '../../features/profile/presentation/manager/profile_cubit.dart';
import '../network/dio_service.dart';

final getIt = GetIt.instance;

void setupGetITService() {
  getIt.registerLazySingleton<DioService>(() => DioService());

  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(getIt<DioService>()));
  getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepoImpl(getIt<DioService>()));

  getIt.registerFactory(() => LoginCubit(getIt<AuthRepo>()));
  getIt.registerFactory(() => RegisterCubit(getIt<AuthRepo>()));
  getIt.registerFactory(() => VerifyOtpCubit(getIt<AuthRepo>()));
  getIt.registerFactory(() => ProfileCubit(getIt<ProfileRepo>()));
  getIt.registerFactory(() => LogoutCubit(getIt<AuthRepo>()));
}
