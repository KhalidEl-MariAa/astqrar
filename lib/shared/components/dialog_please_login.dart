import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../modules/login/login.dart';
import '../styles/colors.dart';
import 'components.dart';

class DialogPleaseLogin extends StatelessWidget {
  const DialogPleaseLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        contentPadding: const EdgeInsetsDirectional.only(top: 0),
        titlePadding: const EdgeInsets.only(top: 0),
        title: Container(
          color: Colors.white.withOpacity(0.0),
          child: CircleAvatar(
            radius: 55,
            backgroundColor: WHITE,
            child: Image(
              image: Image.asset("assets/2000.gif").image,
              height: 10.h,
              width: 80.w,
            ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 0),
        ),
        actionsPadding: const EdgeInsetsDirectional.only(top: 0),
        actionsOverflowButtonSpacing: 0,
        content: Container(
            color: WHITE,
            height: 13.h,
            width: 90.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(
                      top: 2.h, start: 0, end: 0, bottom: 1.h),
                  child: Center(
                      child: Text(
                    "انت غير مسجل دخول",
                    style: GoogleFonts.almarai(
                        color: PRIMARY,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700),
                  )),
                ),
                Center(
                    child: Text(
                  "قم بتسجيل الدخول لاستخدام كل مميزات استقرار",
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w300,
                      fontSize: 12),
                )),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.only(top: 5, start: 0),
                      child: Text(
                        "استمرار بدون تسجيل الدخول",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.almarai(
                            color: PRIMARY,
                            fontSize: 9.sp,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                ),
              ],
            )),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 15, end: 15),
            child: doubleInfinityMaterialButton(
                text: "تسجيل دخول",
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false);
                }),
          ),
        ],
      ),
    );
  }
}
