import 'package:astarar/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ContainerHome extends StatelessWidget {
  final String text;
  ContainerHome({required this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.grey[300],
      elevation: 5,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 8.h,
        width: 25.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.almarai(color: primary,fontWeight: FontWeight.w600,fontSize: 11.sp)
          ),
        ),
      ),
    );
  }
}
