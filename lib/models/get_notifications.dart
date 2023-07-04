
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
  NotificationDetailsModel? notification;
  User? userInformation;

  NotificationDataModel.fromJson(Map<String, dynamic> json) {
    userInformation =  User.fromJson(json['userInformation']) ;
    notification = NotificationDetailsModel.fromJson(json['notification']) ;
  }
}

class NotificationDetailsModel 
{
  int? notificationType;
  int? id;
  String? message;
  String? time;

  NotificationDetailsModel.fromJson(Map<String, dynamic>? json) 
  {
    if(json == null) return ;

    notificationType = json['notificationType'];
    id = json['id'];
    message = json['message'];
    time = json['time'];
  }
}

