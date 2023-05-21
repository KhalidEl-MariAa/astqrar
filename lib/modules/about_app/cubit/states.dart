abstract class AboutUsStates {}

class AboutUsInitialState extends AboutUsStates {}

class AboutUsLoadingState extends AboutUsStates {}

class AboutUsSuccessState extends AboutUsStates {}

class AboutUsErrorState extends AboutUsStates {
  final String error;
  AboutUsErrorState(this.error);
}