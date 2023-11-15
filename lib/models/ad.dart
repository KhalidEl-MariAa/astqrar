
class Ad 
{
  int? id;
  String? descriptionAr;
  dynamic price;
  dynamic days;
  String? nameAr;

  Ad.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descriptionAr = json['descriptionAr'];
    price = json['price'];
    days = json['days'];
    nameAr = json['nameAr'];
  }
}
