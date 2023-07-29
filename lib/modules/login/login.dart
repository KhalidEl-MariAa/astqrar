import 'dart:developer';

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

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var passwordController = TextEditingController();
  var nationalIdController = TextEditingController();
  var loginkey = GlobalKey<FormState>();

  @override
  void initState() 
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (BuildContext context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) {
            if (state is ShopLoginSuccessAndActiveState) 
            {
              log("IS_DEVELOPMENT_MODE: ${IS_DEVELOPMENT_MODE}, kReleaseMode: ${kReleaseMode}");

              showToast(
                  msg: "تم تسجيل الدخول بنجاح", state: ToastStates.SUCCESS);

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LayoutScreen()),
                  (route) => false);

            } else if (state is ShopLoginSuccessButInActiveState) 
            {
              showToast(
                  msg: "تم تسجيل الدخول بنجاح ، الرجاء الاشتراك لتفعيل الحساب", state: ToastStates.WARNING);

                // عميل مسجل لكن غير مشترك
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotSubscribedScreen()),
                    (route) => true);

            } else if (state is ShopLoginErrorState) {
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
                          controller: nationalIdController,
                          type: TextInputType.number,
                          validate: (value) {
                            return (value!.isEmpty)
                                ? "من فضلك ادخل رقم الهوية"
                                : null;
                          },
                          labelText: "رقم الهوية",
                          label: "الرجاء ادخال رقم الهوية",
                          prefixIcon: Icons.email_outlined),
                      
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
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          borderColor: Colors.white10,
                          labelText: "كلمة المرور",
                          label: "الرجاء ادخال كلمة المرور",
                          suffixPressed: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          prefixIcon: Icons.lock_outline_rounded,
                          suffix: ShopLoginCubit.get(context).suffix,
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
                        condition: state is! ShopLoginLoadingState,
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        builder: (context) => doubleInfinityMaterialButton(
                            text: "تسجيل دخول",
                            onPressed: () {
                              if (loginkey.currentState!.validate()) {
                                ShopLoginCubit.get(context).UserLogin(
                                    nationalId: nationalIdController.text,
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
