class GetPriceModel{
String ?price;
  GetPriceModel.fromJson(Map<String,dynamic>json){
    price=json['price']??"0";
  }
}