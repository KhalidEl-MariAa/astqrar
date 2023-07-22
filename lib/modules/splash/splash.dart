import 'dart:developer';

import 'package:astarar/models/server_response_model.dart';
import 'package:astarar/modules/login/not_subscribed.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../end_points.dart';
import 'cubit/splash_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../constants.dart';
import '../../shared/components/components.dart';
import '../../shared/components/upgrader.dart';
import '../../shared/network/local.dart';
import '../../shared/network/remote.dart';
import '../../shared/styles/colors.dart';
import '../home/layout/cubit/cubit.dart';
import '../home/layout/layout.dart';
import '../login/login.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> 
{
  bool? loginStatus = true;
  
  String loading_desc = "";
  PackageInfo? info;

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async 
  {
      // await Firebase.initializeApp();
      await Firebase.initializeApp(
        name: "astqrar65", //project name in Firebase Console
        options: DefaultFirebaseOptions.currentPlatform,
      );

      if (kDebugMode) {
        // log("Handling a background message: ${message.notification?.body}");
        log("Handling a background message: ");
      }
  }

  @override
  void initState() 
  {
    super.initState();

    LoadEveryThing();
  }

  LoadEveryThing() async 
  {
    setState(() { loading_desc = "Getting device information..."; });
    this.info = await PackageInfo.fromPlatform();

    setState(() { loading_desc = "Connecting to server..."; });
    await DioHelper.init();

    setState(() { loading_desc = "Collecting cache data..."; });
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

    //await Firebase.initializeApp();

    setState(() { loading_desc = "Connecting to notification provider..."; });

    // لا تعمل بشكل جيد ومش عارف السبب
    // try {
    //   FirebaseMessaging.onBackgroundMessage( _firebaseMessagingBackgroundHandler );
    // } catch (err) { 
    //   /* do nothing */
    // }   

    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      name: "astqrar65", //project name in Firebase Console
      options: DefaultFirebaseOptions.currentPlatform,
    );

    //---------------

    setState(() { loading_desc = "Checking login status..."; });
    if (IS_LOGIN) {
      await checkUserLoginStatus();
      updateLastLogin();
    }

    context.read<LayoutCubit>().loadCountries();
    chckLoginStatusAndRoute();
  }

  void chckLoginStatusAndRoute() {
    if (IS_LOGIN == false) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MyUpgrader(context: context, child: const LoginScreen())),
        (route) => false,
      );
    }

    if (IS_LOGIN == true) {
      if (this.loginStatus == true) {
        //  || IS_DEVELOPMENT_MODE
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MyUpgrader(context: context, child: const LayoutScreen())),
          (route) => false,
        );
      } else if (this.loginStatus == false) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const NotSubscribedScreen()),
          (route) => false,
        );
        showToast(msg: "غير مسموح لك بالدخول، راجع حالة الحساب", state: ToastStates.WARNING);
      } else if (this.loginStatus == null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MyUpgrader(context: context, child: const LoginScreen())),
          (route) => false,
        );
        showToast(
            msg: "حصلت مشكلة في التحقق من تاريخ صلاحية الحساب",
            state: ToastStates.ERROR);
      }
    }
  }

  Future checkUserLoginStatus() async 
  {
    var value = await DioHelper.postDataWithBearearToken(
        url: CHECKUSERLOGINSTATUS, 
        token: TOKEN.toString(), 
        data: {"userId": ID}
    );

    this.loginStatus = value.data['status'];
    log("LOGIN STATUS :" + this.loginStatus.toString());
  }

  Future updateLastLogin() async {
    DioHelper.postDataWithBearearToken(
      url: UPDATELASTLOGIN,
      token: TOKEN.toString(),
      data: {"userId": ID},
    ).then((value) {
      ServerResponse res = ServerResponse.fromJson(value.data);
      if (res.key == 0) {}
    }).catchError((error) {
      log(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    // context.read<SplashCubit>().LoadEveryThing();

    return BlocConsumer<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashLoading) {}
      },
      builder: (context, state) => 
        Scaffold(
          backgroundColor: BG_DARK_COLOR,
          body: Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.bottomCenter,
            color: BG_DARK_COLOR,
            child: Center(
              child: AnimatedContainer(
                curve: Curves.easeInCirc,
                duration: Duration(seconds: 150),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox( height: 15.h, ),
                    Image.asset( "assets/logo.png", width: 300,),
                    
                    SizedBox(height: 5.h),
                    
                    Image.asset("assets/quraan1.png", height: 6.h),
                    SizedBox(height: 5.h),
                    
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: 
                        Text(
                          "برمجة م/سامي الفتني",
                          style: GoogleFonts.almarai(
                              color: WHITE,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold),
                        ),
                    ),
                    
                    SizedBox(height: 5.h),
                    Text(
                      this.info == null? 
                      ""
                      :
                      "version: ${this.info?.version}+${this.info?.buildNumber} ",
                      style: GoogleFonts.courierPrime(
                          color: WHITE,
                          fontSize: 9.sp,),
                    ),

                    const Spacer(),
                    Text(
                      this.loading_desc,
                      style: GoogleFonts.courierPrime(
                          color: WHITE,
                          fontSize: 9.sp,
                          ),
                    ),

                    SizedBox(height: 2.h),

                  ],
                ),
              ),
            ),
          ),
        ),
      
    );
  }
}
