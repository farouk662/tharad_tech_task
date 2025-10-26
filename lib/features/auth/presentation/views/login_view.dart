import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/get_it_service.dart';
import '../manager/login_cubit/login_cubit.dart';
import '../widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      body: BlocProvider(
        create: (context) => getIt<LoginCubit>(),
        child: const LoginViewBody(),
      ),
    );
}
