import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../shared/components/components.dart';
import '../home/4_more/more_tab.dart';
import '../home/layout/layout.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ChangePassword extends StatelessWidget 
{
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ChangePasswordCubit(),
      child: BlocConsumer<ChangePasswordCubit,ChangePasswordStates>(
        listener: (context,state){
          if(state is ChangePasswordSuccessState){
            if(state.changePasswordModel.key==1){
              MoreTab.passwordController.clear();
              MoreTab.confirmPasswordController.clear();
              MoreTab.oldPasswordController.clear();
              showToast(msg: state.changePasswordModel.msg!, state: ToastStates.SUCCESS);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LayoutScreen()), (route) => false);
            }
            else{
              showToast(msg: state.changePasswordModel.msg!, state: ToastStates.ERROR);
            }
          }
        },
        builder:(context,state)=> Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
            child: Padding(
              padding:
                   EdgeInsetsDirectional.only(start: 4.w, top: 1.h, end: 4.w),
              child: SingleChildScrollView(
                child: Form(
                  key: MoreTab.form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "تغيير كلمة المرور",
                        style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.black),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "كلمة المرور القديمة",
                        style: GoogleFonts.poppins(fontSize: 10.sp, color: Colors.black),
                      ),
                      defaultTextFormField(
                          container: Colors.grey[100],
                          context: context,
                          styleText: Colors.black,
                          controller: MoreTab.oldPasswordController,
                          type: TextInputType.text,
                          validate: (String? value) {
                            return (value!.isEmpty)? "من فضلك ادخل كلمة المرور القديمة": null;
                          },
                          label: "الرجاء ادخل كلمة المرور"),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "كلمة المرور الجديدة",
                        style: GoogleFonts.poppins(fontSize: 10.sp, color: Colors.black),
                      ),
                      defaultTextFormField(
                          container: Colors.grey[100],
                          context: context,
                          styleText: Colors.black,
                          controller: MoreTab.passwordController,
                          type: TextInputType.text,
                          validate: (String? value) {
                            return (value!.isEmpty)? "من فضلك ادخل كلمة المرور الجديدة": null;
                          },
                          label: "الرجاء ادخل كلمة المرور"),
                      SizedBox(
                        height:2.h,
                      ),
                      Text(
                        "تاكيد كلمة المرور",
                        style: GoogleFonts.poppins(fontSize: 10.sp, color: Colors.black),
                      ),
                      defaultTextFormField(
                          container: Colors.grey[100],
                          context: context,
                          styleText: Colors.black,
                          controller: MoreTab.confirmPasswordController,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if(value!.isEmpty){
                              return "من فضلك قم بتاكيد كلمة المرور";
                            }else if(MoreTab.passwordController.text !=MoreTab.confirmPasswordController.text){
                              return " كلمة المرور الجديدة و تاكيد كلمة المرور غير متشابهان";
                            }else{
                              return null;
                            }
                          },
                          label: "الرجاء ادخل كلمة المرور"),
                      SizedBox(
                        height: 2.h,
                      ),
                      doubleInfinityMaterialButton(onPressed: () {
                        if(MoreTab.form.currentState!.validate()){
                         ChangePasswordCubit.get(context).changePassword(oldPassword:MoreTab.oldPasswordController.text,
                             newPassword: MoreTab.passwordController.text);
                        }
                      }, text: "تاكيد"),
                      SizedBox(height: 1.h,),
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
