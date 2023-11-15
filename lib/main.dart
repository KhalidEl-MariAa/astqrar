import 'dart:io';

import 'modules/splash/cubit/splash_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

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
import 'modules/splash/splash.dart';
import 'modules/user_details/cubit/cubit.dart';
import 'shared/network/bloc_observer.dart';


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
  IS_DEVELOPMENT_MODE = !kReleaseMode; 

  HttpOverrides.global = MyHttpOverrides();

  Bloc.observer = MyBlocObserver();

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

              BlocProvider<SplashCubit>(
                  create: (BuildContext context) => SplashCubit()),


            ],
            child: 
              MaterialApp(
                debugShowCheckedModeBanner: false,
                title: APP_NAME,
                home: Splash(),
                theme: ThemeData(
                  primarySwatch: Colors.grey,
                ),

            ),
          );
        }
    );
  }
}

