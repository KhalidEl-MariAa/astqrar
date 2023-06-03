

class GetUserDataModel 
{
  int? key;
  String? msg;
  User? data;

  GetUserDataModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    msg = json['msg'];
    data = json['data'] != null ? User.fromJson(json['data']) : null;
  }
}

class User 
{
  String? id;
  int? gender;
  String? email;  
  String? userName;
  String? nationalID;
  String? city;
  String? nationality;

  String? tribe;
  String? phone;
  dynamic age;
  dynamic height;
  dynamic weight;

  String? nameOfJob;
  String? illnessType;
  int? numberOfKids;
  
  bool? specialNeeds;

  dynamic dowry;
  dynamic terms;
  String? password;
  
  bool? closeNotify;
  bool? status;
  String? imgProfile;

  List<UserSpecification> userSubSpecificationDto = [];

  User() {  }  
  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gender = json['gender'];
    email = json['email'];
    userName = json['userName'];
    nationalID = json['nationalID'];
    city = json['city'];
    nationality = json['nationality'];
    
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
    
    json['userSubSpecificationDto'].forEach((e) {
      userSubSpecificationDto.add(UserSpecification.fromJson(e));
    });
  }

  // Map<String, dynamic> toMap() 
  Map toMap() 
  {
    
    Map res = {
      "userName": this.userName,
      "email": this.email,
      "Age": this.age,
      "Gender": this.gender,
      "NationalID": this.nationalID,
      "Nationality": this.nationality,
      "City": this.city,
      "password": this.password,
      "phone": this.phone,
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
      // "UserSpecifications": specificationsMap,  //can't SAVE
    };

    return res;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['Age'] = this.age;
    data['Gender'] = this.gender;
    data['NationalID'] = this.nationalID;
    data['Nationality'] = this.nationality;
    data['City'] = this.city;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['Height'] = this.height;
    data['Weight'] = this.weight;
    return data;
  }

}

class UserSpecification 
{
  int? id;
  String? name;
  String? specificationValue;

  UserSpecification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    specificationValue = json['specificationValue'];
  }
}
