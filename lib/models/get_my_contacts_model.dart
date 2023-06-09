import 'package:intl/intl.dart';

class MyContactsModel {
  List<DataOfMyContactDetails> data = [];
  MyContactsModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(DataOfMyContactDetails.fromJson(element));
    });
  }
}

class DataOfMyContactDetails {
  UserInformationContactData? userInformation;
  ContactData? contact;
  bool isInMyContacts = true;
  DataOfMyContactDetails.fromJson(Map<String, dynamic> json) {
    userInformation = json['userInformation'] != null
        ? UserInformationContactData.fromJson(json['userInformation'])
        : null;
    contact =
        json['contact'] != null ? ContactData.fromJson(json['contact']) : null;
  }
}

class UserInformationContactData {
  String? id;
  String? user_Name;
  int? typeUser;
  UserInformationContactData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user_Name = json['user_Name'];
    typeUser = json['typeUser'];
  }
}

class ContactData {
  String? time;
  ContactData.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    time = DateFormat.yMMMMEEEEd('ar_SA').format(DateTime.parse(time!));
  }
}
