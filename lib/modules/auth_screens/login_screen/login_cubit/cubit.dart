import 'package:clerk/modules/auth_screens/login_screen/login_cubit/states.dart';
import 'package:clerk/shared/constants.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLoginCubit extends Cubit<AppLoginStates> {
  AppLoginCubit() : super(LoginInitialState());

  static AppLoginCubit get(context) => BlocProvider.of(context);

  void signInWithEmailAndPassword({
    String email,
    String password,
  }) async {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userId = value.user.uid;
      emit(LoginSuccessState(value.user.uid));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeLoginPasswordVisibilityState());
  }
}
