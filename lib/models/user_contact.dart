import 'user.dart';
import 'package:intl/intl.dart';


class Contact extends User
{
  bool isInMyContacts = true;
  bool isConnected = false;
  String contactorId = '';
  String? time;
  String? lastMsgDate;
  int unseenMsgCount = 0;

  Contact.fromJson(Map<String, dynamic> json): super.fromJson( json ) 
  {    
    id = json['userTwoId'];
    contactorId = json['userTwoId'];
    
    time = json['time'];
    time = DateFormat.yMMMMEEEEd('ar_SA').format(DateTime.parse(time!));

    lastMsgDate = json['lastMsgDate'];
    lastMsgDate = DateFormat.yMMMMEEEEd('ar_SA').format(DateTime.parse(lastMsgDate!));

    unseenMsgCount = json['unseenMsgCount'];
    // isConnected = json['isConnected'];
  }
}
