
class Message {
  String? message;
  String? date;
  String? receiverId;
  String? senderId;
  bool? isMine;
  Message.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    message = json['message'];
    date = json['date'];
  }
}
