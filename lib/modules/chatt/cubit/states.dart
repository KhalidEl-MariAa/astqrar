import '../../../models/message.dart';

import '../../../models/user_other.dart';

abstract class ConversationStates {}

class ConversationInitialState extends ConversationStates {}

class ConnectUserLoadingState extends ConversationStates {}

class ConnectUserSuccessState extends ConversationStates {}



class SendMessageLoadingState extends ConversationStates {}

class SendMessageSuccessState extends ConversationStates {
  Message sentMsg;
  SendMessageSuccessState(this.sentMsg);
}
class SendMessageByOtherSuccessState extends ConversationStates {
  Message sentMsg;
  SendMessageByOtherSuccessState(this.sentMsg);
}

class SendMessageErrorState extends ConversationStates {
  String error ;
  SendMessageErrorState(this.error);
}


class GetMessagesLoadingState extends ConversationStates{}

class GetMessagesSuccessState extends ConversationStates
{
  final List<dynamic> messages ;
  GetMessagesSuccessState(this.messages);
}

class GetOtherUserSuccess extends ConversationStates
{
  final OtherUser otherUser;
  GetOtherUserSuccess(this.otherUser);
}

class GetMessagesErrorState extends ConversationStates{
  final String error;
  GetMessagesErrorState(this.error);
}


