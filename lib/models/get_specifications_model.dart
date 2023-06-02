

class GetSpecificationsModel
{
  int?key;
  List<DataOfSpecifications> data=[];

  GetSpecificationsModel(){}
  
  GetSpecificationsModel.fromJson(Map<String,dynamic>json)
  {
      key = json['key'];
      data = [];
      json['data'].forEach( (e) {
        data.add(DataOfSpecifications.fromJson(e));
      });
  }
}

class DataOfSpecifications
{
  int?id;
  String?nameAr;
  String?nameEn;

  DataOfSpecifications.fromJson(Map<String,dynamic>json)
  {
      id=json['id'];
      nameAr=json['nameAr'];
      nameEn=json['nameEn'];
  }
}