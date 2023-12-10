

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessAndActiveState extends LoginStates { }
class LoginSuccessButInActiveState extends LoginStates { }

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}

class LoginChangePasswordVisibility extends LoginStates {}
