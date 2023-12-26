import '../../../../models/user_contact.dart';

abstract class ContactsStates{}

class ContactsInitialState extends ContactsStates{}

class GetContactsLoadingState extends ContactsStates{}

class GetContactsSuccessState extends ContactsStates
{
  List<Contact> contacts=[];
  GetContactsSuccessState(this.contacts);
}

class GetContactsErrorState extends ContactsStates{
  final String error;
  GetContactsErrorState(this.error);
}

class RemoveChatLoadingState extends ContactsStates{
  final int index;
  RemoveChatLoadingState(this.index);
}

class RemoveChatSuccessState extends ContactsStates{
  final String msg;
  RemoveChatSuccessState(this.msg);
}

class RemoveChateErrorState extends ContactsStates{
  final String error;
  RemoveChateErrorState(this.error);
}


