import 'dart:developer';

import 'package:astarar/main.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationController 
{
  static ReceivedAction? initialAction;

  /// When a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future <void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async 
  {
    // Your code goes here
    log('@@@@@@ new notification or a schedule is created ');
  }

  /// Every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future <void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async 
  {
    // Your code goes here
    log('@@@@@@ new notification is displayed ');
  }

  /// When the user dismissed a notification
  @pragma("vm:entry-point")
  static Future <void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async 
  {
    // Your code goes here
    log('@@@@@@ user dismissed a notification ');
  }

  /// When the user taps on a notification or action button.
  @pragma("vm:entry-point")
  static Future <void> onActionReceivedMethod(ReceivedAction receivedAction) async 
  {
    log('@@@@@@ the user Clicks on a notification or action button ');

    if( receivedAction.payload?['NoteSenderId'] != null)
    {

      MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/user-details',
        (route) => (route.settings.name != '/user-details') || route.isFirst,
        arguments: {"otherUserId" : receivedAction.payload?['NoteSenderId'] } 
      );

    }

  }
}