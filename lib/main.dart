import 'dart:io';

import 'package:astarar/layout/cubit/cubit.dart';
import 'package:astarar/modules/about_app/cubit/cubit.dart';
import 'package:astarar/modules/ads/cubit/cubit.dart';
import 'package:astarar/modules/conversation/more_for_delegate/cubit/cubit.dart';
import 'package:astarar/modules/delegates_section/cubit/cubit.dart';
import 'package:astarar/modules/details_user/cubit/cubit.dart';
import 'package:astarar/modules/home/cubit/cubit.dart';
import 'package:astarar/modules/more/cubit/cubit.dart';
import 'package:astarar/modules/packages/cubit/cubit.dart';
import 'package:astarar/modules/payment/cubit/cubit.dart';
import 'package:astarar/modules/search/cubit/cubit.dart';
import 'package:astarar/modules/section%20men%20_women/cubit/cubit.dart';
import 'package:astarar/modules/specific_delegate_screen/cubit/cubit.dart';
import 'package:astarar/modules/splash_screen/splash_screen.dart';
import 'package:astarar/notifications/cubit/cubit.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:astarar/shared/network/bloc_observer.dart';
import 'package:astarar/shared/network/local.dart';
import 'package:astarar/shared/network/remote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';


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

void main() async {

  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  await CacheHelper.init();
  token = CacheHelper.getData(key: "token");
  typeOfUser = CacheHelper.getData(key: "typeUser");
  id = CacheHelper.getData(key: "id");
  name = CacheHelper.getData(key: "name");
  age = CacheHelper.getData(key: "age");
  email = CacheHelper.getData(key: "email");
  genderUser = CacheHelper.getData(key: "gender");
  phone = CacheHelper.getData(key: "phone");

  isLogin = CacheHelper.getData(key: "isLogin") ?? false;

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, devicetype) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<AppCubit>(
                  create: (BuildContext context) =>
                  AppCubit()
                    ..getSpecifications()
                    ..getPhone()),
              BlocProvider<HomeCubit>(
                  create: (BuildContext context) =>
                  HomeCubit()

                    ..getUserAds()),
              BlocProvider<GetPackagesCubit>(
                  create: (BuildContext context) =>
                  GetPackagesCubit()
                    ..getPackages()),
              BlocProvider<AdsCubit>(
                  create: (BuildContext context) =>
                  AdsCubit()
                    ..getAds()),
              BlocProvider<GetUserByGenderCubit>(
                  create: (BuildContext context) => GetUserByGenderCubit()),
              BlocProvider<GetInformationCubit>(
                  create: (BuildContext context) => GetInformationCubit()),
              BlocProvider<SettingsCubit>(
                  create: (BuildContext context) => SettingsCubit()),
              BlocProvider<SearchCubit>(
                  create: (BuildContext context) => SearchCubit()),
              BlocProvider<DelegatesCubit>(
                  create: (BuildContext context) =>
                  DelegatesCubit()
                    ..getDelegates()),
              BlocProvider<AboutUsCubit>(
                  create: (BuildContext context) =>
                  AboutUsCubit()
                    ..aboutUs()),

              BlocProvider<NotificationCubit>(
                  create: (BuildContext context) =>
                  NotificationCubit()
                    ..getNotifications()),
              BlocProvider<PaymentCubit>(
                  create: (BuildContext context) => PaymentCubit()),

              BlocProvider<PaymentDelegateCubit>(
                  create: (BuildContext context) => PaymentDelegateCubit()),
              BlocProvider<ProfileDeleagateCubit>(
                  create: (BuildContext context) => ProfileDeleagateCubit())
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
              home: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Splash()),
            ),
          );
        }
    );
  }
}
