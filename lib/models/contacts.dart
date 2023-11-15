import 'user.dart';
import 'package:intl/intl.dart';

// class ContactDetails 
// {
//   User? userInformation;
//   Contact? contact;
//   bool isInMyContacts = true;
//   ContactDetails.fromJson(Map<String, dynamic> json) 
//   {
//     userInformation = User.fromJson( json['userInformation'] ) ;
//     contact = Contact.fromJson( json['contact'] );
//   }
// }



class Contact extends User
{
  bool isInMyContacts = true;
  bool isConnected = false;
  String contactorId = '';
  String? time;
  String? lastMsgDate;
  int newMessagesCount = 0;

  // Contact(json) : super.fromJson( json );

  Contact.fromJson(Map<String, dynamic> json): super.fromJson( json ) 
  {    
    

    contactorId = json['contactorId'];
    
    time = json['time'];
    time = DateFormat.yMMMMEEEEd('ar_SA').format(DateTime.parse(time!));

    lastMsgDate = json['lastMsgDate'];
    lastMsgDate = DateFormat.yMMMMEEEEd('ar_SA').format(DateTime.parse(lastMsgDate!));

    newMessagesCount = json['newMessagesCount'];
    // isConnected = json['isConnected'];
  }
}
