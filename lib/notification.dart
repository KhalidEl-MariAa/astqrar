import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiticationWidget 
{
  final context1;
  static final FlutterLocalNotificationsPlugin _notification =
  FlutterLocalNotificationsPlugin();

  NotiticationWidget(this.context1);

  Future init({bool scheduled = false}) async 
  {
    var initAndroidSettings =
    const AndroidInitializationSettings('drawable/icon');

    var ios = IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );

    var settings = InitializationSettings(
      android: initAndroidSettings, 
      iOS: ios);
    
    //shows notification Permission box (Allow, Deny)
    await _notification.initialize(
      settings,
      onSelectNotification: (String? payload) {
        onSelectFunction(payload, context1);
      });
  }
  
  // when the user click on the Notification
  void onSelectFunction(payload, context) async 
  {
    print("hiiiiiiiiiiiiiiiiiiiiiii :" + payload.toString());
    // if (payload == "order") {} else {}
  }

  // display a dialog with the notification details, tap ok to go to another page
  Future onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async 
  {
    Container();
  }


  void requestIOSLocalNotificationsPermissions() 
  {
    FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future showNotification(int hashCode,
      {var id = 0, var title, var body, var payload}) async 
  {
    return
      _notification.show(
        id, title, body, 
        await notificationDetails(),
        payload: payload.toString() );
  }

  static notificationDetails() async 
  {
    return 
      const NotificationDetails(
        android: 
          AndroidNotificationDetails(
            "high_importance_channel111",
            "high_importance_channel",
            importance: Importance.high,
            priority: Priority.high,
          ),
        iOS: IOSNotificationDetails(),
      );
  }

}
