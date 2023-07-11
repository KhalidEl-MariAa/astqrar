import 'package:intl/intl.dart';

class ChatModel 
{
  String? senderId;
  String? text;
  String? receiverId;
  dynamic date;

  ChatModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    text = json['text'];
    receiverId = json['receiverId'];

    date = json['date'];
    date = DateFormat('mm : hh a', 'ar_SA').format(DateTime.parse(date));
  }
}
