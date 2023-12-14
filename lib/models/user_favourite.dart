
import 'user.dart';


class Favorite extends User 
{
  bool isFavourite = true;

  Favorite.fromJson(Map<String, dynamic>json) : super.fromJson(json)
  {
    id = json['favUserId'];
    isFavourite=true;
  }
}