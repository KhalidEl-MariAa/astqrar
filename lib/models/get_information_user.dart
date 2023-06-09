
class GetInformationUserModel {
  bool? isFavorate;
  bool? isInMyContacts;
  InformationDetailsModel? information;
  UserSubSpecificationModel? userSubSpecifications;

  GetInformationUserModel.fromJson(Map<String, dynamic> json) {
    isFavorate = json['isFavorate'];
    isInMyContacts = json['isInMyContacts'];
    information = json['information'] != null
        ? InformationDetailsModel.fromJson(json['information'])
        : null;
    userSubSpecifications = json['userSubSpecification'] != null
        ? UserSubSpecificationModel.fromJson(json['userSubSpecification'])
        : null;
  }
}

class InformationDetailsModel {
  String? id;
  String? user_Name;
  dynamic gender;
  String? city;
  dynamic age;
  dynamic height;
  dynamic weight;
  String? dowry;
  String? terms;
  String? email;
  String? nationality;

  InformationDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user_Name = json['user_Name'];
    gender = json['gender'];
    nationality = json['nationality'];
    city = json['city'];
    age = json['age'];
    height = json['height'];
    weight = json['weight'];
    dowry = json['dowry'];
    terms = json['terms'];
    email = json['email'];
  }
}

class UserSubSpecificationModel 
{
    String? id;
    String? userName;
    String? email;
    int?    gender;
    String? city;
    dynamic age;
    dynamic height;
    dynamic weight;
    String? dowry;
    String? terms;
    String? nationality;
    bool?specialNeeds;

    List<UserSubSpecificationDtoModel>userSubSpecificationDto=[];
    
    UserSubSpecificationModel.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      userName = json['userName'];
      email = json['email'];
      nationality = json['nationality'];
      gender = json['gender'];
      city = json['city'];
      age = json['age'];
      height = json['height'];
      weight = json['weight'];
      dowry = json['dowry'];
      terms = json['terms'];
      specialNeeds=json['specialNeeds'];
      
      json['userSubSpecificationDto'].forEach((element) {
        userSubSpecificationDto.add(UserSubSpecificationDtoModel.fromJson(element));
      });
  }
}

class UserSubSpecificationDtoModel {
  int? id;
  String?name;
  String?value;

  UserSubSpecificationDtoModel(this.id, this.name, this.value);

  UserSubSpecificationDtoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name=json['name'];
    value=json['specificationValue'];
  }

  
}
