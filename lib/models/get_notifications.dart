class GetNotificationsModel{
List<NotificationDataModel>data=[];
  GetNotificationsModel.fromJson(Map<String,dynamic>json){
    json['data'].forEach((element) {
      data.add(NotificationDataModel.fromJson(element));
    });
  }
}

class NotificationDataModel{
  NotificationDetailsModel?notification;
UserInformationWhoSendNotification?userInformation;
  NotificationDataModel.fromJson(Map<String,dynamic>json){
    userInformation = json['userInformation'] != null
        ? UserInformationWhoSendNotification.fromJson(json['userInformation'])
        : null;
    notification = json['notification'] != null
        ? NotificationDetailsModel.fromJson(json['notification'])
        : null;
  }
}

class NotificationDetailsModel{
int?notificationType;
int?id;
String?message;
String?time;
  NotificationDetailsModel.fromJson(Map<String,dynamic>json){
    notificationType=json['notificationType'];
    id=json['id'];
    message=json['message'];
    time=json['time'];
  }
}

class UserInformationWhoSendNotification{
int?gender;
String?user_Name;
String?id;
int?typeUser;
  UserInformationWhoSendNotification.fromJson(Map<String,dynamic>json){
    gender=json['gender'];
    user_Name=json['user_Name'];
    id=json['id'];
    typeUser=json['typeUser'];
  }
}