class RegisterDelegateModel{
int?key;
String?msg;
  RegisterDelegateModel.fromJson(Map<String,dynamic>json){
    key=json['key'];
    msg=json['msg'];
  }
}