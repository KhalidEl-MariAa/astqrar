
import 'package:astarar/models/user.dart';



class UserAd extends User
{
  String typeOfMarriage = "";
  DateTime? ExpiredDate;

  UserAd.fromJson(Map<String, dynamic> json) : super.fromJson(json)
  {
    this.typeOfMarriage = json['typeOfMarriage']??"--------";
    this.ExpiredDate = DateTime.parse(json['expiredDate']?? "2002-01-01");
  }
}
