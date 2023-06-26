
class ActivateModel 
{
  String? msg;
  bool? status;

  ActivateModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    status = json['status'];
  }
}
