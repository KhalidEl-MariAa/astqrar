class GetAllUsers {
  int? key;
  String? msg;
  String? snapChat;
  HomeData? data;
  GetAllUsers.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    msg = json['msg'];
    snapChat = json['snapChat'];
    data = json['data'] != null ? HomeData.fromJson(json['data']) : null;
  }
}

class HomeData {
  List<UsersHomeData> users = [];
  List<UsersHomeData> randomUsers = [];
  HomeData.fromJson(Map<String, dynamic> json) {
    json['users'].forEach((element) {
      users.add(UsersHomeData.fromJson(element));
    });
    json['randomUsers'].forEach((element) {
      randomUsers.add(UsersHomeData.fromJson(element));
    });
  }
}

class UsersHomeData {
  String? id;
  String? userName;
  String? img;
  int? commission;
  bool? heBlockedMe;
  int? gender;
  bool? blockedByMe;
  UserInfo? userInfo;
  UsersHomeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    img = json['img'];
    commission = json['commission'];
    heBlockedMe = json['heBlockedMe'];
    gender = json['gender'];
    blockedByMe = json['blockedByMe'];
    userInfo =
        json['userInfo'] != null ? UserInfo.fromJson(json['userInfo']) : null;
  }
}

class UserInfo {
  String? id;
  String? userName;
  String? email;
  String? phone;
  String? lang;
  bool? closeNotify;
  bool? status;
  String? imgProfile;
  int? gender;
  int? code;
  String? city;
  int? age;
  int? height;
  int? weight;
  String? dowry;
  String? terms;
  bool? specialNeeds;
  bool? hideImg;
  
  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    phone = json['phone'];
    lang = json['lang'];
    closeNotify = json['closeNotify'];
    status = json['status'];
    imgProfile = json['imgProfile'];
    gender = json['gender'];
    code = json['code'];
    city = json['city'];
    age = json['age'];
    height = json['height'];
    weight = json['weight'];
    dowry = json['dowry'];
    terms = json['terms'];
    specialNeeds = json['specialNeeds'];
    hideImg = json['hideImg'];
  }
}
