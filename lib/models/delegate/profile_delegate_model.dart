class ProfileDelegateModel{

List<ClientsDataModel>clients=[];
  ProfileDelegateModel.fromJson(Map<String,dynamic>json){
    json['clients'].forEach((element) {
      clients.add(ClientsDataModel.fromJson(element));
    });

  }
}

class ClientsDataModel{
int ?rate;
bool? isDeleted;
bool?isClientDelegate;
ClientDetailsModel?client;
  ClientsDataModel.fromJson(Map<String,dynamic>json){
    rate=json['rate'];
   client= json['client'] != null
        ? ClientDetailsModel.fromJson(json['client'])
        : null;
   isDeleted=false;
    isClientDelegate=json['isClientDelegate'];
  }
}

class ClientDetailsModel{
int?gender;
int?typeUser;
String?user_Name;
String?id;
  ClientDetailsModel.fromJson(Map<String,dynamic>json){
    gender=json['gender'];
    typeUser=json['typeUser'];
    user_Name=json['user_Name'];
    id=json['id'];
  }
}