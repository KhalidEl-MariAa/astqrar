import 'package:astarar/modules/packages/packages.dart';
import 'package:astarar/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

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
           /*const    SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: 400,
                  child: Text(
                    "هذا النص هو مثال للنص يمكن ان يستبدل في نفس المساحة لقد تم توليد النص من مولد النص العربي حيث يمكن توليد العديد",
                    style: GoogleFonts.poppins(color: Colors.grey[400]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),*/
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
