import 'package:clerk/modules/auth_screens/register_screen/register_cubit/states.dart';
import 'package:clerk/shared/constants.dart';
import 'package:clerk/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRegisterCubit extends Cubit<AppRegisterStates> {
  AppRegisterCubit() : super(RegisterInitialState());

  static AppRegisterCubit get(context) => BlocProvider.of(context);

  void createEmailAndPassword(
      {String email, String password, String name, String userName}) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userId = value.user.uid;
      setUserData(email, value.user.uid, name, password, userName);
      emit(RegisterSuccessState(value.user.uid));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  void setUserData(
      String email, String uId, String name, String password, String userName) {
    UserModel model = UserModel(
      uId: uId,
      name: name,
      email: email,
      password: password,
      userImage: "https://i.stack.imgur.com/l60Hf.png",
      userName: userName,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SetUserDataErrorState());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeRegisterPasswordVisibilityState());
  }
}
