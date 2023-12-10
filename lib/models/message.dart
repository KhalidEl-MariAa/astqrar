

import 'package:astarar/constants.dart';

class Message 
{
  String? message;
  DateTime? date;
  String? receiverId;
  String? senderId;
  bool? isMine;
  
  int? orderId;
  int? type;
  int? duration;

  Message.fromJson(Map<String, dynamic> json) 
  {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    message = json['message']?? json['text'];

    orderId = json['orderId'];
    type = json['type'];
    duration = json['duration'];

    // date = json['date'];
    date = DateTime.parse(json['date']??"2002-02-22");
    
    isMine = (ID == senderId);
  }



}
