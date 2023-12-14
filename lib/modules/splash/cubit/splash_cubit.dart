import 'dart:convert';
import 'dart:developer';


import '../../user_details/user_details.dart';
import '../../../notification.dart';
import '../../../shared/components/components.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import '../../../constants.dart';
import '../../../firebase_options.dart';
import '../../../shared/network/local.dart';

part 'splash_state.dart';




class SplashCubit extends Cubit<SplashState> 
{
  SplashCubit() : super(SplashInitial());


  static Future Firebase_init(BuildContext context) async
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
      log('Firebase completed ..................................');
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

    FirebaseMessaging.instance.getToken()
    .then((value) {
      DEVICE_TOKEN = value;
      CacheHelper.sharedpreferneces.setString("deviceToken", DEVICE_TOKEN!);
      log("\n\n DEVICE_TOKEN" + "  " + value.toString());
    })
    .catchError( (err) {
      log("DEVICE_TOKEN ERR: " + err.toString());
    });

    FirebaseMessaging.instance.getInitialMessage()
    .then((RemoteMessage? message) 
    {
      if (message != null) {
        log("Initial Message: " + message.toString() );
      }
    });

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // listen to any Notification Arrived
    FirebaseMessaging
      .onMessage
      .listen( (RemoteMessage message) 
      {
        log('Notification Arrived !!!!!!!!!'+ message.toString());
        
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        //foreground
        if (notification != null && android != null) 
        {
          NotificationWidget.showNotification(
            notification.hashCode,          
            title: notification.title,
            body: notification.body,
            payload: json.encode(message.data) , //to jsonStr
          );
        }
      });
      

    // Background: recieve message when the app is in background
    FirebaseMessaging
      .onBackgroundMessage( _firebaseMessagingBackgroundHandler ); 

    // Background: User clicked the Message while the App is in background
    FirebaseMessaging
      .onMessageOpenedApp
      .listen((event) 
      {
        if (event.data["NoteSenderId"] != null) 
        {
          // UserDetailsCubit.get(context).getOtherUser(otherId: event.data["NoteSenderId"] );
          navigateTo(
            context: context, 
            widget: UserDetailsScreen(
              messageVisibility: true,
              otherUserId: event.data["NoteSenderId"]!
            ) );
        }
      });

    //terminal
    FirebaseMessaging.instance.getInitialMessage()
      .then((event) 
      {
        if (event != null) 
        {
          log( "getInitialMessage() !!! " + event.data.toString() );
        }
      });

  } 
}

// Must be outside of the class and same name.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async 
{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if (IS_DEVELOPMENT_MODE) {
      // log("Handling a background message: ${message.notification?.body}");
      log("Handling a background message: ");
    }
}
