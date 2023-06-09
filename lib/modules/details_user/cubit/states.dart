abstract class GetInformationStates{}

class GetInformationInitialState extends GetInformationStates{}

class GetInformationLoadingState extends GetInformationStates{}

class GetInformationSuccessState extends GetInformationStates{}

class GetInformationErrorState extends GetInformationStates{
  final String error;
  GetInformationErrorState(this.error);
}
class SendNotificationLoadingState extends GetInformationStates{}

class SendNotificationSuccessState extends GetInformationStates{}

class SendNotificationErrorState extends GetInformationStates{
  final String error;
  SendNotificationErrorState(this.error);
}


class AddToFavouriteLoadingState extends GetInformationStates{}

class AddToFavouriteSuccessState extends GetInformationStates{}

class AddToFavouriteErrorState extends GetInformationStates{
  final String error;
  AddToFavouriteErrorState(this.error);
}

class AddChattRequestLoadingState extends GetInformationStates{}

class AddChattRequestSuccessState extends GetInformationStates{
  final int statusCode;
  AddChattRequestSuccessState(this.statusCode);
}

class AddChattRequestErrorState extends GetInformationStates{
  final String error;
  AddChattRequestErrorState(this.error);
}