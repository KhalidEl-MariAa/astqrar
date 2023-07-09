import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../shared/styles/colors.dart';
import '../login/login.dart';

class AlreadyHaveAccountText extends StatelessWidget 
{
  const AlreadyHaveAccountText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LoginScreen()), (route) => false);
      },
      child: Center(
        child: Text(
          "لدي حساب بالفعل ؟  تسجيل الدخول ",
          style: GoogleFonts.almarai(
              color: PRIMARY,
              fontSize: 9.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
