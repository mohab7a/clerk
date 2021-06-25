abstract class AppRegisterStates {}

class RegisterInitialState extends AppRegisterStates {}

class RegisterLoadingState extends AppRegisterStates {}

class RegisterSuccessState extends AppRegisterStates {
  final String userId;
  RegisterSuccessState(this.userId);
}

class RegisterErrorState extends AppRegisterStates {
  final String error;
  RegisterErrorState(this.error);
}

class SetUserDataSuccessState extends AppRegisterStates {}

class SetUserDataErrorState extends AppRegisterStates {}

class ChangeRegisterPasswordVisibilityState extends AppRegisterStates {}
