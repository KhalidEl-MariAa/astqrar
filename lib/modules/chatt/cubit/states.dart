import 'package:astarar/models/get_information_user.dart';

abstract class ConversationStates {}

class ConversationInitialState extends ConversationStates {}

class ConnectUserLoadingState extends ConversationStates {}

class ConnectUserSuccessState extends ConversationStates {}

class SendMessageLoadingState extends ConversationStates {}

class SendMessageSuccessState extends ConversationStates {}

class ReceiveMessageLoadingState extends ConversationStates {}

class ReceiveMessageSuccessState extends ConversationStates {}

class GetMessagesLoadingState extends ConversationStates{}

class GetMessagesSuccessState extends ConversationStates
{
  final OtherUser otherUser;
  GetMessagesSuccessState(this.otherUser);
}

class GetMessagesErrorState extends ConversationStates{
  final String error;
  GetMessagesErrorState(this.error);
}

//payment confirmation

class PaymentConfirmationLoadingState extends ConversationStates{}

class PaymentConfirmationSuccessState extends ConversationStates{}


class PaymentConfirmationErrorState extends ConversationStates{
  final String error;
  PaymentConfirmationErrorState(this.error);
}

