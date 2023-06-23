abstract class GetFavouritesStates{}

class GetFavouritesInitialState extends GetFavouritesStates{}

class GetFavouritesLoadingState extends GetFavouritesStates{}

class GetFavouritesSuccessState extends GetFavouritesStates{}

class GetFavouritesErrorState extends GetFavouritesStates{
  final String error;
  GetFavouritesErrorState(this.error);
}

class RemoveFromFavouriteLoadingState extends GetFavouritesStates{}

class RemoveFromFavouriteSuccessState extends GetFavouritesStates{}

class RemoveFromFavouriteErrorState extends GetFavouritesStates{
  final String error;
  RemoveFromFavouriteErrorState(this.error);
}