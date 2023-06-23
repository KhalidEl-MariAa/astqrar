abstract class SettingsStates{}

class SettingsInitialState extends SettingsStates{}

class LogoutLoadingState extends SettingsStates{}

class LogoutSuccessState extends SettingsStates{}

class LogoutErrorState extends SettingsStates{
  final String error;
  LogoutErrorState(this.error);
}

class RemoveAccountLoadingState extends SettingsStates{}

class RemoveAccountSuccessState extends SettingsStates{
  final int statusCode;
  RemoveAccountSuccessState(this.statusCode);
}

class RemoveAccountErrorState extends SettingsStates{
  final String error;
  RemoveAccountErrorState(this.error);
}


