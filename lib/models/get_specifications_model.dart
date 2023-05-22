

class GetSpecificationsModel
{
  int?key;
  List<DataOfSpecifications>data=[];

  GetSpecificationsModel.fromJson(Map<String,dynamic>json)
  {
      key=json['key'];
      json['data'].forEach((element) {
        data.add(DataOfSpecifications.fromJson(element));
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