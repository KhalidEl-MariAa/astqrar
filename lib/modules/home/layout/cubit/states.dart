abstract class LayoutStates{}

class LayoutInitialState extends LayoutStates{}

class GetSpecificationsLoadingState extends LayoutStates{}

class GetSpecificationsSuccessState extends LayoutStates{ }

class GetSpecificationsErrorState extends LayoutStates{
  final String error;
  GetSpecificationsErrorState(this.error);
}

class GetPhoneSuccessState extends LayoutStates{}

class GetPhoneErrorState extends LayoutStates{
  final String error;
  GetPhoneErrorState(this.error);
}
