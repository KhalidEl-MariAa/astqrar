import 'package:astarar/modules/packages/packages.dart';
import 'package:astarar/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class NotSubscribedScreen extends StatelessWidget {

  const NotSubscribedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
