
abstract class MoreTabStates{}

class SettingsInitialState extends MoreTabStates{}

class LogoutLoadingState extends MoreTabStates{}

class LogoutSuccessState extends MoreTabStates{}

class LogoutErrorState extends MoreTabStates{
  final String error;
  LogoutErrorState(this.error);
}

class RemoveAccountLoadingState extends MoreTabStates{}

class RemoveAccountSuccessState extends MoreTabStates{
  final int statusCode;
  RemoveAccountSuccessState(this.statusCode);
}

class RemoveAccountErrorState extends MoreTabStates{
  final String error;
  RemoveAccountErrorState(this.error);
}


