class ForgetPassword{
int?key;
String?msg;
CodeData?data;
  ForgetPassword.fromJson(Map<String,dynamic>json){
    key=json['key'];
    msg=json['msg'];
    data= json['data']!=null?CodeData.fromJson(json['data']):null;

  }
}

class CodeData{
int?code;
String?userId;
  CodeData.fromJson(Map<String,dynamic>json){
    code=json['code'];
    userId=json['userId'];

  }
}