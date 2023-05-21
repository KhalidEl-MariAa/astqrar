class GetSearchModel{
List<DataOfUserDetailsModel>data=[];
  GetSearchModel.fromJson(Map<String,dynamic>json){
    json['data'].forEach((element) {
      data.add(DataOfUserDetailsModel.fromJson(element));
    });
  }
}

class DataOfUserDetailsModel{
String?user_Name;
int?gender;
dynamic?age;
String?id;
  DataOfUserDetailsModel.fromJson(Map<String,dynamic>json){
    user_Name=json['user_Name'];
    gender=json['gender'];
    age=json['age'];
    id=json['id'];
  }
}