import 'dart:developer';
import 'dart:io';

import 'package:astarar/modules/home/layout/layout.dart';
import 'package:astarar/modules/login/login.dart';
import 'package:astarar/modules/user_details/user_details.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:upgrader/upgrader.dart';

import 'bloc_observer.dart';
import 'constants.dart';
import 'modules/ads/cubit/cubit.dart';
import 'modules/home/2_home_tab/cubit/cubit.dart';
import 'modules/home/4_more/1_about/cubit/cubit.dart';
import 'modules/home/4_more/cubit/cubit.dart';
import 'modules/home/layout/cubit/cubit.dart';
import 'modules/packages/cubit/cubit.dart';
import 'modules/payment/cubit/cubit.dart';
import 'modules/search/cubit/cubit.dart';
import 'modules/section_men_women/cubit/cubit.dart';
import 'modules/splash/cubit/splash_cubit.dart';
import 'modules/splash/splash.dart';
import 'modules/user_details/cubit/cubit.dart';


class MyHttpOverrides extends HttpOverrides 
{
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      // ..findProxy = (uri) { return "7054"; }
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}



void main()  async
{
  
  IS_DEVELOPMENT_MODE = !kReleaseMode; // kDebugMode

  HttpOverrides.global = MyHttpOverrides();

  Bloc.observer = MyBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();

  if(IS_DEVELOPMENT_MODE)
    await Upgrader.clearSavedSettings(); 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget 
{
  //todo: better change place 
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) 
  {
    return Sizer(
      builder: (context, orientation, devicetype) 
      {
        return 
          MultiBlocProvider(
            child: 
              MaterialApp(
                debugShowCheckedModeBanner: false,
                navigatorKey: MyApp.navigatorKey,
                title: APP_NAME,
                // home: Splash(),
                theme: ThemeData( primarySwatch: Colors.grey,),

                initialRoute: '/',
                routes: <String, WidgetBuilder>
                {
                  '/' : (context) => Splash(),
                  '/login' : (context) => LoginScreen(),
                  '/user-details' : (context) {
                    final Map args = ModalRoute.of(context)?.settings.arguments as Map;  
                    return UserDetailsScreen(otherUserId: args['otherUserId'],);
                  } ,
                },
            ),
            providers: [

              BlocProvider<SplashCubit>(
                  create: (BuildContext context) => SplashCubit()),

              BlocProvider<LayoutCubit>(
                  create: (BuildContext context) =>
                    LayoutCubit()
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

              BlocProvider<MenWomenCubit>(
                  create: (BuildContext context) => MenWomenCubit()),

              BlocProvider<UserDetailsCubit>(
                  create: (BuildContext context) => UserDetailsCubit()),

              BlocProvider<MoreTabCubit>(
                  create: (BuildContext context) => MoreTabCubit()),

              BlocProvider<SearchCubit>(
                  create: (BuildContext context) => SearchCubit()),

              BlocProvider<AboutUsCubit>(
                  create: (BuildContext context) => AboutUsCubit()..aboutUs()),


              BlocProvider<PaymentCubit>(
                  create: (BuildContext context) => PaymentCubit()),



            ],
          );
      }
    );
  }
}

