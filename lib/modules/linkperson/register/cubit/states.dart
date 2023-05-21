import 'package:astarar/models/register_delegate_model.dart';

abstract class RegisterLinkPersonStates{}

class RegisterLinkPersonInitialState extends RegisterLinkPersonStates{}

class RegisterLinkPersonLoadingState extends RegisterLinkPersonStates{}

class RegisterLinkPersonSuccessState extends RegisterLinkPersonStates{
 final RegisterDelegateModel registerDelegateModel;
 RegisterLinkPersonSuccessState(this.registerDelegateModel);

}

class RegisterLinkPersonErrorState extends RegisterLinkPersonStates{
  final String error;
  RegisterLinkPersonErrorState(this.error);
}