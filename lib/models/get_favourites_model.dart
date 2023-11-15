
import 'package:astarar/models/user.dart';

class GetFavouritesModel 
{
  int?key;
  List<Favorite>data = [];

  GetFavouritesModel.fromJson(Map<String, dynamic>json)
  {
    key = json['key'];
    json['data'].forEach((element) {
      data.add(Favorite.fromJson(element));
    });
  }
}

class Favorite extends User 
{
  bool isFavourite = true;

  Favorite.fromJson(Map<String, dynamic>json) : super.fromJson(json)
  {
    id = json['favUserId'];
    isFavourite=true;
  }
}