class GetMessagesModel{
int?key;
String?msg;
List<DataOfMessagesModel>data=[];
  GetMessagesModel.fromJson(Map<String,dynamic>json){
    key=json['key'];
    msg=json['msg'];
    json['data'].forEach((element) {
      data.add(DataOfMessagesModel.fromJson(element));
    });
  }
}
class DataOfMessagesModel{
String?message;
String?date;
String?receiverId;
String?senderId;
bool?isMine;
  DataOfMessagesModel.fromJson(Map<String,dynamic>json){
    message=json['message'];
    date=json['date'];
    receiverId=json['receiverId'];
    senderId=json['senderId'];
  }
}