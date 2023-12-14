import '../../shared/components/defaultTextFormField.dart';
import '../../shared/components/double_infinity_material_button.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/activation_code.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../shared/components/components.dart';
import '../../shared/components/header_logo.dart';
import '../../shared/styles/colors.dart';
import '../login/login.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ResetPassword extends StatelessWidget 
{
  final ActivationCode activationCode;

  ResetPassword({required this.activationCode});

  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var confirmpasswordController = TextEditingController();
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
        listener: (context, state) 
        {
          if (state is ChangePasswordByCodeSuccessState) 
          {
            showToast(
                msg: "تم تغيير كلمة السر بنجاح",
                state: ToastStates.SUCCESS);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false);
          }else if (state is ChangePasswordByCodeErrorState) {
              showToast(
                  msg: state.error,
                  state: ToastStates.ERROR);
          }
        },
        builder: (context, state) => Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: BG_DARK_COLOR,
            body: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                   SizedBox(height: 3.h,),
                   const  HeaderLogo(),
                    Text("تغيير كلمة المرور",
                      style: GoogleFonts.almarai(color: PRIMARY, fontSize: 15.sp),
                    ),
                    SizedBox( height: 7.h,),
                    defaultTextFormField(
                        context: context,
                        controller: passwordController,
                        container: WHITE,
                        styleText: Colors.black,
                        type: TextInputType.number,
                        validate: (String? value) { return ''; },
                        label: "الرجاء ادخال كلمة المرور الجديدة",
                        prefixIcon: Icons.lock_outline_rounded,
                        suffix: Icons.visibility_outlined),
                    
                    SizedBox( height: 1.5.h,),
                    
                    defaultTextFormField(
                        context: context,
                        controller: confirmpasswordController,
                        container: WHITE,
                        type: TextInputType.number,
                        styleText: Colors.black,
                        validate: (String? value) { return ''; },
                        label: "تاكيد كلمة المرور الجديدة",
                        prefixIcon: Icons.lock_outline_rounded,
                        suffix: Icons.visibility_outlined),

                    SizedBox(height: 3.h, ),

                    doubleInfinityMaterialButton(                        
                        text: "تغيير كلمة المرور",
                        onPressed: () {
                          ForgetPasswordCubit.get(context).changePasswordByCode(
                              userId: activationCode.userId!,
                              newPassword: passwordController.text, 
                              confirmPassword: confirmpasswordController.text,
                              code: activationCode.code?? 0 );
                        }),

                    SizedBox(height: 1.h, ),
                    ConditionalBuilder(
                      condition: state is ChangePasswordByCodeLoadingState,
                      fallback: (context) => Text("",),
                      builder: (context) => CircularProgressIndicator()
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
