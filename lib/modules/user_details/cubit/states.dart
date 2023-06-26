

abstract class UserDetailsStates{}

class GetInformationInitialState extends UserDetailsStates{}

class GetInformationLoadingState extends UserDetailsStates{}

class GetInformationSuccessState extends UserDetailsStates{}

class GetInformationErrorState extends UserDetailsStates{
  final String error;
  GetInformationErrorState(this.error);
}
class SendNotificationLoadingState extends UserDetailsStates{}

class SendNotificationSuccessState extends UserDetailsStates{}

class SendNotificationErrorState extends UserDetailsStates{
  final String error;
  SendNotificationErrorState(this.error);
}


class ToggleFavouriteLoading extends UserDetailsStates{}

class AddToFavouriteSuccessState extends UserDetailsStates{}

class AddToFavouriteErrorState extends UserDetailsStates{
  final String error;
  AddToFavouriteErrorState(this.error);
}

class RemoveFromFavouriteSuccessState extends UserDetailsStates{}

class RemoveFromFavouriteErrorState extends UserDetailsStates{
  final String error;
  RemoveFromFavouriteErrorState(this.error);
}


// class AddChattRequestLoadingState extends GetInformationStates{}

// class AddChattRequestSuccessState extends GetInformationStates{
//   final int statusCode;
//   AddChattRequestSuccessState(this.statusCode);
// }

// class AddChattRequestErrorState extends GetInformationStates{
//   final String error;
//   AddChattRequestErrorState(this.error);
// }

class AddHimToMyContactsLoading extends UserDetailsStates{}

class AddHimToMyContactsSuccess extends UserDetailsStates{
  final String msg;
  AddHimToMyContactsSuccess(this.msg);
}

class AddHimToMyContactsError extends UserDetailsStates{
  final String error;
  AddHimToMyContactsError(this.error);
}


class BlockHimLoading extends UserDetailsStates{}

class BlockHimSuccess extends UserDetailsStates{
  final String msg;
  BlockHimSuccess(this.msg);
}

class BlockHimError extends UserDetailsStates{
  final String error;
  BlockHimError(this.error);
}