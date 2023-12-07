
import 'user.dart';


class OtherUser extends User
{
    bool? isFavorate;
    bool? isInMyContacts;
    bool isBlockedByMe = false;
    bool heBlockedMe = false;
    
    OtherUser.fromJson(Map<String, dynamic>? json)  : super.fromJson(json)
    {
      if(json == null) return;

      this.isFavorate = json['isFavorate'];
      this.isInMyContacts = json['isInMyContacts'];
      this.isBlockedByMe = json['isBlockedByMe'];   
      this.heBlockedMe = json['heBlockedMe'];   
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
