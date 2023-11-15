
import 'package:astarar/models/user.dart';

class GetAllAdsWithUsersModel 
{
  int? key;
  List<UserAd> data = [];

  GetAllAdsWithUsersModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    json['data'].forEach((element) {
      data.add(UserAd.fromJson(element));
    });
  }
}

class UserAd extends User
{
  String? id;
  String? user_Name = "";
  String? imgProfile;
  // int? gender;
  // int age;
  // int countryId=0;
  String typeOfMarriage = "";

  UserAd.fromJson(Map<String, dynamic> json) 
  {
    this.id = json['id'];
    this.user_Name = json['user_Name']?? "--------";
    this.imgProfile = json['imgProfile'];
    this.gender = json['gender'];
    this.age = json['age'];
    this.countryId = json['countryId']?? 0;
    this.typeOfMarriage = json['typeOfMarriage']??"--------";
  }
}
