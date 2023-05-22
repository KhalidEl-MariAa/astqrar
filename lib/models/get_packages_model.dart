class GetPackgesModel{
int?key;
String?msg;
List<DataOfPackagesModel> data=[];
  GetPackgesModel.fromJson(Map<String,dynamic>json){
    key=json['key'];
    msg=json['msg'];
    json['data'].forEach((element) {
      data.add(DataOfPackagesModel.fromJson(element));
    });
  }
}

class DataOfPackagesModel
{
  int?id;
  String?description;
  dynamic price;
  dynamic days;
  
  DataOfPackagesModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    description=json['description'];
    price=json['price'];
    days=json['days'];
  }
}