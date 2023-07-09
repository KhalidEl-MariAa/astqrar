import '../../../../../models/user.dart';

abstract class AccountStates {}

class AccountInitialState extends AccountStates {}

class AccountLoading extends AccountStates {}

class AccountSuccess extends AccountStates {
  User current_user;
  AccountSuccess(this.current_user);
}

class AccountError extends AccountStates {
  String error;
  AccountError(this.error);
}
