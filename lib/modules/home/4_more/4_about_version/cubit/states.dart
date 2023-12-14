
abstract class AboutVersionStates{}


class AboutVersionInitialState extends AboutVersionStates {}


abstract class AboutUsStates {}


class AboutUsLoadingState extends AboutVersionStates {}
class AboutUsSuccessState extends AboutVersionStates {}
class AboutUsErrorState extends AboutVersionStates {
  final String error;
  AboutUsErrorState(this.error);
}