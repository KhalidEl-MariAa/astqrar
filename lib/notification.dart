import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiticationWidget 
{
  final context1;
  static final FlutterLocalNotificationsPlugin _notification =
  FlutterLocalNotificationsPlugin();

  NotiticationWidget(this.context1);

  Future init({bool scheduled = false}) async {
    var initAndroidSettings =
    const AndroidInitializationSettings('drawable/icon');
    var ios = IOSInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );
    var settings =
    InitializationSettings(android: initAndroidSettings, iOS: ios);
    await _notification.initialize(settings,

        onSelectNotification: (String? payload) {
          onSelectFunction(payload, context1);
        });
  }

  Future onDidReceiveLocalNotification(int id, String? title, String? body,
      String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    Container();
  }

  void onSelectFunction(payload, context) async {
    //   print("hi");
    if (payload == "order") {} else {}
  }

  void requestIOSPermissions() {
    FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future showNotification(int hashCode,
      {var id = 0, var title, var body, var payload}) async =>
      _notification.show(id, title, body, await notificationDetails(),
          payload: payload);

  static notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "high_importance_channel111",
        "high_importance_channel",
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: IOSNotificationDetails(),);
  }

}
