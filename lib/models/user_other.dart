
import 'user.dart';


class OtherUser extends User
{
    bool? isFavorate;
    bool? isInMyContacts;
    bool isBlockedByMe = false;
    bool heBlockedMe = false;
    
    OtherUser( )  : this.fromJson({"id": '111'});

    OtherUser.fromJson(Map<String, dynamic>? json)  : super.fromJson(json)
    {
      if(json == null) return;

      this.isFavorate = json['isFavorate']??false;
      this.isInMyContacts = json['isInMyContacts']??false;
      this.isBlockedByMe = json['isBlockedByMe']??false;   
      this.heBlockedMe = json['heBlockedMe']??false;   
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
