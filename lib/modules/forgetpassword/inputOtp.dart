import 'package:astarar/shared/components/double_infinity_material_button.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/activation_code.dart';
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

  InputOtp( this.activationCode );

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
                  style: GoogleFonts.almarai(color: PRIMARY, fontSize: 15.sp),
                ),
                SizedBox( height: 7.h,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 28),
                      child: Text("كود التحقيق",
                          style: GoogleFonts.almarai(
                            color: WHITE, fontWeight: FontWeight.w400, fontSize: 10.sp),
                      )
                    ),
                  ],
                ),
                
                SizedBox(height: 2.h,),

                Directionality(
                  textDirection: TextDirection.ltr, 
                  child:                 
                  Pinput(
                    length: 4,
                    controller: smscontroller,
                    enabled: true,
                    showCursor: true,         
                    defaultPinTheme: PinTheme(                      
                        width: 15.w,
                        height: 7.h,
                        textStyle: GoogleFonts.almarai(
                          color: PRIMARY, 
                          fontWeight: FontWeight.w800,
                          fontSize: 20.sp
                        ),
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
                ),
                
                SizedBox(height: 4.h,),
                
                doubleInfinityMaterialButton(
                    text: "تاكيد",
                    onPressed: () {
                      if (smscontroller.text == this.activationCode.code.toString() ) 
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResetPassword(
                                    activationCode: this.activationCode,
                                  ))
                        );
                      }else{
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
