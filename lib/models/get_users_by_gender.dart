class GetUsersByGengerModel{
List<UserDataDetailsByGenderModel>data=[];
 GetUsersByGengerModel.fromjson(Map<String,dynamic>json){
   json['data'].forEach((element) {
     data.add(UserDataDetailsByGenderModel.fromjson(element));
   });
  }
}

class UserDataDetailsByGenderModel{
String?nationalID;
String?nationality;
String?user_Name;
String?id;
int?gender;
int?age;
  UserDataDetailsByGenderModel.fromjson(Map<String,dynamic>json){
    nationalID=json['nationalID'];
    nationality=json['nationality'];
    user_Name=json['user_Name'];
    gender=json['gender'];
    age=json['age'];
    id=json['id'];
  }
}