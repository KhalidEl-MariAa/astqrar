import 'package:astarar/models/register_delegate_model.dart';

abstract class ChangePasswordStates{}

class ChangePasswordInitialState extends ChangePasswordStates{}

class ChangePasswordLoadingState extends ChangePasswordStates{}

class ChangePasswordSuccessState extends ChangePasswordStates{
  final RegisterDelegateModel changePasswordModel;
  ChangePasswordSuccessState(this.changePasswordModel);
  //ShopLoginSuccessState(this.loginModel);
}

class ChangePasswordErrorState extends ChangePasswordStates{
  final String error;
  ChangePasswordErrorState(this.error);
}