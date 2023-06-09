abstract class NotificationStates{}

class NotificationInitialState extends NotificationStates{}

class GetNotificationLoadingState extends NotificationStates{}

class GetNotificationSuccessState extends NotificationStates{}

class GetNotificationErrorState extends NotificationStates{
  final String error;
  GetNotificationErrorState(this.error);
}

class AcceptChattRequestLoadingState extends NotificationStates{}

class AcceptChattRequestSuccessState extends NotificationStates{}

class AcceptChattRequestErrorState extends NotificationStates{
  final String error;
  AcceptChattRequestErrorState(this.error);
}

class IgnoreChattRequestLoadingState extends NotificationStates{}

class IgnoreChattRequestSuccessState extends NotificationStates{}

class IgnoreChattRequestErrorState extends NotificationStates{
  final String error;
  IgnoreChattRequestErrorState(this.error);
}

class SendNotificationLoadingState extends NotificationStates{}

class SendNotificationSuccessState extends NotificationStates{}

class SendNotificationErrorState extends NotificationStates{
  final String error;
  SendNotificationErrorState(this.error);
}