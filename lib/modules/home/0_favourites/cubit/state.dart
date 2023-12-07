
abstract class FavouritesStates{}

class GetFavouritesInitialState extends FavouritesStates{}

class GetFavouritesLoadingState extends FavouritesStates{}

class GetFavouritesSuccessState extends FavouritesStates{}

class GetFavouritesErrorState extends FavouritesStates{
  final String error;
  GetFavouritesErrorState(this.error);
}

class RemoveFromFavouriteLoadingState extends FavouritesStates
{
  final String userId;
  RemoveFromFavouriteLoadingState(this.userId);
}

class RemoveFromFavouriteSuccessState extends FavouritesStates{}

class RemoveFromFavouriteErrorState extends FavouritesStates{
  final String error;
  RemoveFromFavouriteErrorState(this.error);
}