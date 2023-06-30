import 'dart:io';


import 'package:upgrader/upgrader.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'constants.dart';
import 'modules/ads/cubit/cubit.dart';
import 'modules/home/1_notifications/cubit/cubit.dart';
import 'modules/home/2_home_tab/cubit/cubit.dart';
import 'modules/home/4_more/1_about/cubit/cubit.dart';
import 'modules/home/4_more/cubit/cubit.dart';
import 'modules/home/layout/cubit/cubit.dart';
import 'modules/packages/cubit/cubit.dart';
import 'modules/payment/cubit/cubit.dart';
import 'modules/search/cubit/cubit.dart';
import 'modules/section_men_women/cubit/cubit.dart';
import 'modules/splash_screen/splash_screen.dart';
import 'modules/user_details/cubit/cubit.dart';
import 'shared/network/bloc_observer.dart';
import 'shared/network/local.dart';
import 'shared/network/remote.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print("Handling a background message: ${message.notification?.body}");
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      // ..findProxy = (uri) { return "7054"; }
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() async 
{
  IS_DEVELOPMENT_MODE = !kReleaseMode; 

  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
  await DioHelper.init();

  await CacheHelper.init();
  
  TOKEN = CacheHelper.getData(key: "token");
  TYPE_OF_USER = CacheHelper.getData(key: "typeUser");
  ID = CacheHelper.getData(key: "id");
  NAME = CacheHelper.getData(key: "name");
  AGE = CacheHelper.getData(key: "age");
  EMAIL = CacheHelper.getData(key: "email");
  GENDER_USER = CacheHelper.getData(key: "gender");
  PHONE = CacheHelper.getData(key: "phone");

  IS_LOGIN = CacheHelper.getData(key: "isLogin") ?? false;

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget 
{
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) 
  {
    return Sizer(
        builder: (context, orientation, devicetype) 
        {
          return MultiBlocProvider(
            providers: [
              BlocProvider<AppCubit>(
                  create: (BuildContext context) =>
                  AppCubit()
                    ..loadSpecificationsFromBackend()
                    ..loadCountries()
                    ..getPhone()
              ),

              BlocProvider<HomeCubit>(
                  create: (BuildContext context) => HomeCubit()..getUserAds()),

              BlocProvider<GetPackagesCubit>(
                  create: (BuildContext context) => GetPackagesCubit()..getPackages()),

              BlocProvider<AdsCubit>(
                  create: (BuildContext context) => AdsCubit()..getAds()),

              BlocProvider<GetUserByGenderCubit>(
                  create: (BuildContext context) => GetUserByGenderCubit()),

              BlocProvider<UserDetailsCubit>(
                  create: (BuildContext context) => UserDetailsCubit()),

              BlocProvider<SettingsCubit>(
                  create: (BuildContext context) => SettingsCubit()),

              BlocProvider<SearchCubit>(
                  create: (BuildContext context) => SearchCubit()),

              BlocProvider<AboutUsCubit>(
                  create: (BuildContext context) => AboutUsCubit()..aboutUs()),


              BlocProvider<PaymentCubit>(
                  create: (BuildContext context) => PaymentCubit()),

            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'استقرار',
              theme: ThemeData(
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.

                primarySwatch: Colors.grey,
              ),

              home: 
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Splash()
                ),

              
              
            ),
          );
        }
    );
  }
}
