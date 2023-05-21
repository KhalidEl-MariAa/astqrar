import 'package:astarar/layout/layout.dart';
import 'package:astarar/modules/change_password/cubit/cubit.dart';
import 'package:astarar/modules/change_password/cubit/states.dart';
import 'package:astarar/modules/more/more_screen.dart';
import 'package:astarar/shared/components/components.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ChangePassword extends StatelessWidget {
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ChangePasswordCubit(),
      child: BlocConsumer<ChangePasswordCubit,ChangePasswordStates>(
        listener: (context,state){
          if(state is ChangePasswordSuccessState){
            if(state.changePasswordModel.key==1){
              MoreScreen.passwordController.clear();
              MoreScreen.confirmPasswordController.clear();
              MoreScreen.oldPasswordController.clear();
              showToast(msg: state.changePasswordModel.msg!, state: ToastStates.SUCCESS);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
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
                  key: MoreScreen.form,
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
                          controller: MoreScreen.oldPasswordController,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "من فضلك ادخل كلمة المرور القديمة";
                            }
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
                          controller: MoreScreen.passwordController,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "من فضلك ادخل كلمة المرور الجديدة";
                            }
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
                          controller: MoreScreen.confirmPasswordController,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if(value!.isEmpty){
                              return "من فضلك قم بتاكيد كلمة المرور";
                            }
                            if(MoreScreen.passwordController.text !=MoreScreen.confirmPasswordController.text){
                              return " كلمة المرور الجديدة و تاكيد كلمة المرور غير متشابهان";
                            }
                          },
                          label: "الرجاء ادخل كلمة المرور"),
                      SizedBox(
                        height: 2.h,
                      ),
                      doubleInfinityMaterialButton(onPressed: () {
                        if(MoreScreen.form.currentState!.validate()){
                         ChangePasswordCubit.get(context).changePassword(oldPassword:MoreScreen.oldPasswordController.text,
                             newPassword: MoreScreen.passwordController.text);
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
