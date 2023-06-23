
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HeaderLogo extends StatelessWidget 
{
  const HeaderLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h,horizontal: 15.w),
      child: Image(
        height: 22.h,
        width: 63.w,
        image: const AssetImage("assets/logo.png"),
        fit: BoxFit.contain,
      ),
    );
  }
}
