import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../contact_us/contact_us.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'not_subscribed_screen.dart';
import '../register_user/user_register.dart';
import '../../notifications/cubit/cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/components/header_logo.dart';
import '../../shared/network/local.dart';
import '../../shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../layout/layout.dart';
import '../../shared/contants/contants.dart';
import '../../shared/network/remote.dart';
import '../forgetpassword/forgetpassword.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> 
{
  // const LoginScreen({Key? key}) : super(key: key);
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var loginkey=GlobalKey<FormState>();

  @override
  void initState() 
  {
    super.initState();
    FirebaseMessaging.instance.getToken().then((value) {
      deviceToken = value;
      CacheHelper.sharedpreferneces.setString("deviceToken", deviceToken!);
      print("Device Token" + "  " + value.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (BuildContext context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) 
          {
            if (state is ShopLoginSuccessState) {

              if(state.loginModel.key==0){
                showToast(msg: state.loginModel.msg!, state: ToastStates.ERROR);
              }
              if (state.loginModel.key==1) 
              {
                log("IS_DEVELOPMENT_MODE: ${IS_DEVELOPMENT_MODE}, kReleaseMode: ${kReleaseMode}");
                if(state.loginModel.data!.status! || IS_DEVELOPMENT_MODE)
                {
                  showToast( 
                    msg: "تم تسجيل الدخول بنجاح", 
                    state: ToastStates.SUCCESS);

                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
                  // if(typeOfUser==1) Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
                  // if(typeOfUser==2) Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LayoutLinkPerson()), (route) => false);
                  NotificationCubit.get(context).getNotifications();

                }
                
                if( state.loginModel.data!.status == false && kReleaseMode ) 
                {
                  // عميل مسجل لكن غير مشترك
                  showToast(msg: state.loginModel.msg!, state: ToastStates.ERROR);
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NotSubscribedScreen()), (route) => false);
                }

                
                // if(state.loginModel.data!.status == false && state.loginModel.data!.typeUser==1) {
                //   showToast(msg: state.loginModel.msg!, state: ToastStates.ERROR);
                //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const NotSubscribedScreen()), (route) => false);
                // }
                // if(state.loginModel.data!.status==false&&state.loginModel.data!.typeUser==2) {
                //     showToast(msg: state.loginModel.msg!, state: ToastStates.ERROR);
                // }
              }
            }
          },
          
          builder: (context, state) => Scaffold(
            backgroundColor: backGround,
            body: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: SingleChildScrollView(
                child: Form(
                  key: loginkey,
                  child: Column(
                    children: [
                      SizedBox( height: 4.5.h, ),
                      const HeaderLogo(),
                      SizedBox( height: 7.h, ),

                      defaultTextFormField(
                          context: context,
                          borderColor: Colors.white10,
                          labelTextcolor: Colors.white54,
                          controller: phoneController,
                          type: TextInputType.number,
                          validate: (value) {
                            return (value!.isEmpty)? "من فضلك ادخل رقم الهوية": null;
                          },
                          labelText: "رقم الهوية",
                          label: "الرجاء ادخال رقم الهوية",
                          prefixIcon: Icons.email_outlined),

                      SizedBox( height: 3.5.h, ),

                      defaultTextFormField(
                          context: context,
                          controller: passwordController,
                          type: TextInputType.text,
                          validate: (String? value) {
                            return (value!.isEmpty)? "من فضلك ادخل كلمة السر": null;
                          },
                          isPassword:
                          ShopLoginCubit
                              .get(context)
                              .isPassword,
                          borderColor: Colors.white10,
                          labelText: "كلمة المرور",
                          label: "الرجاء ادخال كلمة المرور",
                          suffixPressed: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          prefixIcon: Icons.lock_outline_rounded,
                          suffix: ShopLoginCubit
                              .get(context)
                              .suffix,
                          labelTextcolor: Colors.white54),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPasswordScreen()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("هل نسيت كلمة المرور؟",
                                style: TextStyle(
                                    color: grey,
                                    fontSize: 7.8.sp,
                                    // decoration: decoration??TextDecoration.none,
                                    //fontWeight: fontWeight??(WidgetUtils.lang=="ar"?FontWeight.w500:FontWeight.w200),
                                    //fontFamily: fontFamily?? (WidgetUtils.lang=="ar"? GoogleFonts.cairo().fontFamily : GoogleFonts.almarai().fontFamily)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox( height: 1.5.h, ),

                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        builder: (context) => doubleInfinityMaterialButton(
                            text: "تسجيل دخول",
                            onPressed: () {
                              if(loginkey.currentState!.validate()) 
                              {
                                ShopLoginCubit.get(context).UserLogin(
                                    nationalId: phoneController.text,
                                    password: passwordController.text);
                              }
                            }),
                      ),

                      Center(
                        child: InkWell(
                          onTap: () {
                            CacheHelper.saveData( key: "isLogin", value: false);
                            isLogin = CacheHelper.getData(key: "isLogin");
                            print(isLogin);
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                          },
                          child: Container(
                            margin:  EdgeInsets.symmetric(vertical: 2.2.h),
                            child: Text(
                              "الدخول كزائر",
                              style: TextStyle(
                                  color: white,
                                  fontSize: 9.2.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),

                      if(IS_DEVELOPMENT_MODE)
                        Center( 
                          child: Text(DioHelper.baseUrl,
                                style: TextStyle(
                                    color: white,
                                    fontSize: 9.2.sp,
                                    fontWeight: FontWeight.w500)
                          ),
                        ),
                      
                      
                      SizedBox( height: 3.2.h, ),
                      InkWell(
                        onTap: () {
                          navigateTo(context: context, widget: UserRegister() );
                        },
                        child: Center(
                          child: Text("ليس لديك حساب ؟ اضغط هنا",
                            style: TextStyle(
                                color: primary,
                                fontSize: 9.2.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      
                      SizedBox( height: 3.h, ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "للاستفسارات و الشكاوي",
                            style: TextStyle(
                                color: white,
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox( width: 1.5.w, ),

                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUS(
                                isFromLogin: true,
                              )));
                            },
                            child: Text("تواصل معنا",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: primary,
                                  fontSize: 9.2.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                      SizedBox( height: 2.h, )
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
