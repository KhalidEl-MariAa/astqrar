
class Device 
{
  int? id;
  String? deviceId;
  String? deviceType;
  DateTime? date;

  // Device({this.id, this.deviceId, this.deviceType, this.date});

  Device.fromJson(Map<String, dynamic> json) 
  {
    id = json['id'];
    deviceId = json['deviceId_'];
    deviceType = json['deviceType'];

    date = DateTime.parse(json['date'] ?? "2002-01-01");
  }

  Map<String, dynamic> toJson() 
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['deviceId_'] = this.deviceId;
    data['deviceType'] = this.deviceType;
    
    data['date'] = this.date;
    return data;
  }

}