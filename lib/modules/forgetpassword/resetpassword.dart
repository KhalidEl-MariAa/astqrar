import 'cubit/cubit.dart';
import 'cubit/states.dart';
import '../login/login.dart';
import '../../shared/components/components.dart';
import '../../shared/components/header_logo.dart';
import '../../shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ResetPassword extends StatelessWidget {
  final String code;

  ResetPassword({required this.code});

  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var confirmpasswordController = TextEditingController();
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
        listener: (context, state) {
          if (state is ChangePasswordByCodeSuccessState) {
            if (state.changePassswordByCodeModel == 3) {
              showToast(
                  msg: "تم تغيير كلمة السر بنجاح",
                  state: ToastStates.SUCCESS);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false);
            } else {
              showToast(
                  msg: " حدث خطا ما",
                  state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) => Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: backGround,
            body: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                   SizedBox(height: 3.h,),
                   const  HeaderLogo(),
                    Text("استعادة كلمة المرور",
                      style: TextStyle(color: primary, fontSize: 10.sp),
                    ),
                    SizedBox( height: 7.h,),
                    defaultTextFormField(
                        context: context,
                        controller: passwordController,
                        container: white,
                        styleText: Colors.black,
                        type: TextInputType.number,
                        validate: (String? value) { return ''; },
                        //    labelText: "رقم الجوال",
                        label: "الرجاء ادخال كلمة المرور",
                        prefixIcon: Icons.lock_outline_rounded,
                        suffix: Icons.visibility_outlined),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    defaultTextFormField(
                        context: context,
                        controller: confirmpasswordController,
                        container: white,
                        type: TextInputType.number,
                        styleText: Colors.black,
                        validate: (String? value) { return ''; },
                        //    labelText: "رقم الجوال",
                        label: "تاكيد كلمة المرور",
                        prefixIcon: Icons.lock_outline_rounded,
                        suffix: Icons.visibility_outlined),
                    SizedBox(
                      height: 9.h,
                    ),
                    doubleInfinityMaterialButton(
                        text: "تاكيد",
                        onPressed: () {
                          ForgetPasswordCubit.get(context).changePasswordByCode(
                              newPassword: passwordController.text, code: code);
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
