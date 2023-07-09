import 'package:google_fonts/google_fonts.dart';

import '../../models/forget_password.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

import '../../shared/components/components.dart';
import '../../shared/components/header_logo.dart';
import '../../shared/styles/colors.dart';
import 'resetpassword.dart';

class InputOtp extends StatelessWidget 
{
  final ActivationCode activationCode;

  InputOtp({required this.activationCode});

  @override
  Widget build(BuildContext context) 
  {
    var smscontroller = TextEditingController();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: BG_DARK_COLOR,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 3.h,
                ),
                const HeaderLogo(),
                Text(
                  "استعادة كلمة المرور",
                  style: GoogleFonts.almarai(color: PRIMARY, fontSize: 10.sp),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 28),
                      child: Text("كود التحقيق",
                          style: TextStyle(
                              color: WHITE, fontWeight: FontWeight.w400)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Pinput(
                  length: 4,
                  controller: smscontroller,
                  enabled: true,
                  showCursor: true,
                  defaultPinTheme: PinTheme(
                      width: 15.w,
                      height: 7.h,
                      textStyle: TextStyle(
                          fontSize: 13.sp,
                          color: PRIMARY,
                          fontWeight: FontWeight.w300),
                      decoration: BoxDecoration(
                        color: BG_DARK_COLOR,
                        border: Border.all(color: PRIMARY),
                        borderRadius: BorderRadius.circular(10),
                      )),
                  cursor: Container(
                    color: PRIMARY,
                    width: 6.w,
                    height: 0.2.h,
                  ),
                  pinAnimationType: PinAnimationType.slide,
                  onCompleted: (String? value) {},
                ),
                SizedBox(
                  height: 8.h,
                ),
                doubleInfinityMaterialButton(
                    text: "تاكيد",
                    onPressed: () {
                      if (smscontroller.text == this.activationCode.code) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResetPassword(
                                      activationCode: this.activationCode,
                                    )));
                      } else {
                        showToast(
                            msg: "من فضلك ادخل الكود الصحيح",
                            state: ToastStates.ERROR);
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
