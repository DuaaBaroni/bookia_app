import 'package:bookia_app/features/auth/data/models/login_parms.dart';
import 'package:bookia_app/features/auth/data/models/auth_repo/auth_repo.dart';
import 'package:bookia_app/features/auth/data/models/register_parms.dart';
import 'package:bookia_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    emit(AuthLoadingState());

    var response = await AuthRepo.login(
      LoginParams(
        email: emailController.text,
        password: passwordController.text,
      ),
    );

    if (response != null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(message: "Login failed"));
    }
  }

  Future<void> register() async {
    emit(AuthLoadingState());
    var response = await AuthRepo.register(
      RegisterParams(
        name: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
        passwordConfirmation: passwordConfirmationController.text,
      ),
    );
    if (response != null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(message: "Failed to register"));
    }
  }
}
