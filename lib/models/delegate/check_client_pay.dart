class CheckClientPayModel{

  bool?result;
  CheckClientPayModel.fromJson(Map<String,dynamic>json){
    result=json['result'];
  }
}