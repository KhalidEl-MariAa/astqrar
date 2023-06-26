
import 'package:astarar/models/user.dart';

class GetUsersByFilterModel 
{
  List<User> data = [];
  
  GetUsersByFilterModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach( (e) {
      data.add( User.fromJson(e) );
    });
  }
}

