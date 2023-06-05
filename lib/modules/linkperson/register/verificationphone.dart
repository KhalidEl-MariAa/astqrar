
import 'package:astarar/shared/components/components.dart';
import 'package:astarar/shared/components/header_logo.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class VerificationPhone extends StatelessWidget {
  const VerificationPhone({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var smscontroller = TextEditingController();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backGround,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30,),
                HeaderLogo(),
                Text("تفعيل الحساب",style: TextStyle(color: primary,fontSize: 12),),
                SizedBox(height: 60,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 28),
                      child: Text("كود التفعيل",
                      style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.w400)
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Pinput(
                  length: 4,
                  controller: smscontroller,
                  enabled: true,
                  showCursor: true,
                  defaultPinTheme: PinTheme(
                      width: 56,
                      height: 56,
                      textStyle: TextStyle(
                          fontSize: 20,
                          color: primary,
                          fontWeight: FontWeight.w300),
                      decoration: BoxDecoration(
                        color: backGround,
                        border: Border.all(color: primary),
                        borderRadius: BorderRadius.circular(10),
                      )),
                  cursor: Container(
                    color: primary,
                    width: 30,
                    height: 1,
                  ),
                  pinAnimationType: PinAnimationType.slide,
                  onCompleted: (String? value) {},
                ),
                SizedBox(height: 80,),
                doubleInfinityMaterialButton(text: "تاكيد", onPressed:(){
                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassword()));
                }),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
