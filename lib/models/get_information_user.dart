
class GetInformationUserModel 
{
  // bool? isFavorate;
  // bool? isInMyContacts;
  // bool? isBlocked;

  InformationDetailsModel? information;
  OtherUserModel? otherUser;

  GetInformationUserModel.fromJson(Map<String, dynamic> json) 
  {
    // isFavorate = json['isFavorate'];
    // isInMyContacts = json['isInMyContacts'];
    // isBlocked = json['isBlocked'];
    

    information = json['information'] != null
        ? InformationDetailsModel.fromJson(json['information'])
        : null;

    if(json['otherUser'] != null){
      otherUser =  OtherUserModel.fromJson(json['otherUser']);
      otherUser?.isFavorate = json['isFavorate'];
      otherUser?.isInMyContacts = json['isInMyContacts'];
      otherUser?.isBlocked = json['isBlocked'];
    }

  }
}

class InformationDetailsModel 
{
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

class OtherUserModel 
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
    bool?   specialNeeds;

    bool? isFavorate;
    bool? isInMyContacts;
    bool? isBlocked;

    List<UserSubSpecificationDtoModel>userSubSpecificationDto=[];
    
    OtherUserModel.fromJson(Map<String, dynamic> json) {
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
      
      json['userSubSpecificationDto'].forEach((e) {
        userSubSpecificationDto.add( UserSubSpecificationDtoModel.fromJson(e) );
      });
  }
}

class UserSubSpecificationDtoModel 
{
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
