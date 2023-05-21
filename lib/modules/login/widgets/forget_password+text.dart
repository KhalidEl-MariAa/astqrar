import 'package:astarar/modules/forgetpassword/forgetpassword.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPasswordScreen()));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
        "هل نسيت كلمة المرور؟",
              style: TextStyle(
                  color: grey,
                  fontSize: 7.8.sp,
                 // decoration: decoration??TextDecoration.none,
                  //fontWeight: fontWeight??(WidgetUtils.lang=="ar"?FontWeight.w500:FontWeight.w200),
                  //fontFamily: fontFamily?? (WidgetUtils.lang=="ar"? GoogleFonts.cairo().fontFamily : GoogleFonts.almarai().fontFamily)
              ),
            ),

          ],
        ),
      ),
    );
  }
}
