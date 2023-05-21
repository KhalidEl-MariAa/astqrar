import 'dart:developer';

import 'package:astarar/layout/cubit/cubit.dart';
import 'package:astarar/layout/cubit/states.dart';
import 'package:astarar/layout/layout.dart';
import 'package:astarar/modules/linkperson/layout_linkPerson/layout_link_person.dart';
import 'package:astarar/modules/login/login.dart';
import 'package:astarar/modules/packages/packages.dart';
import 'package:astarar/shared/components/components.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:astarar/shared/network/end_points.dart';
import 'package:astarar/shared/network/remote.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    if(isLogin&&typeOfUser==1){
      checkuserIsExpired();
    }
    checkingData();
    super.initState();
  }

  checkingData() async {
    //  GlobalNotification.instance.setupNotification(context);
    Future.delayed(const Duration(seconds: 4), (() {
      if (isLogin == false) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      }
      if(isLogin==true&&typeOfUser==1){
        if(isExpired==true){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
        );
      }
        if(isExpired==false){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const PackagesScreen()),
                (route) => false,
          );
          showToast(msg: "انتهت صلاحية الباقة لديك", state: ToastStates.WARNING);
        }

        if(isExpired==null){

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
            );

        }
      }
      if(isLogin==true&&typeOfUser==2){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LayoutLinkPerson()),
              (route) => false,
        );
      }

    }));
  }

  bool? isExpired;

  checkuserIsExpired(){
  DioHelper.postDataWithBearearToken(url: "api/v1/CheckUserIsExpiret?userId=$id", data: {},token: token.toString())
  .then((value) {
    log(value.toString());
    isExpired=value.data['isActive'];
    log("expire"+isExpired.toString());
  }).catchError((error){
    log(error.toString());
  });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        backgroundColor: HexColor("303031"),
        body: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.bottomCenter,
          color: backGround,
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
                  Image.asset("assets/quraan.PNG", height: 6.h),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
