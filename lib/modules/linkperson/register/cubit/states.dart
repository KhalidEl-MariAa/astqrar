import 'package:astarar/models/server_response_model.dart';

abstract class RegisterLinkPersonStates{}

class RegisterLinkPersonInitialState extends RegisterLinkPersonStates{}

class RegisterLinkPersonLoadingState extends RegisterLinkPersonStates{}

class RegisterLinkPersonSuccessState extends RegisterLinkPersonStates{
 final ServerResponse registerDelegateModel;
 RegisterLinkPersonSuccessState(this.registerDelegateModel);

}

class RegisterLinkPersonErrorState extends RegisterLinkPersonStates{
  final String error;
  RegisterLinkPersonErrorState(this.error);
}