import 'package:astarar/models/register_delegate_model.dart';

abstract class RegisterClientStates{}

class RegisterClientInitialState extends RegisterClientStates{}

class RegisterClientLoadingState extends RegisterClientStates{}

class RegisterClientSuccessState extends RegisterClientStates{
  final RegisterDelegateModel registerClientModel;
  RegisterClientSuccessState(this.registerClientModel);

}

class RegisterClientErrorState extends RegisterClientStates{
  final String error;
  RegisterClientErrorState(this.error);
}

class GetSpecificationsLoadingState extends RegisterClientStates{}

class GetSpecificationsSuccessState extends RegisterClientStates{


}

class GetSpecificationsErrorState extends RegisterClientStates{
  final String error;
  GetSpecificationsErrorState(this.error);
}