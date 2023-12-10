import 'dart:developer';

import 'package:astarar/shared/components/defaultTextFormField.dart';
import 'package:astarar/shared/components/double_infinity_material_button.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import '../../shared/components/components.dart';
import '../../shared/components/header_logo.dart';
import '../../shared/styles/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'inputOtp.dart';


class ForgetPasswordScreen extends StatelessWidget {
  final nationalIdController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ForgetPasswordCubit(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
        listener: (context, state) {
          if (state is ForgetPasswordSuccessState) 
          {
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => ResetPassword(activationCode: state.activationCode)),
            //     (route) => true);
            
            showToast( msg: "تم ارسال كود التحقق اليك عن طريق الاشعارات" , state: ToastStates.SUCCESS);

            Navigator.push(context, MaterialPageRoute(builder: (context) => InputOtp( state.activationCode ) ));

          } else if (state is ForgetPasswordErrorState) {
            showToast(msg: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) => Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: BG_DARK_COLOR,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.3.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    const HeaderLogo(),
                    Text(
                      "طلب استعادة كلمة المرور",
                      style: GoogleFonts.almarai(color: PRIMARY, fontSize: 15.sp),
                    ),
                    
                    SizedBox(height: 4.5.h,),

                    /** حسب طلب صاحب المشروع
                     * يتم استعادة كلمة المرور من خلال محادثة الواتساب
                     * والان في التعديل الجديد يريده حسب رقم الهوية ورقم الجوال
                     **/
                    // defaultTextFormField(
                    //     context: context,
                    //     controller: nationalIdController,
                    //     type: TextInputType.number,
                    //     validate: (String? val) {
                    //       return (val!.isEmpty) ? "من فضلك ادخل الهوية" : null;
                    //     },
                    //     labelText: "رقم الهوية",
                    //     label: "الرجاء ادخال رقم الهوية",
                    //     prefixIcon: Icons.person),
                    // SizedBox(height: 1.h,),

                    defaultTextFormField(
                        context: context,
                        controller: phoneController,
                        type: TextInputType.number,
                        validate: (String? val) {
                          return (val!.isEmpty)
                              ? "من فضلك ادخل رقم الجوال"
                              : null;
                        },
                        labelText: "رقم الجوال",
                        label: "الرجاء ادخال رقم الجوال",
                        prefixIcon: Icons.phone_android_rounded),
                    
                    SizedBox(height: 2.h,),
                    
                    doubleInfinityMaterialButton(
                        text: "التحقق من الهوية",
                        onPressed: () {
                          ForgetPasswordCubit.get(context).sendUserIdentity(
                              nationalId: nationalIdController.text,
                              phone: phoneController.text);

                          
                        }),

                    SizedBox(height: 1.h, ),
                    
                    ConditionalBuilder(
                      condition: state is ForgetPasswordLoadingState,
                      builder: (context) => CircularProgressIndicator(),
                      fallback: (context) => Text(""),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    doubleInfinityMaterialButton(
                        text: "مراسلة الادمن لاستعادة كلمة السر ",
                        onPressed: () async {
                          // final link = WhatsAppUnilink(
                          //   phoneNumber: ADMIN_MOBILE_PHONE,
                          //   text: "مرحبا \n اريد استعادة كلمة المرور ",
                          // );

                          String text = "مرحبا \n اريد استعادة كلمة المرور ";
                          text = "hi there";
                          Uri uri = Uri(
                              scheme: "https", 
                              host: "wa.me",
                              path: "/${ADMIN_MOBILE_PHONE}",
                              query: "text=${text}");


                          log("ADMIN_MOBILE_PHONE : " + uri.toString());
                          String uristr = "https://wa.me/${ADMIN_MOBILE_PHONE}";
                          
                          
                          // if (await launchUrl(  Uri.parse(uristr)  )) {
                          if (await launch(  uristr  )) {
                            log("WHASTAPP DONE ");
                          } else {
                            showToast(
                              msg: '-------------------------------------- ${uri.toString()}',
                              state: ToastStates.ERROR);
                          }
                        }),
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
