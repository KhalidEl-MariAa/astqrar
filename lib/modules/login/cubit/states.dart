

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessAndActiveState extends ShopLoginStates 
{
}

class ShopLoginSuccessButInActiveState extends ShopLoginStates 
{
}

class ShopLoginErrorState extends ShopLoginStates {
  final String error;
  ShopLoginErrorState(this.error);
}

class ShopLoginChangePasswordVisibility extends ShopLoginStates {}
