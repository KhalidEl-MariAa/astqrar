


class UserItem {
  String? user_Name;
  int? gender;
  dynamic age;
  String? id;

  UserItem.fromJson(Map<String, dynamic> json) 
  {
    user_Name = json['user_Name'];
    gender = json['gender'];
    age = json['age'];
    id = json['id'];
  }
}
