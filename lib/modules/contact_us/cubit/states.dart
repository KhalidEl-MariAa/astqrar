import 'package:astarar/models/register_delegate_model.dart';

abstract class ContactUsStates{}

class ContactUsInitialState extends ContactUsStates{}

class ContactUsLoadingState extends ContactUsStates{}

class ContactUsSuccessState extends ContactUsStates{
  final RegisterDelegateModel contactisModel;
  ContactUsSuccessState(this.contactisModel);
//ShopLoginSuccessState(this.loginModel);
}

class ContactUsErrorState extends ContactUsStates{
  final String error;
  ContactUsErrorState(this.error);
}