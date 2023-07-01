import 'package:astarar/models/contacts.dart';

abstract class ContactsStates{}

class ContactsInitialState extends ContactsStates{}

class GetContactsLoadingState extends ContactsStates{}

class GetContactsSuccessState extends ContactsStates
{
  List<ContactDetails> contacts=[];
  GetContactsSuccessState(this.contacts);
}

class GetContactsErrorState extends ContactsStates{
  final String error;
  GetContactsErrorState(this.error);
}

class RemoveChatLoadingState extends ContactsStates{}

class RemoveChatSuccessState extends ContactsStates{
  final int statusCode;
  RemoveChatSuccessState(this.statusCode);
}

class RemoveChateErrorState extends ContactsStates{
  final String error;
  RemoveChateErrorState(this.error);
}


