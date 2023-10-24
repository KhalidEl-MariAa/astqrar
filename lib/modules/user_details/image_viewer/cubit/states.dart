abstract class AboutUsStates {}

class AboutUsInitialState extends AboutUsStates {}

class ImageViewerLoadingState extends AboutUsStates {}

class AboutUsSuccessState extends AboutUsStates {}

class AboutUsErrorState extends AboutUsStates {
  final String error;
  AboutUsErrorState(this.error);
}