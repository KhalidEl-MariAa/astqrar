import 'package:astarar/modules/contact_us/contact_us.dart';
import 'package:astarar/modules/linkperson/layout_linkPerson/layout_link_person.dart';
import 'package:astarar/modules/login/cubit/cubit.dart';
import 'package:astarar/modules/login/cubit/states.dart';
import 'package:astarar/modules/login/widgets/forget_password+text.dart';
import 'package:astarar/modules/main%20screen/main_screen.dart';
import 'package:astarar/modules/register_user/user_register.dart';
import 'package:astarar/notifications/cubit/cubit.dart';
import 'package:astarar/shared/components/components.dart';
import 'package:astarar/shared/components/header_logo.dart';
import 'package:astarar/shared/network/local.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../layout/layout.dart';
import '../../shared/contants/contants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          listener: (context, state) {
            if (state is ShopLoginSuccessState) {

              if(state.loginModel.key==0){
                showToast(msg: state.loginModel.msg!, state: ToastStates.ERROR);
              }
              if (state.loginModel.key==1) {
                if(state.loginModel.data!.status!){
                showToast(
                    msg: "تم تسجيل الدخول بنجاح", state: ToastStates.SUCCESS);
               if(typeOfUser==1) Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
               if(typeOfUser==2) Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LayoutLinkPerson()), (route) => false);
                NotificationCubit.get(context).getNotifications();
              }
                if(state.loginModel.data!.status==false&&state.loginModel.data!.typeUser==1) {
                showToast(msg: state.loginModel.msg!, state: ToastStates.ERROR);
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const MainScreen()), (route) => false);
              }
                if(state.loginModel.data!.status==false&&state.loginModel.data!.typeUser==2) {
                  showToast(msg: state.loginModel.msg!, state: ToastStates.ERROR);
                }
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

                      const  ForgetPassword(),
                      SizedBox( height: 1.5.h, ),

                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        builder: (context) => doubleInfinityMaterialButton(
                            text: "تسجيل دخول",
                            onPressed: () {
                              /* navigateTo(context: context, widget: MainScreen());*/
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
                              "الدخول كزائر113333r111",
                              style: TextStyle(
                                  color: white,
                                  fontSize: 9.2.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox( height: 3.2.h, ),
                      InkWell(
                        onTap: () {
                          navigateTo(context: context, widget: UserRegister(
                            delegateId: null,
                          ));
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
                      
                      SizedBox( height: 0.5.h,),
                      // Center(
                      //   child: InkWell(
                      //     onTap: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => RegisterLinkPerson()));
                      //     },
                      //     child: Container(
                      //       margin: const EdgeInsets.symmetric(vertical: 0),
                      //       child: Text(
                      //         "تسجيل الخطابات",
                      //         style: TextStyle(
                      //             color: white,
                      //             fontSize: 9.sp,
                      //             fontWeight: FontWeight.w500),
                      //       ),
                      //     ),
                      //   ),
                      // ),
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
