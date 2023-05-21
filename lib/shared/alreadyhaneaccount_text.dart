import 'package:astarar/modules/login/login.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
          style: TextStyle(
              color: primary,
              fontSize: 9.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
