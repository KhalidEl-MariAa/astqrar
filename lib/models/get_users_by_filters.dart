class GetUsersByFilterModel{
List<DataOfUsersByFiltersModel>data=[];
  GetUsersByFilterModel.fromJson(Map<String,dynamic>json){
    json['data'].forEach((element) {
      data.add(DataOfUsersByFiltersModel.fromJson(element));
    });
  }
}

class DataOfUsersByFiltersModel{
int?gender;
String ?user_Name;
String?id;
  DataOfUsersByFiltersModel.fromJson(Map<String,dynamic>json){
    gender=json['gender'];
    user_Name=json['user_Name'];
    id=json['id'];
  }
}