class GetAllDelegatesModel{
List<DelegatesModel> delegates=[];
  GetAllDelegatesModel.fromJson(Map<String,dynamic>json){
    json['delegates'].forEach((element) {
      delegates.add(DelegatesModel.fromJson(element));
    });
  }
}

class DelegatesModel{
double?rate;
DelegatesDataDetailsModel?delegate;
  DelegatesModel.fromJson(Map<String,dynamic>json){
    rate=json['rate'];
    delegate= json['delegate'] != null
        ? DelegatesDataDetailsModel.fromJson(json['delegate'])
        : null;
  }
}

class DelegatesDataDetailsModel{
String?user_Name;
int?typeUser;
String?price;
String?id;
  DelegatesDataDetailsModel.fromJson(Map<String,dynamic>json){
    user_Name=json['user_Name'];
    typeUser=json['typeUser'];
    price=json['price'];
    id=json['id'];
  }
}