
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

class UserAd 
{
  String? id;
  String user_Name = "";
  String? imgProfile;
  int? gender;
  int? age;
  int countryId=0;
  String typeOfMarriage = "";

  UserAd.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user_Name = json['user_Name']?? "--------";
    imgProfile = json['imgProfile'];
    gender = json['gender'];
    age = json['age'];
    countryId = json['countryId']?? 0;
    typeOfMarriage = json['typeOfMarriage']??"--------";

  }
}
