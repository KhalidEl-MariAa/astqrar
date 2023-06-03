

class ServerResponse
{
  int?key;
  String?msg;

  ServerResponse(this.key, this.msg);

  ServerResponse.fromJson(Map<String, dynamic> json)
  {
    key=json['key'];
    msg=json['msg'];
  }
}