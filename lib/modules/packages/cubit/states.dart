abstract class GetPackagesStates {}

class GetPackagesInitialState extends GetPackagesStates {}

class GetPackagesLoadingState extends GetPackagesStates {}

class GetPackagesSuccessState extends GetPackagesStates {}

class GetPackagesErrorState extends GetPackagesStates {
  final String error;

  GetPackagesErrorState(this.error);
}

class AddPackageLoadingState extends GetPackagesStates {}

class AddPackageSuccessState extends GetPackagesStates {
  final int statusCode;
  AddPackageSuccessState(this.statusCode);
}

class AddPackageErrorState extends GetPackagesStates {
  final String error;
  AddPackageErrorState(this.error);
}