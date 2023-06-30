


class Country
{
  int? id;
  String? img;
  String? NameAr;
  String? NameEn;
  bool? IsActive;

  Country.fromJson(Map<String, dynamic>? json) 
  {
    if( json == null)return;
    
    this.id = json['id'];
    this.img = json['img'];
    this.NameAr = json['nameAr'];
    this.NameEn = json['nameEn'];
    this.IsActive = json['isActive'];
  }
}
