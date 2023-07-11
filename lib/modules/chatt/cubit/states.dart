import 'package:astarar/models/get-messages-model.dart';

import '../../../models/get_information_user.dart';

abstract class ConversationStates {}

class ConversationInitialState extends ConversationStates {}

class ConnectUserLoadingState extends ConversationStates {}

class ConnectUserSuccessState extends ConversationStates {}



class SendMessageLoadingState extends ConversationStates {}

class SendMessageSuccessState extends ConversationStates {
  Message sentMsg;
  SendMessageSuccessState(this.sentMsg);
}

class SendMessageErrorState extends ConversationStates {}


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


