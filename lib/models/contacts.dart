import 'package:astarar/models/user.dart';
import 'package:intl/intl.dart';

class ContactDetails 
{
  User? userInformation;
  Contact? contact;
  bool isInMyContacts = true;

  ContactDetails.fromJson(Map<String, dynamic> json) 
  {
    userInformation = User.fromJson( json['userInformation'] ) ;
    contact = Contact.fromJson( json['contact'] );
  }
}


class Contact 
{
  String? time;
  Contact.fromJson(Map<String, dynamic> json) 
  {
    time = json['time'];
    time = DateFormat.yMMMMEEEEd('ar_SA').format(DateTime.parse(time!));
  }
}
