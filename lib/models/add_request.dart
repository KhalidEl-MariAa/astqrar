class AddRequestModel{
  String?message;
  AddRequestModel.fromJson(Map<String,dynamic>json){
    message=json['message'];
  }
}