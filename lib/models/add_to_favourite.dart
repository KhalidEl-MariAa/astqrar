class AddToFavouriteModel{
int?key;
String?msg;
  AddToFavouriteModel.fromJson(Map<String,dynamic>json){
    key=json['key'];
    msg=json['msg'];
  }
}