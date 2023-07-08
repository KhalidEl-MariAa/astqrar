import 'dart:developer';

import 'package:google_fonts/google_fonts.dart';

import '../../end_points.dart';
import 'cubit/splash_cubit.dart';
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

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    log("Handling a background message: ${message.notification?.body}");
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool? isExpired = true;

  @override
  void initState() {
    super.initState();

    LoadEveryThing();
  }

  LoadEveryThing() async {
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

    if (IS_LOGIN) {
      await checkuserIsExpired();
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
      if (this.isExpired == false ) {   //  || IS_DEVELOPMENT_MODE
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MyUpgrader(context: context, child: const LayoutScreen())),
          (route) => false,
        );
      } else if (this.isExpired == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const PackagesScreen()),
          (route) => false,
        );
        showToast(msg: "انتهت صلاحية الباقة لديك", state: ToastStates.WARNING);
      } else if (this.isExpired == null) {
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

  Future checkuserIsExpired() async {
    var value = await DioHelper.postDataWithBearearToken(
            url: "${CHECKUSERISEXPIRED}?userId=$ID",
            data: {},
            token: TOKEN.toString())
        // .then((value) {
        //   this.isExpired = value.data['isExpired'];
        //   log("Is_Expired :" + this.isExpired.toString());
        // }).catchError((error) {
        //   log(error.toString());
        // });
        ;
      this.isExpired = value.data['isExpired'];
      log("Is_Expired :" + this.isExpired.toString());

  }

  @override
  Widget build(BuildContext context) {
    // context.read<SplashCubit>().LoadEveryThing();

    return BlocConsumer<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashLoading) {}
      },
      builder: (context, state) => Directionality(
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
                    SizedBox(
                      height: 15.h,
                    ),
                    Image.asset(
                      "assets/logo.png",
                      width: 300,
                    ),
                    SizedBox(height: 5.h),
                    Image.asset("assets/quraan1.png", height: 6.h),
                    SizedBox(height: 5.h),
                    Text(
                      "برمجة م/سامي الفتني",
                      style: GoogleFonts.almarai(
                          color: WHITE,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold),
                    ),
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
