import 'dart:developer';

import 'package:astarar/modules/splash/cubit/splash_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
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
import '../packages/packages.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async 
{
  await Firebase.initializeApp();
  if (kDebugMode) {
    log("Handling a background message: ${message.notification?.body}");
  }
}

class Splash extends StatefulWidget 
{
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> 
{
  bool? isExpired;

  @override
  void initState() 
  {
    super.initState();
    
    LoadEveryThing();
  }

  LoadEveryThing() async 
  {
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

    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    if(IS_LOGIN){
      await checkuserIsExpired();
    }

    context.read<LayoutCubit>().loadCountries();
    chckLoginStatusAndRoute();

  }

  void chckLoginStatusAndRoute() 
  {
      if(IS_LOGIN == false) 
      {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute( builder: (context) => 
            MyUpgrader(context: context, child: const LoginScreen() )
          ),
          (route) => false,
        );
      }
    
      if(IS_LOGIN==true )
      {
        if(isExpired==true || IS_DEVELOPMENT_MODE){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => 
              MyUpgrader(context: context, child: const LayoutScreen() )
            ),
            (route) => false,
          );
        }
        else if(isExpired==false){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const PackagesScreen()),
            (route) => false,
          );
          showToast(msg: "انتهت صلاحية الباقة لديك", state: ToastStates.WARNING);
        }
        else if(isExpired==null)
        {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute( builder: (context) => 
                MyUpgrader(context: context, child: const LoginScreen() )
              ),
              (route) => false,
            );
        }
      }
  }

  checkuserIsExpired()
  {
    DioHelper.postDataWithBearearToken(
      url: "api/v1/CheckUserIsExpiret?userId=$ID", 
      data: {},token: TOKEN.toString())
    .then((value) {
      log(value.toString());
      isExpired = value.data['isActive'];
      log("expire"+isExpired.toString());
    }).catchError((error){
      log(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) 
  {
    // context.read<SplashCubit>().LoadEveryThing();

    return BlocConsumer<SplashCubit, SplashState>(
      listener: (context, state) 
      {
        if(state is SplashLoading){}

      },
      builder: (context, state) => 
      Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
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
                    SizedBox(height: 15.h,),
                    Image.asset("assets/logo.png", width: 300,),
                    
                    SizedBox(height: 5.h),
                    Image.asset("assets/quraan1.png", height: 6.h),
                    
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
