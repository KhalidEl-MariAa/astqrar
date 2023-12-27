import 'dart:developer';
import 'dart:io';

import '../home/6_profile/user_profile/user_profile.dart';
import '../splash/cubit/splash_cubit.dart';
import '../../shared/components/defaultTextFormField.dart';
import '../../shared/components/double_infinity_material_button.dart';
import '../../shared/network/remote.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';
import '../../shared/components/components.dart';
import '../../shared/components/header_logo.dart';
import '../../shared/network/local.dart';
import '../../shared/styles/colors.dart';
import '../forgetpassword/forgetpassword.dart';
import '../home/4_more/3_contact_us/contact_us.dart';
import '../home/layout/layout.dart';
import '../user_register/user_register.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'not_subscribed.dart';

class LoginScreen extends StatefulWidget 
{
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var passwordController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var loginkey = GlobalKey<FormState>();

  @override
  void initState() 
  {
    super.initState();

    //SplashCubit.Firebase_init( context );

  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) 
          {
            if (state is LoginSuccessAndActiveState) 
            {
              log("IS_DEVELOPMENT_MODE: ${IS_DEVELOPMENT_MODE}, kReleaseMode: ${kReleaseMode}");

              showToast(
                  msg: "تم تسجيل الدخول بنجاح", state: ToastStates.SUCCESS);

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LayoutScreen()),
                  (route) => false);

            }else if (state is LoginSuccessButProfileIsNotCompleted) {

              navigateTo(context: context, widget: UserProfileScreen( )  );

            } else if (state is LoginSuccessButInActiveState) 
            {
              showToast(
                  msg: "تم تسجيل الدخول بنجاح ، الرجاء الاشتراك لتفعيل الحساب", state: ToastStates.WARNING);

                // عميل مسجل لكن غير مشترك
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotSubscribedScreen()),
                    (route) => true);

            } else if (state is LoginErrorState) {
              showToast(msg: state.error, state: ToastStates.ERROR);
            }
          },
          builder: (context, state) => Scaffold(
            backgroundColor: BG_DARK_COLOR,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: SingleChildScrollView(
                child: Form(
                  key: loginkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4.5.h,
                      ),

                      const HeaderLogo(),
                      
                      SizedBox(
                        height: 3.h,
                      ),
                      defaultTextFormField(
                          context: context,
                          borderColor: Colors.white10,
                          labelTextcolor: Colors.white54,
                          controller: phoneNumberController,
                          type: TextInputType.number,
                          validate: (value) {
                            return (value!.isEmpty)
                                ? "من فضلك ادخل رقم الجوال"
                                : null;
                          },
                          labelText: "رقم الجوال",
                          label: "الرجاء ادخال رقم الجوال",
                          prefixIcon: Icons.phone_android_rounded
                      ),
                      
                      SizedBox(height: 2.h,),
                      
                      defaultTextFormField(
                          context: context,
                          controller: passwordController,
                          type: TextInputType.text,
                          validate: (String? value) {
                            return (value!.isEmpty)
                                ? "من فضلك ادخل كلمة السر"
                                : null;
                            },
                          isPassword: LoginCubit.get(context).isPassword,
                          borderColor: Colors.white10,
                          labelText: "كلمة المرور",
                          label: "الرجاء ادخال كلمة المرور",
                          suffixPressed: () {
                            LoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          prefixIcon: Icons.lock_outline_rounded,
                          suffix: LoginCubit.get(context).suffix,
                          labelTextcolor: Colors.white54),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "هل نسيت كلمة المرور؟",
                                style: GoogleFonts.almarai(
                                  color: GREY,
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.bold
                                ),
                              
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgetPasswordScreen()));
                          },
                        ),
                      ),
                      
                      SizedBox(height: 2.5.h,),
                      
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        builder: (context) => doubleInfinityMaterialButton(
                            text: "تسجيل دخول",
                            onPressed: () {
                              if (loginkey.currentState!.validate()) {
                                LoginCubit.get(context).UserLogin(
                                    phoneNumber: phoneNumberController.text,
                                    password: passwordController.text);
                              }
                            }),
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            CacheHelper.saveData(key: "isLogin", value: false);
                            IS_LOGIN = CacheHelper.getData(key: "isLogin");
                            print(IS_LOGIN);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LayoutScreen()));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 2.2.h),
                            child: Text(
                              "الدخول كزائر" + "",
                              style: GoogleFonts.almarai(
                                color: WHITE,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (BASE_URL == "غير متصل بالسيرفر")
                        Center(
                          child: Text(BASE_URL,
                              style: GoogleFonts.almarai(
                                  color: Colors.yellow,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w900)),
                        ),
                        
                      if (IS_DEVELOPMENT_MODE)
                        Center(
                          child: Text(BASE_URL,
                              style: TextStyle(
                                  color: WHITE,
                                  fontSize: 9.2.sp,
                                  fontWeight: FontWeight.w500)),
                        ),
                      if (IS_DEVELOPMENT_MODE)
                        Center(
                          child: Text(
                              "IS_DEVELOPMENT_MODE: ${IS_DEVELOPMENT_MODE}, kReleaseMode: ${kReleaseMode}",
                              style: TextStyle(
                                  color: WHITE,
                                  fontSize: 9.2.sp,
                                  fontWeight: FontWeight.w500)),
                        ),

                      if (IS_DEVELOPMENT_MODE)
                        InkWell(
                          onTap: () { DioHelper.init(); },
                          child: Text("RECONNECT", style: TextStyle(color: WHITE),),
                        ),
                        
                      SizedBox(
                        height: 3.2.h,
                      ),
                      InkWell(
                        onTap: () {
                          navigateTo(context: context, widget: UserRegister());
                        },
                        child: Center(
                          child: Text(
                            "ليس لديك حساب ؟ اضغط هنا",
                            style: GoogleFonts.almarai(
                            color: WHITE,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600, ),
                          ),
                        ),
                      ),

                      SizedBox(height: 4.h,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "للاستفسارات و الشكاوي",
                            style:  GoogleFonts.almarai(
                            color: OFF_WHITE,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600, ),
                          ),
                          SizedBox(
                            width: 1.5.w,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ContactUS(
                                            isFromLogin: true,
                                          )));
                            },
                            child: Text(
                              "تواصل معنا",
                              style: GoogleFonts.almarai(
                                      color: PRIMARY,
                                      fontSize: 9.sp,
                                      fontWeight: FontWeight.w600, ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 5.h,),

                      Text(
                          "موثق من:" + "",
                          style: GoogleFonts.almarai(
                            color: WHITE,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600, ),
                      ),


                      Image(
                        image: AssetImage("assets/sbc-gold.png"),
                        height: 5.h,
                        width: 85.w,

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
