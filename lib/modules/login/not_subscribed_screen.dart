import '../../shared/components/logo/normal_logo.dart';
import '../packages/packages.dart';
import '../../shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

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
                isBack: true,
                appbarTitle: "ssssالفلتر",
              )),       
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const  Image(image: AssetImage("assets/Group 66606.png")),
              SizedBox(height: 5.h),
              Text(
                "برجاء الاشتراك حتي تتمكن من المحادثة",
                style: GoogleFonts.almarai(fontSize: 13.sp),
              ),

              SizedBox(height: 10.h,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: doubleInfinityMaterialButton(text: "اشتراك", onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const PackagesScreen()));
                }),

              )
            ],
          ),
        ),
      ),
    );
  }
}
