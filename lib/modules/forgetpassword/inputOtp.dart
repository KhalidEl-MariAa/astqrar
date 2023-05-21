
import 'package:astarar/modules/forgetpassword/resetpassword.dart';
import 'package:astarar/shared/components/components.dart';
import 'package:astarar/shared/components/header_logo.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

class InputOtp extends StatelessWidget {
final String code;
InputOtp({required this.code});
  @override
  Widget build(BuildContext context) {
    var smscontroller = TextEditingController();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backGround,
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 3.h,),
               const HeaderLogo(),
                Text("استعادة كلمة المرور",style: TextStyle(color: primary,fontSize: 10.sp),),
                SizedBox(height: 7.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 28),
                      child: Text("كود التحقيق",style: TextStyle(color: white,fontWeight: FontWeight.w400)),
                    ),
                  ],
                ),
                SizedBox(height: 2.h,),
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
                          color: primary,
                          fontWeight: FontWeight.w300),
                      decoration: BoxDecoration(
                        color: backGround,
                        border: Border.all(color: primary),
                        borderRadius: BorderRadius.circular(10),
                      )),
                  cursor: Container(
                    color: primary,
                    width: 6.w,
                    height: 0.2.h,
                  ),
                  pinAnimationType: PinAnimationType.slide,
                  onCompleted: (String? value) {},
                ),
                SizedBox(height: 8.h,),
                doubleInfinityMaterialButton(text: "تاكيد", onPressed:(){
                  if(smscontroller.text==code){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassword(code: code,)));}
                  else{
                    showToast(msg: "من فضلك ادخل الكود الصحيح", state: ToastStates.ERROR);
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
