import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharad_flutter_task/core/services/get_it_service.dart';
import 'package:tharad_flutter_task/features/auth/presentation/manager/verify_otp_cubit/verify_otp_cubit.dart';
import 'package:tharad_flutter_task/features/auth/presentation/widgets/otp_view_body.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: BlocProvider(
          create: (context) => getIt<VerifyOtpCubit>(),
          child: OtpViewBody(email: email),
        ),
      );
}
