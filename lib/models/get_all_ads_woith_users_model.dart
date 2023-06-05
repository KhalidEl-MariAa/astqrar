
class GetAllAdsWithUsersModel
{
  int?key;
  List<UserDataOfAdsModel>data=[];
    GetAllAdsWithUsersModel.fromJson(Map<String,dynamic>json){
      key=json['key'];
      json['data'].forEach((element) {
        data.add(UserDataOfAdsModel.fromJson(element));
      });
    }
}

class UserDataOfAdsModel
{
  String?id;
  String?userName;
  String?email;
  String?phone;
  String?token;
  String?imgProfile;
  int?gender;
  int?age;
  String?nationality;
  List<UserSubSpecificationsDetailsWithAds> userSubSpecificationDto=[];

  UserDataOfAdsModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    userName=json['userName'];
    email=json['email'];
    phone=json['phone'];
    token=json['token'];
    imgProfile=json['imgProfile'];
    gender=json['gender'];
    age=json['age'];
    nationality=json['nationality'];
    json['userSubSpecificationDto'].forEach((element) {
      userSubSpecificationDto.add(UserSubSpecificationsDetailsWithAds.fromJson(element));
    });
  }
}

class UserSubSpecificationsDetailsWithAds
{
  String?name;
  String?specificationValue;
  
  UserSubSpecificationsDetailsWithAds.fromJson(Map<String,dynamic>json){
    name=json['name'];
    specificationValue=json['specificationValue'];
  }
}