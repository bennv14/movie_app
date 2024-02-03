import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/pages/sign_up_screen/sign_up_body.dart';
import 'package:movie_app/injection_container.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(getIt()),
      child: const SignUpBody(),
    );
  }
}