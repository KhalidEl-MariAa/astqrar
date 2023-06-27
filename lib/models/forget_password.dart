
class ActivationCode 
{
  int? code;
  String? userId;
  ActivationCode.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    userId = json['userId'];
  }
}
