class AboutUsModel {
  int?key;
  DetailsAbouUsModel? data;

  AboutUsModel.fromJson(Map<String, dynamic> json) {
    key=json['key'];
    data =
        json['data'] != null ? DetailsAbouUsModel.fromJson(json['data']) : null;
  }
}

class DetailsAbouUsModel {
  String? aboutUs;

  DetailsAbouUsModel.fromJson(Map<String, dynamic> json) {
    aboutUs = json['aboutUs'];
  }
}
