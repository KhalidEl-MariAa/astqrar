abstract class AppStates{}

class AppInitialState extends AppStates{}

class GetSpecificationsLoadingState extends AppStates{}

class GetSpecificationsSuccessState extends AppStates{ }

class GetSpecificationsErrorState extends AppStates{
  final String error;
  GetSpecificationsErrorState(this.error);
}

class GetPhoneSuccessState extends AppStates{}

class GetPhoneErrorState extends AppStates{
  final String error;
  GetPhoneErrorState(this.error);
}
