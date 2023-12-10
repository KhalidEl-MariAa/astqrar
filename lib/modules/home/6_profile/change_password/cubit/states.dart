import '../../../../../models/server_response_model.dart';

abstract class ChangePasswordStates{}

class ChangePasswordInitialState extends ChangePasswordStates{}

class ChangePasswordLoadingState extends ChangePasswordStates{}

class ChangePasswordSuccessState extends ChangePasswordStates{
  final ServerResponse res;
  ChangePasswordSuccessState(this.res);
  //LoginSuccessState(this.loginModel);
}

class ChangePasswordErrorState extends ChangePasswordStates{
  final String error;
  ChangePasswordErrorState(this.error);
}