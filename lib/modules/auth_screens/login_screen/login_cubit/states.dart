abstract class AppLoginStates {}

class LoginInitialState extends AppLoginStates {}

class LoginLoadingState extends AppLoginStates {}

class LoginSuccessState extends AppLoginStates {
  final String userId;

  LoginSuccessState(this.userId);
}

class LoginErrorState extends AppLoginStates {
  final String error;
  LoginErrorState(this.error);
}

class ChangeLoginPasswordVisibilityState extends AppLoginStates {}
