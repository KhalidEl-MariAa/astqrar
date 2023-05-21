
class LoginModel
{
  int ?key;
  UserData?data;
  String?msg;
    LoginModel.fromJson(Map<String,dynamic>json){
      key=json['key'];
      msg=json['msg'];
      data= json['data']!=null?UserData.fromJson(json['data']):null;
    }
}

class UserData{

  String?id;
  String?userName;
  String?email;
  String?phone;
  String?lang;
  bool?closeNotify;
  bool?status;
  String?imgProfile;
  String?token;
  int?typeUser;
  int?gender;
  int?code;
  String?nationality;
  String?nationalID;
  String?city;
  dynamic?age;
  dynamic?height;
  dynamic?weight;
  String?dowry;
  String?terms;
  bool?specialNeeds;
  bool?hideImg;
  int?countryId;
  String?countryName;
  
  UserData.fromJson(Map<String,dynamic>json){
    id=json['id'];
    userName=json['userName'];
    email=json['email'];
    phone=json['phone'];
    lang=json['lang'];
    closeNotify=json['closeNotify'];
    status=json['status'];
    imgProfile=json['imgProfile'];
    token=json['token'];
    typeUser=json['typeUser']!=2&&json['typeUser']!=1?1:json['typeUser'];
    countryName=json['countryName'];
    gender=json['gender'];
    nationality=json['nationality'];
    countryId=json['countryId'];
    hideImg=json['hideImg'];
    specialNeeds=json['specialNeeds'];
    terms=json['terms'];
    dowry=json['dowry'];
    weight=json['weight'];
    nationalID=json['nationalID'];
    height=json['height'];
    age=json['age'];
    city=json['city'];
    code=json['code'];
  }
}