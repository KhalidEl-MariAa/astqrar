
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class DefaultRaw extends StatelessWidget 
{
 final String image;
 final String text;

 DefaultRaw({required this.image,required this.text});

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Row(
        children: [
          Image.asset(
            image,
          ),
          SizedBox(width: 2.w,),
          Text(text,
              style: GoogleFonts.almarai(
                  fontSize: 12.sp, color: Colors.grey[500])),
          Spacer(),
          Padding(
            padding: EdgeInsetsDirectional.only(end: 5.w),
            child: Image.asset("assets/arrowGo.png"),
          )
        ],
      ),
    );
  }
}
