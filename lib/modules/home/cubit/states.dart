abstract class HomeStates{}

class HomeInitialState extends HomeStates{}

class HomeLoadingState extends HomeStates{}

class HomeSuccessState extends HomeStates{

}

class HomeErrorState extends HomeStates{
  final String error;
  HomeErrorState(this.error);
}

class GetUserAdsLoadingState extends HomeStates{}

class GetUserAdsSuccessState extends HomeStates{

}

class GetUserAdsErrorState extends HomeStates{
  final String error;
  GetUserAdsErrorState(this.error);
}