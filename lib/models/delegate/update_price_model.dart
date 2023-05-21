class UpdatePriceModel{
bool?item1;
String?item2;
  UpdatePriceModel.fromJson(Map<String,dynamic>json){
    item1=json['item1'];
    item2=json['item2'];
  }
}