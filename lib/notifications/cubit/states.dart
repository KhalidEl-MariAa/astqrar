abstract class NotificationStates{}

class NotificationInitialState extends NotificationStates{}

class GetNotificationLoadingState extends NotificationStates{}

class GetNotificationSuccessState extends NotificationStates{}

class GetNotificationErrorState extends NotificationStates{
  final String error;
  GetNotificationErrorState(this.error);
}

class AcceptRequestLoadingState extends NotificationStates{}

class AcceptRequestSuccessState extends NotificationStates{}

class AcceptRequestErrorState extends NotificationStates{
  final String error;
  AcceptRequestErrorState(this.error);
}
class IgnoreRequestLoadingState extends NotificationStates{}

class IgnoreRequestSuccessState extends NotificationStates{}

class IgnoreRequestErrorState extends NotificationStates{
  final String error;
  IgnoreRequestErrorState(this.error);
}

class SendNotificationLoadingState extends NotificationStates{}

class SendNotificationSuccessState extends NotificationStates{}

class SendNotificationErrorState extends NotificationStates{
  final String error;
  SendNotificationErrorState(this.error);
}