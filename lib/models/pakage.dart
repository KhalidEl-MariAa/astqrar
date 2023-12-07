
class Package 
{
  int? id;
  String? description;
  dynamic price;
  dynamic days;

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    price = json['price'];
    days = json['days'];
  }
}
