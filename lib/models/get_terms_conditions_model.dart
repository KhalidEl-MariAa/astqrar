
class GetTermsAndConditionsModel{
  int?key;
  DetailsConditionsModel? data;
  GetTermsAndConditionsModel.fromJson(Map<String,dynamic>json){
    key=json['key'];
    data =
    json['data'] != null ? DetailsConditionsModel.fromJson(json['data']) : null;
  }
}

class DetailsConditionsModel {
  String? condtions;

  DetailsConditionsModel.fromJson(Map<String, dynamic> json) {
    condtions = json['condtions'];
  }
}