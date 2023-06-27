
import 'package:astarar/models/user.dart';


class OtherUser extends User
{
    bool? isFavorate;
    bool? isInMyContacts;
    bool? isBlocked;
    
    OtherUser.fromJson(Map<String, dynamic>? json)  : super.fromJson(json)
    {
      if(json == null) return;

      this.isFavorate = json['isFavorate'];
      this.isInMyContacts = json['isInMyContacts'];
      this.isBlocked = json['isBlocked'];   
    }
}


class UserSubSpecificationDtoModel 
{
  int? id;
  String?name;
  String?value;

  UserSubSpecificationDtoModel(this.id, this.name, this.value);

  UserSubSpecificationDtoModel.fromJson(Map<String, dynamic> json) 
  {
    id = json['id'];
    name=json['name'];
    value=json['specificationValue'];
  }
  
}
