import 'package:astarar/modules/forgetpassword/cubit/cubit.dart';
import 'package:astarar/modules/forgetpassword/cubit/states.dart';
import 'package:astarar/modules/forgetpassword/inputOtp.dart';
import 'package:astarar/shared/components/components.dart';
import 'package:astarar/shared/components/header_logo.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class ForgetPasswordScreen extends StatelessWidget 
{
  final nationalIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ForgetPasswordCubit(),
      child: 
        BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
          listener: (context, state) 
          {
            if (state is ForgetPasswordSuccessState) {
              if (state.forgetPasswordModel.key == 1) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InputOtp(code: state.forgetPasswordModel.data!.code.toString(),)
                    ),
                    (route) => false
                );
              }
            }
          },

        builder: (context, state) => Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: backGround,
            body: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.3.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 3.h, ),
                    const  HeaderLogo(),
                    Text(
                      "استعادة كلمة المرور",
                      style: TextStyle(color: primary, fontSize: 10.sp),
                    ),
                    SizedBox( height: 6.5.h, ),
                    doubleInfinityMaterialButton(                      
                        text: "مراسلة الادمن لاستعادة كلمة السر ",
                        onPressed: () async{
                          final link = WhatsAppUnilink(
                            phoneNumber: mobilePhone,
                            text: "مرحبا \n اريد استعادة كلمة المرور ",
                          );

                          // Convert the WhatsAppUnilink instance to a Uri.
                          // The "launch" method is part of "url_launcher".
                          await launch('$link', forceWebView: false);
                          
                          // this is non-deprecated form, but i coudn't make it work.
                          // LaunchMode mode = LaunchMode.platformDefault;
                          // await launchUrl(link.asUri(), mode: mode);
                      }
                    ),
                    
                    /** حسب طلب صاحب المشروع
                     * يتم استعادة كلمة المرور من خلال محادثة الواتساب
                     **/
                    // defaultTextFormField(
                    //     context: context,
                    //     controller: nationalIdController,
                    //     type: TextInputType.number,
                    //     validate: (String? value) {},
                    //     labelText: "رقم الهوية",
                    //     label: "الرجاء ادخال رقم الهوية",
                    //     prefixIcon: Icons.phone_android_rounded),
                    
                    // SizedBox(height: 9.h,),
                    
                    // doubleInfinityMaterialButton(
                    //     text: "تاكيد",
                    //     onPressed: () {
                    //       ForgetPasswordCubit.get(context).sendCode(nationalId: nationalIdController.text);
                    //       // Navigator.push(context, MaterialPageRoute(builder: (context)=>InputOtp()));
                    //     }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
