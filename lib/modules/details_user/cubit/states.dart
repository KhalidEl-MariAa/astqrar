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

class AddRequestLoadingState extends GetInformationStates{}

class AddRequestSuccessState extends GetInformationStates{
  final int statusCode;
  AddRequestSuccessState(this.statusCode);
}

class AddRequestErrorState extends GetInformationStates{
  final String error;
  AddRequestErrorState(this.error);
}