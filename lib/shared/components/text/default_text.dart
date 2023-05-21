
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class DefaultText extends StatelessWidget {
  final String text;
  final int size;
  final  color;
  final FontWeight fontWeight;
   DefaultText({Key? key,required this.color,required this.size,required this.text,required this.fontWeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Text(
    text,
      style: GoogleFonts.almarai(
          fontSize: size.sp,
          color: color,
          fontWeight: fontWeight,
          letterSpacing: 2.5),
    );
  }
}
