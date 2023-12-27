import 'dart:developer';
import 'package:astarar/main.dart';
import 'package:astarar/models/get_notifications.dart';
import 'package:astarar/modules/home/2_home_tab/cubit/cubit.dart';
import 'package:astarar/modules/login/login.dart';
import 'package:astarar/notification_controller.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../user_details/user_details.dart';
import '../../../shared/components/components.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../../constants.dart';
import '../../../firebase_options.dart';
import '../../../shared/network/local.dart';

part 'splash_state.dart';




class SplashCubit extends Cubit<SplashState> 
{
  SplashCubit() : super(SplashInitial());

  static Future AwesomeNotifications_init() async
  {

    await AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      // set default app icon using  flutter_launcher_icons in `pubspec.yaml`
      // 'resource://drawable/res_app_icon',
      // 'asset://assets/icon.png',
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic Notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white,
        )
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true
    );
    
    await AwesomeNotifications().isNotificationAllowed()
    .then( (isAllowed) 
    {
      if( !isAllowed ){
        AwesomeNotifications().requestPermissionToSendNotifications();
      }      
    });


    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod:         NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:    NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod
    );

    NotificationController.initialAction = await AwesomeNotifications().getInitialNotificationAction(removeFromActionEvents: false);
  } // function

  static Future Firebase_init( ) async
  {

    //FirebaseMessaging.instance.subscribeToTopic("all"); 

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      // name: "astqrar65", /* DON'T USE IT WITH DEFAULT OPTIONS */
      options: DefaultFirebaseOptions.currentPlatform,
    ).then((value){
      log('Firebase initialized ${value.toString()}' );
    })
    .catchError( (err) {
      log('Firebase initialization ERROR ${err.toString()}' );
    })
    .whenComplete(() {
      log('Firebase initialization is Completed ..................................');
    });

    // directly after initialization
    await FirebaseMessaging.instance.getToken()
    .then((value) {
      DEVICE_TOKEN = value;
      CacheHelper.sharedpreferneces.setString("deviceToken", DEVICE_TOKEN!);
      log("\n\n DEVICE_TOKEN" + "  " + value.toString());
    })
    .catchError( (err) {
      log("DEVICE_TOKEN ERR: " + err.toString());
    });

    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,  //important
      sound: true,
    );

    
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.notDetermined) {
      log('User Permission status is NOT Determined!');
    } else {
      log('User declined or has not accepted permission');
    }

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );


    // Foreground: when the message arrived (does NOT show the Notification)
    FirebaseMessaging.onMessage.listen( (RemoteMessage? message) 
      {
        log('Notification Arrived !!!!!!!!!' );
        onMessageArrived( message );
        showTheNotification( message );
      });
      
    // Background: User clicked the Message while the App is in background
    FirebaseMessaging.onMessageOpenedApp.listen( onMessageClicked );

    // Background: recieve message when the app is in background
    FirebaseMessaging
      .onBackgroundMessage( _firebaseMessagingBackgroundHandler ); 

  } // end function

  
  static void initialMsgHandler()
  {
    // Terminate: When Click on Notification to open App from terminate state
    FirebaseMessaging.instance.getInitialMessage()
    .then((RemoteMessage? message) 
    {
      showToast( msg: "getInitialMessage() !!! ${ message?.data.toString() }  !!!! ",  state: ToastStates.SUCCESS );

      onMessageArrived( message );
      // onMessageClicked( message ); //not working 
    });     
  }

}//end class


void onMessageArrived(RemoteMessage? message)  
{
  if(message==null || message.notification == null) return;

  log(message.data.toString());

  if( message.data['NotificationType'] == NotificationTypes.BlockedByDashboard.toString() ){
    log('Notification Arrived BlockedByDashboard ') ;
    CacheHelper.saveData(key: "isLogin", value: false);
    IS_LOGIN = CacheHelper.getData(key: "isLogin");

    MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
      '/login',
      (route) => (route.settings.name != '/login') || route.isFirst,
    );
  }

  if( message.data['NotificationType'] == NotificationTypes.AdIsPublished.toString() ){
    log('Notification Arrived AdIsPublished ') ;
    HomeCubit()..getUserAds();
  }

}//end function

void onMessageClicked(RemoteMessage? message)  
{
  if(message==null ) return;
  
  log("You Clicked on the message #### ");

  //NotificationTypes.AdIsPublished
  //NotificationTypes.ChattMessageArrived
  if (message.data["NoteSenderId"] != null) 
  {
    MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
      '/user-details',
      (route) => (route.settings.name != '/user-details') || route.isFirst,
      arguments: {"otherUserId" : message.data["NoteSenderId"]! } 
    );
  }
}

void showTheNotification(RemoteMessage? message) 
{
  if(message==null ) return;

  Map<String, String> data = message.data.map( (k,v) => MapEntry<String, String>(k, v.toString()) );

  // Show notification on foreground
  AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        actionType: ActionType.Default,
        title: message.notification?.title,
        body: message.notification?.body,
        payload: data, 
        largeIcon: data['NoteSenderImg'], // http is not working, use https
        // largeIcon: 'resource://mipmap-mdpi/launcher_icon.png', // ./android/app/src/main/res/
        // largeIcon:  'asset://assets/icon.png',
        // largeIcon: 'https://estqrar-001-site1.ctempurl.com/images/close.png',
        // largeIcon: 'http://estqrar-001-site2.ctempurl.com/images/close.png',
        roundedLargeIcon: true,
    )
  );    
}


// Must be outside of the class and same name.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage? message) async 
{
    if(message==null)return;

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    log("Handling a background message: ");
    log(" ${message.notification?.toString() }");
}

