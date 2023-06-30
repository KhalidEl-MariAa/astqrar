
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

  String?   id;
  String?   userName;
  String?   email;
  String?   phone;
  String?   lang;
  bool? closeNotify;
  bool? status;
  String? imgProfile;
  String? token;
  int?    typeUser;
  int?    gender;
  int?    code;
  // String? nationality;
  int?countryId;
  String?countryName;

  String? nationalID;
  String? city;
  dynamic age;
  dynamic height;
  dynamic weight;
  String?dowry;
  String?terms;
  bool?specialNeeds;
  bool?hideImg;
  
  UserData.fromJson(Map<String,dynamic>json){
    id=json['id'];
    userName=json['user_Name'];
    email=json['email'];
    phone=json['phone'];
    lang=json['lang'];
    closeNotify=json['closeNotify'];
    status=json['status'];
    imgProfile=json['imgProfile'];
    token=json['token'];
    typeUser=json['typeUser'];
    gender=json['gender'];
    // nationality=json['nationality'];
    countryId=json['countryId'];
    countryName=json['countryName'];
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