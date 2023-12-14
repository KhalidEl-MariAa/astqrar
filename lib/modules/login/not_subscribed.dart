import '../home/4_more/5_account/account.dart';
import 'login.dart';
import '../../shared/components/double_infinity_material_button.dart';
import '../../shared/styles/colors.dart';
import '../../utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

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
        body: 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child:
            Center(          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage("assets/bride_groom.jpeg")),
              SizedBox(height: 2.h),
              Text(
                "أنت غير مشترك، قم بالاشتراك حتى تتمكن من استخدام جميع مميزات استقرار",
                style: GoogleFonts.almarai(fontSize: 13.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 2.h,
              ),
              
              doubleInfinityMaterialButton(
                    text: "اشتراك",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PackagesScreen()));
                    }),
              
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
      ),
    );
  }
}
