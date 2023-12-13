
import 'user.dart';

class GetNotificationsModel 
{
  List<NotificationDataModel> data = [];
  GetNotificationsModel.fromJson(Map<String, dynamic> json) 
  {
    json['data'].forEach((e) {
      data.add(NotificationDataModel.fromJson(e));
    });

    json['admin_notes'].forEach((e) {
      data.add(NotificationDataModel.fromJson(e));
    });

    // accending a.age.compareTo(b.age)
    this.data.sort((a, b) => b.notification!.time!.compareTo(a.notification!.time!));

  }
}

class NotificationDataModel 
{
  AppNotification? notification;
  User? userInformation;

  NotificationDataModel.fromJson(Map<String, dynamic> json) {
    userInformation =  User.fromJson(json['userInformation']) ;
    notification = AppNotification.fromJson(json['notification']) ;
  }
}

class AppNotification 
{
  int? notificationType;
  int? id;
  String? message;
  String? time;

  AppNotification.fromJson(Map<String, dynamic>? json) 
  {
    if(json == null) return ;

    notificationType = json['notificationType'];
    id = json['id'];
    message = json['message'];
    time = json['time'];
  }
}

abstract class NotificationTypes
{  
  static int SendChatRequest = 0;
  static int AcceptChatRequest = 1;
  static int IgnoreChatRequest = 2;
  static int ChattMessageArrived = 3;
  static int LikedBySomeone = 4;
  static int BlockedBySomeone = 5;
  static int ProfileIsVisited = 6;
  static int AddedToHisList = 7;
  static int AdIsPublished = 8;
  static int WelcomeNewUser= 9;
  static int MsgFromDashBord = 10;
  static int AccountIsRemoved = 11;
  static int BlockedByDashboard = 12;
}