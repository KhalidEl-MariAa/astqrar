import 'package:astarar/modules/home/4_more/5_account/account.dart';
import 'package:astarar/modules/login/login.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:astarar/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../shared/components/components.dart';
import '../../shared/components/logo/normal_logo.dart';
import '../packages/packages.dart';

class NotSubscribedScreen extends StatefulWidget {
  const NotSubscribedScreen({Key? key}) : super(key: key);

  @override
  State<NotSubscribedScreen> createState() => _NotSubscribedScreenState();
}

class _NotSubscribedScreenState extends State<NotSubscribedScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(11.h),
            child: NormalLogo(
              appbarTitle: "عميل غير مشترك",
              isBack: ifThereAreMoreWidgets(context),
            )),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage("assets/Group 66606.png")),
              SizedBox(height: 2.h),
              Text(
                "برجاء الاشتراك حتي تتمكن من المحادثة",
                style: GoogleFonts.almarai(fontSize: 13.sp),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: doubleInfinityMaterialButton(
                    text: "اشتراك",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PackagesScreen()));
                    }),
              ),
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
                },
                child: Text(
                  "إعادة تسجيل دخول",
                  style: GoogleFonts.almarai(
                      color: PRIMARY,
                      fontSize: 13.sp,
                      decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => AccountScreen()),
                      (route) => true);
                },
                child: Text(
                  "مراجعة حالة الحساب",
                  style: GoogleFonts.almarai(
                      color: PRIMARY,
                      fontSize: 13.sp,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
