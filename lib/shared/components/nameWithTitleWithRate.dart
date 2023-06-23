
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';
import '../styles/colors.dart';

class NameWithTitleWithRATE extends StatelessWidget {
  final int gender;
  final String userName;
  final String userRate;
  const NameWithTitleWithRATE({Key? key,required this.gender,required this.userName,required this.userRate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 11.h,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 2.w),
          child: Row(
            children: [
              Image(
                width: 15.w,
                height:15.h ,
                image:gender==1? AssetImage(maleImage):AssetImage(femaleImage),
              ),
              SizedBox(
                width: 2.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userName,
                    style: GoogleFonts.poppins(fontSize: 10.sp),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Text(
                      " ",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                          color: black, fontSize: 8.sp)),
                ],
              ),
           const   Spacer(),
              Row(
                children: [
                  Text(userRate,style: GoogleFonts.poppins(fontSize: 8.sp),),
                  Icon(
                    Icons.star,
                    color: primary,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
