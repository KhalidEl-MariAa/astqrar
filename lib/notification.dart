import 'dart:convert';
import 'dart:developer';

import 'modules/user_details/cubit/cubit.dart';
import 'modules/user_details/user_details.dart';
import 'shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationWidget 
{
  final context1;
  static final FlutterLocalNotificationsPlugin _notification =
  FlutterLocalNotificationsPlugin();

  NotificationWidget(this.context1);

  Future init({bool scheduled = false}) async 
  {
    // ./android/app/src/main/res/drawable/icon.png
    var initAndroidSettings = const AndroidInitializationSettings('drawable/icon.png');

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
  
  // display a dialog with the notification details, tap ok to go to another page
  Future onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async 
  {
    Container();
  }

  static Future showNotification(int hashCode,
      {int id = 0, String? title, String? body, String? payload}) async 
  {
    return
      _notification.show(
        id, title, body, 
        await notificationDetails(),
        payload: payload
      );
  }

  // when the user click on the Notification
  void onSelectFunction(payload, context) async 
  {    
    log("hiiiiiiiiiiiiiiiiiiiiiii : From Notification Click" );
    Map msgData  = json.decode(payload);

    if ( msgData["NoteSenderId"] != null ){
      UserDetailsCubit.get(context).getOtherUser(otherId: msgData["NoteSenderId"] );
      navigateTo(context: context, widget: UserDetailsScreen(messageVisibility: true,) );
    }

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

  static notificationDetails() async 
  {
    return 
      const NotificationDetails(
        android: 
          AndroidNotificationDetails(
            "high_importance_channel111", /* channelid */
            "high_importance_channel",  /* channelName */
            importance: Importance.high,
            priority: Priority.high,
          ),
        iOS: IOSNotificationDetails(),
      );
  }

}
