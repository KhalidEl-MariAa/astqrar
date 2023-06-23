import '../../modules/home/layout/layout.dart';
import '../styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class SuccessDialog extends StatelessWidget {
  final String successText;
  final String subTitle;
  final String actionText;
  SuccessDialog({Key? key,required this.successText,required this.subTitle,required this.actionText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Container(
        height: 25.h,
        width: 100.w,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: const AssetImage("assets/checkmark.png"),
                  height: 9.h,
                  width: 20.w,
                ),
              ],
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Text(
            successText,

              style: GoogleFonts.almarai(
              letterSpacing: 1,
                  fontSize: 13.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
            subTitle,
              style: GoogleFonts.almarai(color: customGrey, fontSize: 10.sp),
            ),
            SizedBox(
              height: 4.h,
            ),
            InkWell(
              onTap: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LayoutScreen()), (route) => false);
              },
              child: Center(
                  child: Text(
                    actionText,
                    style: GoogleFonts.poppins(color: primary,decoration: TextDecoration.underline),
                  )),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Material(
            //       shadowColor: primary,
            //       elevation: 3,
            //       child: Container(
            //         height: 6.h,
            //         width: 25.w,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         child: Center(
            //             child: Text(
            //          actionText,
            //           style: GoogleFonts.poppins(color: primary),
            //         )),
            //       ),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
