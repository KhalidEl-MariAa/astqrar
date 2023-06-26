import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';
import '../../shared/components/components.dart';
import '../../shared/network/remote.dart';
import '../../shared/styles/colors.dart';
import '../home/layout/cubit/cubit.dart';
import '../home/layout/cubit/states.dart';
import '../home/layout/layout.dart';
import '../login/login.dart';
import '../packages/packages.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> 
{
  @override
  void initState() 
  {
    super.initState();
    if(IS_LOGIN){
      checkuserIsExpired();
    }
    checkingData();
    
  }

  checkingData() async 
  {
    //  GlobalNotification.instance.setupNotification(context);
    Future.delayed(const Duration(seconds: 4), (() {
      if(IS_LOGIN == false) 
      {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute( builder: (context) => const LoginScreen() ),
          (route) => false,
        );
      }

      if(IS_LOGIN==true )
      {
        if(isExpired==true || IS_DEVELOPMENT_MODE){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LayoutScreen()),
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
              MaterialPageRoute( builder: (context) => const LoginScreen()),
              (route) => false,
            );
        }
      }

    }));
  }

  bool? isExpired;

  checkuserIsExpired(){
  DioHelper.postDataWithBearearToken(
    url: "api/v1/CheckUserIsExpiret?userId=$ID", 
    data: {},token: TOKEN.toString())
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
                  Image.asset("assets/logo.png", width: 300,),
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
