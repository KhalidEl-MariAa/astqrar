class GetAdsModel{
int?key;
List<DataAdsModel> data=[];
  GetAdsModel.fromJson(Map<String,dynamic>json){
    key=json['key'];
    json['data'].forEach((element) {
      data.add(DataAdsModel.fromJson(element));
    });
  }
}

class DataAdsModel{
int?id;
String?descriptionAr;
dynamic price;
dynamic days;
String?nameAr;
  DataAdsModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    descriptionAr=json['descriptionAr'];
    price=json['price'];
    days=json['days'];
    nameAr=json['nameAr'];
  }
}