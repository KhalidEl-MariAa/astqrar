import '../../../models/forget_password.dart';


abstract class ForgetPasswordStates{}

class ForgetPasswordInitialState extends ForgetPasswordStates{}

class ForgetPasswordLoadingState extends ForgetPasswordStates{}

class ForgetPasswordSuccessState extends ForgetPasswordStates{
 final ForgetPassword forgetPasswordModel;
 ForgetPasswordSuccessState(this.forgetPasswordModel);

}

class ForgetPasswordErrorState extends ForgetPasswordStates{
  final String error;
  ForgetPasswordErrorState(this.error);
}


class ChangePasswordByCodeLoadingState extends ForgetPasswordStates{}

class ChangePasswordByCodeSuccessState extends ForgetPasswordStates{
 final dynamic changePassswordByCodeModel;
 ChangePasswordByCodeSuccessState(this.changePassswordByCodeModel);

}

class ChangePasswordByCodeErrorState extends ForgetPasswordStates{
  final String error;
  ChangePasswordByCodeErrorState(this.error);
}

class CheckCodeLoadingState extends ForgetPasswordStates{}

class CheckCodeSuccessState extends ForgetPasswordStates{}

class CheckCodeErrorState extends ForgetPasswordStates{
  final String error;
  CheckCodeErrorState(this.error);
}