import 'package:astarar/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

Widget doubleInfinityMaterialButton({
  String? text,
  Widget? child,
  required Function onPressed,
}) {
  return Padding(
    padding: EdgeInsetsDirectional.only(start: 3.w, end: 3.w),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          color: PRIMARY),
      child: MaterialButton(
        child: (text != null)? 
            Text( text,
                style: GoogleFonts.almarai(color: WHITE, fontSize: 14.sp, fontWeight: FontWeight.bold),
              )
          : 
            child,
        onPressed: () { onPressed(); },
      ),
    ),
  );
}
