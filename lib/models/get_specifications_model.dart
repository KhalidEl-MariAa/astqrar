

class GetSpecificationsModel
{
  int?key;
  List<Specification> data=[];

  GetSpecificationsModel(){}
  
  GetSpecificationsModel.fromJson(Map<String,dynamic>json)
  {
      key = json['key'];
      data = [];
      json['data'].forEach( (e) {
        data.add(Specification.fromJson(e));
      });
  }
}

class Specification
{
  int?id;
  String?nameAr;
  String?nameEn;

  Specification.fromJson(Map<String,dynamic>json)
  {
      id=json['id'];
      nameAr=json['nameAr'];
      nameEn=json['nameEn'];
  }
}