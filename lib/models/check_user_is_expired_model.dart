class CheckUserIsExpiredModel{
  bool?isExpired;
  CheckUserIsExpiredModel.fromJson(Map<String,dynamic>json){
    isExpired=json['isExpired'];
  }
}