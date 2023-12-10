import '../../../../../models/server_response_model.dart';

abstract class ContactUsStates{}

class ContactUsInitialState extends ContactUsStates{}

class ContactUsLoadingState extends ContactUsStates{}

class ContactUsSuccessState extends ContactUsStates{
  final ServerResponse contactisModel;
  ContactUsSuccessState(this.contactisModel);
//LoginSuccessState(this.loginModel);
}

class ContactUsErrorState extends ContactUsStates{
  final String error;
  ContactUsErrorState(this.error);
}