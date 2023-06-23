import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../constants.dart';
import '../../shared/components/components.dart';
import '../../shared/components/header_logo.dart';
import '../../shared/styles/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'resetpassword.dart';

class ForgetPasswordScreen extends StatelessWidget 
{
  final nationalIdController = TextEditingController();
  final phoneController  = TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ForgetPasswordCubit(),
      child: 
        BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
          listener: (context, state) 
          {
            if (state is ForgetPasswordSuccessState) 
            {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResetPassword(code: "0",)  //InputOtp(code: state.forgetPasswordModel.data!.code.toString()
                  ),
                  (route) => true
                );
                showToast(msg: "تم التحقق من الهوية بنجاح", state: ToastStates.SUCCESS);
            }else if (state is ForgetPasswordErrorState) {
              showToast(msg: state.error, state: ToastStates.ERROR);
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
                    Text( "طلب استعادة كلمة المرور",
                      style: TextStyle(color: primary, fontSize: 15.sp),
                    ),
                    SizedBox( height: 4.5.h, ),                    
                    
                    /** حسب طلب صاحب المشروع
                     * يتم استعادة كلمة المرور من خلال محادثة الواتساب
                     * والان في التعديل الجديد يريده حسب رقم الهوية ورقم الجوال
                     **/
                    defaultTextFormField(
                      context: context,
                      controller: nationalIdController,
                      type: TextInputType.number,
                      validate: (String? val) { 
                        return (val!.isEmpty)?"من فضلك ادخل الهوية": null;
                      },
                      labelText: "رقم الهوية",
                      label: "الرجاء ادخال رقم الهوية",
                      prefixIcon: Icons.person
                    ),
                    SizedBox(height: 1.h,),
                    
                    defaultTextFormField(
                      context: context,
                      controller: phoneController,
                      type: TextInputType.number,
                      validate: (String? val) { 
                        return (val!.isEmpty)?"من فضلك ادخل رقم الجوال": null;
                      },
                      labelText: "رقم الجوال",
                      label: "الرجاء ادخال رقم الجوال",
                      prefixIcon: Icons.phone_android_rounded
                    ),

                    SizedBox(height: 2.h,),

                    doubleInfinityMaterialButton(
                        text: "التحقق من الهوية",
                        onPressed: () {
                          ForgetPasswordCubit.get(context).sendUserIdentity(
                            nationalId: nationalIdController.text,
                            phone: phoneController.text
                          );
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>InputOtp()));
                        }),

                    SizedBox(height: 1.h, ),
                    ConditionalBuilder(
                      condition: state is ForgetPasswordLoadingState,
                      builder: (context) => CircularProgressIndicator(),
                      fallback: (context) => Text(""),                      
                    ),

                    SizedBox(height: 4.h, ),
                    doubleInfinityMaterialButton(                      
                      text: "مراسلة الادمن لاستعادة كلمة السر ",
                      onPressed: () async {
                        final link = WhatsAppUnilink(
                          phoneNumber: mobilePhone,
                          text: "مرحبا \n اريد استعادة كلمة المرور ",
                        );
                  
                        if (await launchUrl(link.asUri(), mode: LaunchMode.platformDefault)) {} 
                        else { throw 'Could not launch ${link.asUri()}'; }
                      }
                    ),

                  
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
