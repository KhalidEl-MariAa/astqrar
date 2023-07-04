import '../../../models/login.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessAndActiveState extends ShopLoginStates {
  final LoginModel loginModel;
  ShopLoginSuccessAndActiveState(this.loginModel);
}

class ShopLoginSuccessButInActiveState extends ShopLoginStates {
  final LoginModel loginModel;
  ShopLoginSuccessButInActiveState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates {
  final String error;
  ShopLoginErrorState(this.error);
}

class ShopLoginChangePasswordVisibility extends ShopLoginStates {}
