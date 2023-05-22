import 'package:astarar/layout/layout.dart';
import 'package:astarar/modules/contact_us/cubit/cubit.dart';
import 'package:astarar/modules/contact_us/cubit/states.dart';
import 'package:astarar/modules/login/login.dart';
import 'package:astarar/shared/components/components.dart';
import 'package:astarar/shared/components/logo/normal_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ContactUS extends StatelessWidget 
{
  final bool isFromLogin;  
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final messageController = TextEditingController();

  ContactUS({required this.isFromLogin});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ContactUsCubit(),
      child: BlocConsumer<ContactUsCubit,ContactUsStates>(
        listener: (context, state) {
          if(state is ContactUsSuccessState){
        //    if(state.contactisModel.key==1){
              showToast(msg: state.contactisModel.msg!, state: ToastStates.SUCCESS);
              if(isFromLogin){              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
              }
              else{
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
          //  }
          }}
        },
        builder:(context,state)=> Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(11.h),
              child: NormalLogo(appbarTitle: "اتصل بنا",isBack: true,)
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal:3.w,vertical: 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 2.5.h,
                      ),
                      Text(
                        "رقم الجوال",
                        style: GoogleFonts.poppins(fontSize: 11.sp, color: Colors.black),
                      ),
                      defaultTextFormField(
                          container: Colors.grey[100],
                          context: context,
                          styleText: Colors.black,
                          controller: phoneController,
                          type: TextInputType.text,
                          validate: (String? value) {
                            return (value!.isEmpty)?"من فضلك ادخل رقم الجوال": null;
                          },
                          label: "الرجاء ادخل رقم الجوال"),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      Text(
                        "الاسم",
                        style: GoogleFonts.poppins(fontSize: 11.sp, color: Colors.black),
                      ),
                      defaultTextFormField(
                          container: Colors.grey[100],
                          context: context,
                          styleText: Colors.black,
                          controller: nameController,
                          type: TextInputType.text,
                          validate: (String? value) {
                            return (value!.isEmpty)? "من فضلك ادخل الاسم": null;
                          },
                          label: "الرجاء ادخل الاسم"),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      Text(
                        "الرسالة",
                        style: GoogleFonts.poppins(fontSize: 11.sp, color: Colors.black),
                      ),
                      defaultTextFormField(
                          container: Colors.grey[100],
                          context: context,
                          styleText: Colors.black,
                          controller: messageController,
                          type: TextInputType.multiline,
                          validate: (String? value) {
                            return (value!.isEmpty)? "من فضلك قم بتاكيد الرسالة": null;
                          },
                          label: "الرجاء ادخل الرسالة"),
                      SizedBox(
                        height: 3.5.h,
                      ),
                      doubleInfinityMaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {

                              ContactUsCubit.get(context).sendContact(message: messageController.text,
                                  userName: nameController.text,
                                  phone: phoneController.text);
                            }
                          },
                          text: "ارسال"),
                      SizedBox(
                        height: 1.5.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
