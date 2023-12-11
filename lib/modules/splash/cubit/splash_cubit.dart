import 'dart:developer';


import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';
import '../../../constants.dart';
import '../../../firebase_options.dart';
import '../../../shared/network/local.dart';

part 'splash_state.dart';



Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async 
{
    // await Firebase.initializeApp();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if (IS_DEVELOPMENT_MODE) {
      // log("Handling a background message: ${message.notification?.body}");
      log("Handling a background message: ");
    }
}

class SplashCubit extends Cubit<SplashState> 
{
  SplashCubit() : super(SplashInitial());


  static Future Firebase_init() async
  {
    //FirebaseMessaging.instance.subscribeToTopic("all"); 

    // لا تعمل بشكل جيد ومش عارف السبب
    try {
      FirebaseMessaging.onBackgroundMessage( _firebaseMessagingBackgroundHandler );
    } catch (err) { 
      /* do nothing */
      log(err.toString());
    }   

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
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.notDetermined) {
      print('User Permission status is NOT Determined!');
    } else {
      print('User declined or has not accepted permission');
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


    // background State
    FirebaseMessaging.onMessageOpenedApp
    .listen((event) 
    {
      if (event.data["screen"] == "cart") {
      } else {}
    });

    //terminal
    FirebaseMessaging.instance.getInitialMessage()
    .then((event) {
      if (event != null) {
        if (event.data["screen"] == "cart") {
        } else {}
      }
    });

  } 



}
