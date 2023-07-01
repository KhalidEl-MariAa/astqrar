
import '../modules/home/layout/cubit/cubit.dart';

class User 
{
  String? id;
  int? gender;
  String? email;  
  String? user_Name;
  String? nationalID;
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
  int? numberOfKids=0;
  dynamic dowry;
  dynamic terms;
  String? showPassword;

  bool? specialNeeds;
  
  bool? closeNotify;
  bool? status;
  String? imgProfile;
  int typeUser = 1;
  

  List<SubSpecification> subSpecifications = [];

  User() { }  
  
  User.fromJson(Map<String, dynamic>? json) 
  {
    if(json == null) return ;

    id = json['id'];
    gender = json['gender'];
    email = json['email'];
    user_Name = json['user_Name'];
    nationalID = json['nationalID'];
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
    countryId = json['countryId'];
    
    json['userSubSpecificationDto']?.forEach((e) {
      subSpecifications.add( new SubSpecification.fromJson(e) );
    });
  }

  Map toMap() 
  {
    
    Map res = {
      "user_Name": this.user_Name,
      "email": this.email,
      "Age": this.age,
      "Gender": this.gender,
      "NationalID": this.nationalID,
      // "Nationality": this.nationality,
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
        this.subSpecifications
          .map((e) => e.toMap())
          .toList(),  
    };

    return res;
  }
}

class SubSpecification 
{
  int? id;
  String? value;
  
  int? specId;
  String? name;
  String? nameEn;

  SubSpecification(this.id, this.value,  this.specId, this.name);
  
  SubSpecification.fromJson(Map<String, dynamic> json) 
  {
    id = json['id'];
    value = json['specificationValue']; //subSpecification value, e.g اسود

    name = json['name'];      //specification name, e.g لون الشعر
    nameEn = json['nameEn']; //specification name English, e.g Hair color
    
    specId = json['specificationId'];    
  }

  Map toMap({String? UserId}) 
  {
    // in backend UserSpecificationDto
    return {
      "UserId" : UserId,

      "SpecificationId" :this.id,      
      "Value" : this.value,

      "specId" : specId,
      "SpecificationName" : this.name, 
    };
  }
}

//like enum
//key value for each specification as it stored in the DB
abstract class SpecificationIDs 
{
  static int hair_colour = 1;
  static int hair_type = 2;
  static int skin_colour = 3;
  static int strain = 4;
  static int qualification = 6;
  static int job = 7;
  static int health_status = 8;
  static int social_status = 9;
  static int have_children = 10;
  static int appearance = 11  ;
  static int financial_situation = 12;
  static int name_end_with = 14;
  static int marriage_Type = 15;
  static int smoking = 17;
  static int have_a_legitimate_view = 18;

  static  Map get(int specId)
  {
    return LayoutCubit.Specifications[specId];
  }

  static List getSubSpecificationKeys(int specId)
  {
    return LayoutCubit.Specifications[specId]["subSpecifications"].keys.toList();
  }

}
