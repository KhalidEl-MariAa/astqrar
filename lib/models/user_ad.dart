
import 'package:astarar/models/user.dart';



class UserAd extends User
{
  // String? id;
  // String? user_Name = "";
  // String? imgProfile;
  String typeOfMarriage = "";
  DateTime? ExpiredDate;

  UserAd.fromJson(Map<String, dynamic> json) : super.fromJson(json)
  {
    // this.id = json['id'];
    // this.user_Name = json['user_Name']?? "--------";
    // this.imgProfile = json['imgProfile'];
    // this.gender = json['gender'];
    // this.age = json['age'];
    // this.countryId = json['countryId']?? 0;
    this.typeOfMarriage = json['typeOfMarriage']??"--------";
    this.ExpiredDate = DateTime.parse(json['expiredDate'] ?? "2002-01-01");
  }
}
