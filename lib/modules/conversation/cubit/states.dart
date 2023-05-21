abstract class ConversationStates {}

class ConversationInitialState extends ConversationStates {}

class ConnectUserLoadingState extends ConversationStates {}

class ConnectUserSuccessState extends ConversationStates {}

class SendMessageLoadingState extends ConversationStates {}

class SendMessageSuccessState extends ConversationStates {}

class ReceiveMessageLoadingState extends ConversationStates {}

class ReceiveMessageSuccessState extends ConversationStates {}

class GetMessagesLoadingState extends ConversationStates{}

class GetMessagesSuccessState extends ConversationStates{}

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

