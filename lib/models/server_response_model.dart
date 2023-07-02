

class ServerResponse
{
  int? key;
  String? msg;
  dynamic data = {};
  // List listing = [];

  ServerResponse(this.key, this.msg);

  ServerResponse.fromJson(Map<String, dynamic> json)
  {
    key = json['key'];
    msg = json['msg'];
    data = json['data']?? {};
  }

}