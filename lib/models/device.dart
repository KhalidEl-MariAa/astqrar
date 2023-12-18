
class Device 
{
  int? id;
  String? deviceId;
  String? deviceType;
  DateTime? date;
  bool? isActive;

  // Device({this.id, this.deviceId, this.deviceType, this.date});

  Device.fromJson(Map<String, dynamic> json) 
  {
    id = json['id'];
    deviceId = json['deviceId_'];
    deviceType = json['deviceType'];
    isActive = json['isActive'];

    date = DateTime.parse(json['date'] ?? "2002-01-01");
  }

  Map<String, dynamic> toJson() 
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['deviceId_'] = this.deviceId;
    data['deviceType'] = this.deviceType;
    data['isActive'] = this.isActive;
    
    data['date'] = this.date;
    return data;
  }

}