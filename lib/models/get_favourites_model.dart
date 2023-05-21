class GetFavouritesModel {
  int?key;
  List<DataOfUsersInFavouritesModel>data = [];

  GetFavouritesModel.fromJson(Map<String, dynamic>json){
    key = json['key'];
    json['data'].forEach((element) {
      data.add(DataOfUsersInFavouritesModel.fromJson(element));
    });
  }
}

class DataOfUsersInFavouritesModel {
  String?username;
  String?id;
  int ?gender;
  bool ?isFavourite;

  DataOfUsersInFavouritesModel.fromJson(Map<String, dynamic>json){
    username = json['username'];
    id = json['id'];
    gender = json['gender'];
    isFavourite=true;
  }
}