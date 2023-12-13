abstract class AdsStates {}

class AdsInitialState extends AdsStates {}

class GetAdsLoadingState extends AdsStates {}

class GetAdsSuccessState extends AdsStates {}

class GetAdsErrorState extends AdsStates {
  final String error;

  GetAdsErrorState(this.error);
}

class AddAdsLoadingState extends AdsStates {}

class AddAdsSuccessState extends AdsStates {
  final int statusCode;
  AddAdsSuccessState(this.statusCode);
}

class AddAdsErrorState extends AdsStates {
  final String error;

  AddAdsErrorState(this.error);
}



