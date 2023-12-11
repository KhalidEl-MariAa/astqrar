import 'package:astarar/models/device.dart';

import '../modules/home/layout/cubit/cubit.dart';
import 'package:path/path.dart' as p;

class User {
  String? id;
  String? nationalID = "";
  int? gender;
  String? user_Name;
  String? email;
  String? Token;
  DateTime? TokenExpiration;
  String? city;
  // String? nationality;
  int? countryId;

  String? tribe;
  String? phone;
  dynamic age;
  dynamic height;
  dynamic weight;
  String? nameOfJob;
  String? illnessType;
  int? numberOfKids = 0;
  dynamic dowry;
  dynamic terms;
  String? showPassword;
  bool? specialNeeds;

  bool? closeNotify;
  bool? status;
  
  String? imgProfile;
  String? larg_imgProfile;  
  bool? hideImg;

  int typeUser = 1;

  DateTime? LastLogin;
  DateTime? ExpiredDate;
  bool? ActiveCode;
  bool? IsActive;
  bool? IsExpired;

  List<SubSpecification> subSpecifications = [];

  List<Device> deviceIds = [];

  User() {}

  User.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;

    id = json['id'];
    gender = json['gender'] ?? 1;
    email = json['email'];
    user_Name = json['user_Name']?? "--------";
    nationalID = json['nationalID']?? "";
    city = json['city'];
    // nationality = json['nationality'];
    tribe = json['tribe'];
    phone = json['phone'];
    age = json['age'];
    height = json['height'];
    weight = json['weight'];
    dowry = json['dowry'];
    terms = json['terms'];
    specialNeeds = json['specialNeeds'];

    closeNotify = json['closeNotify'];
    status = json['status'];
    imgProfile = json['imgProfile'];
    larg_imgProfile = this.get_large_file_path( json['imgProfile'] );
    hideImg = json['hideImg'];
    countryId = json['countryId']??0;

    LastLogin = DateTime.parse(json['lastLogin'] ?? "2002-01-01");
    ExpiredDate = DateTime.parse(json['expiredDate'] ?? "2002-01-01");
    IsExpired = json['isExpired'];
    ActiveCode = json['activeCode'];
    IsActive = json['isActive'];
    Token = json['token'];
    TokenExpiration = DateTime.parse(json['tokenExpiration'] ?? "2002-01-01");

    json['deviceIds']?.forEach((e) {
      deviceIds.add(new Device.fromJson(e));
    });
    
    json['userSubSpecificationDto']?.forEach((e) {
      subSpecifications.add(new SubSpecification.fromJson(e));
    });
  }

  Map toMap() {
    Map res = {
      "user_Name": this.user_Name,
      "email": this.email,
      "Age": this.age,
      "Gender": this.gender,
      "NationalID": this.nationalID,
      // "Nationality": this.nationality,
      "CountryId": this.countryId,
      "City": this.city,
      "ShowPassword": this.showPassword,
      "PhoneNumber": this.phone,
      "Height": this.height,
      "Weight": this.weight,
      "SpecialNeeds": this.specialNeeds,
      "Dowry": this.dowry,
      "Terms": this.terms,
      // "DelegateId": delegateId,
      // "IsFakeUser": delegateId!=null? true: false,

      "ChildrensNumber": this.numberOfKids,
      "Tribe": this.tribe,
      "NameOfJob": this.nameOfJob,
      "KindOfSick": this.illnessType,

      "typeUser": this.typeUser, //always 1

      "UserSpecifications":
          this.subSpecifications.map((e) => e.toMap()).toList(),
    };

    return res;
  }
  
  String? get_large_file_path(String? path) 
  {
    if(path == null || path == "" )
      return "";

    var p_withoutExtension = p.withoutExtension(path); // path/to/foo
    var ext = p.extension(path); // .jpg

    return (p_withoutExtension + "-large" + ext);        
  }
}// end class

class SubSpecification {
  int? id;
  String? value;

  int? specId;
  String? name;
  String? nameEn;

  SubSpecification(this.id, this.value, this.specId, this.name);

  SubSpecification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['specificationValue']; //subSpecification value, e.g اسود

    name = json['name']; //specification name, e.g لون الشعر
    nameEn = json['nameEn']; //specification name English, e.g Hair color

    specId = json['specificationId'];
  }

  Map toMap({String? UserId}) {
    // in backend UserSpecificationDto
    return {
      "UserId": UserId,
      "SpecificationId": this.id,
      "Value": this.value,
      "specId": specId,
      "SpecificationName": this.name,
    };
  }
}

//like enum
//key value for each specification as it stored in the DB
abstract class SpecificationIDs {
  static int hair_colour = 1;
  static int hair_type = 2;
  static int skin_colour = 3;
  static int strain = 4;
  static int qualification = 6;
  static int job = 7;
  static int health_status = 8;
  static int social_status = 9;
  static int have_children = 10;
  static int appearance = 11;
  static int financial_situation = 12;
  static int name_end_with = 14;
  static int marriage_Type = 15;
  static int smoking = 17;
  static int have_a_legitimate_view = 18;

  static Map get(int specId) {
    return LayoutCubit.Specifications[specId];
  }

  static List getSubSpecificationKeys(int specId) {
    return LayoutCubit.Specifications[specId]["subSpecifications"].keys
        .toList();
  }
}
