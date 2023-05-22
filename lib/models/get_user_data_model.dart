class GetUserDataModel {
  int? key;
  String? msg;
UserDataModel?data;
  GetUserDataModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    msg = json['msg'];
    data=json['data']!=null?UserDataModel.fromJson(json['data']):null;
  }
}

class UserDataModel {
  String? id;
  String? userName;
  String? email;
  String? phone;
  bool ?  closeNotify;
  bool?   status;
  String? imgProfile;
  int?    gender;
  String? nationality;
  String? nationalID;
  String? city;
  dynamic age;
  dynamic height;
  dynamic weight;
  dynamic dowry;
  dynamic terms;
  bool?specialNeeds;

  List<UserSpecificationsModel>userSubSpecificationDto=[];
    UserDataModel.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      userName=json['userName'];
      nationalID=json['nationalID'];
      email=json['email'];
      phone=json['phone'];
      closeNotify=json['closeNotify'];
      status=json['status'];
      imgProfile=json['imgProfile'];
      gender=json['gender'];
      nationality=json['nationality'];
      city=json['city'];
      age=json['age'];
      height=json['height'];
      weight=json['weight'];
      dowry=json['dowry'];
      terms=json['terms'];
      specialNeeds=json['specialNeeds'];
      json['userSubSpecificationDto'].forEach((element) {
        userSubSpecificationDto.add(UserSpecificationsModel.fromJson(element));
      });
    }
}

class UserSpecificationsModel{
int?id;
String?name;
String?specificationValue;
  UserSpecificationsModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    specificationValue=json['specificationValue'];
  }
}