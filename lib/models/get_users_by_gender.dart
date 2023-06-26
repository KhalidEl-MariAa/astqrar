
import 'package:astarar/models/user.dart';

class GetUsersByGengerModel 
{
  List<User> data = [];

  GetUsersByGengerModel.fromjson(Map<String, dynamic> json) 
  {
    json['data'].forEach((e) {
      data.add(User.fromJson(e));
    });
  }
}

