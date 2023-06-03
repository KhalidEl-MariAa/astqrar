import 'package:astarar/models/server_response_model.dart';

abstract class RegisterClientStates{}

class RegisterClientInitialState extends RegisterClientStates{}

class RegisterClientLoadingState extends RegisterClientStates{}

class RegisterClientSuccessState extends RegisterClientStates{
  final ServerResponse response;
  RegisterClientSuccessState(this.response);
}

class RegisterClientErrorState extends RegisterClientStates{
  final String error;
  RegisterClientErrorState(this.error);
}

// class GetSpecificationsLoadingState extends RegisterClientStates{}

// class GetSpecificationsSuccessState extends RegisterClientStates{}

// class GetSpecificationsErrorState extends RegisterClientStates{
//   final String error;
//   GetSpecificationsErrorState(this.error);
// }