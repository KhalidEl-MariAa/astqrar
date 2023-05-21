import 'package:astarar/modules/linkperson/register/cubit/cubit.dart';
import 'package:astarar/modules/linkperson/register/cubit/states.dart';
import 'package:astarar/modules/linkperson/register/verificationphone.dart';
import 'package:astarar/modules/login/login.dart';
import 'package:astarar/modules/register_user/user_register.dart';
import 'package:astarar/modules/terms/terms.dart';
import 'package:astarar/shared/alreadyhaneaccount_text.dart';
import 'package:astarar/shared/components/checkedbox_register.dart';
import 'package:astarar/shared/components/components.dart';
import 'package:astarar/shared/components/header_logo.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class RegisterLinkPerson extends StatefulWidget {
  const RegisterLinkPerson({Key? key}) : super(key: key);

  @override
  _RegisterLinkPersonState createState() => _RegisterLinkPersonState();
}

class _RegisterLinkPersonState extends State<RegisterLinkPerson> {
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var personalCardController = TextEditingController();
  var cityController = TextEditingController();
  var nationalityController = TextEditingController();
  var ageController = TextEditingController();
  var experienceController = TextEditingController();
  var resonController = TextEditingController();
  var moneyController = TextEditingController();
  var passwordController = TextEditingController();
  bool isSelected = false;
  bool termsSelected=false;
  var snakbar = GlobalKey<ScaffoldState>();
var formkey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterLinkPersonCubit(),
      child: BlocConsumer<RegisterLinkPersonCubit, RegisterLinkPersonStates>(
        listener: (context, state) {
          if(state is RegisterLinkPersonSuccessState){
            if(state.registerDelegateModel.key==1){
              showToast(msg: "تم التسجيل بنجاح", state: ToastStates.SUCCESS);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
            }
            else{
              showToast(msg: state.registerDelegateModel.msg!, state: ToastStates.ERROR);
            }
          }

        },
        builder: (context, state) => Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            key: snakbar,
            backgroundColor: backGround,
            body: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      //SizedBox(height: 30,),
                      HeaderLogo(),
                      SizedBox(
                        height: 3.h,
                      ),
                      defaultTextFormField(
                          context: context,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "من فضلك ادخل البريد الالكتروني";
                            }
                            if (!value.contains("@")) {
                              return "من فضلك اكتب البريد الالكتروني بصيغة صحيحة";
                            }
                          },
                          labelText: "البريد الالكتروني",
                          labelTextcolor: white,
                          label: "الرجاء ادخال البريد الالكتروني",
                          prefixIcon: Icons.email_outlined),
                      SizedBox(
                        height: 3.h,
                      ),
                      defaultTextFormField(
                          context: context,
                          controller: nameController,
                          labelTextcolor: white,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "من فضلك ادخل الاسم";
                            }
                          },
                          labelText: "الاسم",
                          label: "الرجاء ادخال اسمك",
                          prefixIcon: Icons.person_outline),
                      SizedBox(
                        height: 3.h,
                      ),
                      defaultTextFormField(
                          context: context,
                          controller: personalCardController,
                          type: TextInputType.number,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "من فضلك ادخل رقم الهوية";
                            }
                          },
                          labelText: "رقم الهوية",
                          labelTextcolor: white,
                          label: "الرجاء ادخال رقم الهوية",
                          prefixIcon: Icons.person_outline),
                      SizedBox(
                        height: 3.h,
                      ),

                      defaultTextFormField(
                          context: context,
                          controller: phoneController,
                          type: TextInputType.number,
                          labelTextcolor: white,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "من فضلك ادخل رقم الهاتف";
                            }
                          },
                          labelText: "رقم الجوال",
                          label: "الرجاء ادخال رقم الجوال",
                          prefixIcon: Icons.email_outlined),
                      SizedBox(
                        height: 3.h,
                      ),
                      defaultTextFormField(
                          context: context,
                          controller: cityController,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "من فضلك ادخل المدينة";
                            }
                          },
                          labelText: "المدينة",
                          label: "الرجاء ادخال المدينة",
                          labelTextcolor: white,
                          prefixIcon: Icons.person_outline),
                      SizedBox(
                        height: 3.h,
                      ),
                      defaultTextFormField(
                          context: context,
                          controller: nationalityController,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "من فضلك ادخل الجنسية";
                            }
                          },
                          labelText: "الجنسية",
                          labelTextcolor: white,
                          label: "الرجاء ادخال الجنسية",
                          prefixIcon: Icons.person_outline),
                      SizedBox(
                        height: 3.h,
                      ),
                      defaultTextFormField(
                          context: context,
                          controller: ageController,
                          type: TextInputType.number,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "من فضلك ادخل العمر";
                            }
                          },
                          labelText: "العمر",
                          label: "الرجاء ادخال العمر",
                          labelTextcolor: white,
                          prefixIcon: Icons.person_outline),
                      SizedBox(
                        height: 3.h,
                      ),
                      defaultTextFormField(
                          context: context,
                          controller: passwordController,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "من فضلك ادخل كلمة المرور";
                            }
                          },
                          labelText: "كلمة المرور",
                          label: "الرجاء ادخال كلمة المرور",
                          labelTextcolor: white,
                          prefixIcon: Icons.person_outline),
                      SizedBox(
                        height: 3.h,
                      ),
                      defaultTextFormField(
                          context: context,
                          controller: experienceController,
                          type: TextInputType.number,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "من فضلك ادخل سنين خبرتك";
                            }
                          },
                          labelText: "كم خبرتك في الخطابة ؟",
                          labelTextcolor: white,
                          label: "الرجاء ادخال سنين خبرتك",
                          prefixIcon: Icons.person_outline),
                      SizedBox(
                        height: 3.h,
                      ),
                      TextFormField(
                        style: TextStyle(color: white),
                        keyboardType: TextInputType.multiline,
                        controller: resonController,
                        maxLines: 5,
                        minLines: 1,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "من فضلك ادخل لماذا ترغبي بالعمل مع تطبيق استقرار ";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "سبب رغبتك بالعمل لدينا ؟",
                          hintStyle: TextStyle(color: white, fontSize: 10.sp),
                          hintMaxLines: 5,
                          enabled: true,

                          //   alignLabelWithHint: false,
                          //   prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                 BorderSide(width: 0.5.w, color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          filled: true,


                          fillColor: backGround,
                        ),
                      ),
                      /*   defaultTextFormField(context: context,
                          controller: resonController,
                          type: TextInputType.text,
                          validate: (String?value) {},
                        //  labelText: "رقم الهوية",
                          label: "لماذا ترغبي بالعمل مع تطبيق استقرار؟",
                          labelTextcolor: white,

                          prefixIcon: Icons.person_outline
                      ),*/
                      SizedBox(
                        height: 2.5.h,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,

                        controller: moneyController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "من فضلك ادخل اتعابك من كلا الجنسين";
                          }
                        },
                        style: TextStyle(color: white),
                        decoration: InputDecoration(
                          hintText: "كم اتعابك من كلا الجنسين؟",
                          hintStyle: TextStyle(color: white, fontSize: 10.sp),
                          //   prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                 BorderSide(width: 0.5.w, color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          filled: true,

                          fillColor: backGround,
                        ),
                      ),
                      /*   defaultTextFormField(context: context,
                          controller: moneyController,
                          type: TextInputType.text,
                          validate: (String?value) {},
                          //  labelText: "رقم الهوية",
                          label: "كم اتعابك من كلا الجنسين؟",
                          labelTextcolor: white,
                          prefixIcon: Icons.person_outline
                      ),*/
                      /*
                      defaultTextFormField(context: context,
                          controller: phoneController,
                          type: TextInputType.number,
                          validate: (String?value) {},
                          labelText: "كلمة السر",
                          label: "الرجاء ادخال كلمة السر",
                          prefixIcon: Icons.lock_outline_rounded,
                          suffix: Icons.visibility_outlined
                      ),*/
                      SizedBox(
                        height: 3.h,
                      ),
                      CheckedBoxRegister(
                          onchanged: () {
                            setState(() {
                              isSelected = !isSelected;
                            });
                            print(isSelected);
                          },
                          text:
                              "اقسم بالله ان المعلومات التي قمت بادخلها صحيحة و التطبيق غير مسئول عن اي معلومات اخري غير صحيحة",
                          isSelected: isSelected,
                          focusColor: white,
                          TextColor: white),

                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: termsSelected,
                              onChanged: (bool? value) {
                                setState(() {
                                  termsSelected=!termsSelected;
                                });

                              },

//            fillColor:MaterialStateColor.resolveWith((states) =>Colors.white) ,
                              focusColor: primary,
                              autofocus: true),
                          Text(
                              "اوافق علي",
                              style: TextStyle(color: primary, fontSize: 10.sp)),
                          InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TermsScreen()));
                            },
                            child: Text(
                                "الشروط و الاحكام",

                                style: TextStyle(color: primary, fontSize: 10.sp,decoration: TextDecoration.underline)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      doubleInfinityMaterialButton(
                          text: "تسجيل",
                          onPressed: () {
                            if(formkey.currentState!.validate()&&isSelected&&termsSelected){
                            RegisterLinkPersonCubit.get(context).registerDelegate(
                              experience: experienceController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                                age: ageController.text,
                                nationalityId: personalCardController.text,
                                password: passwordController.text,
                                nationality: nationalityController.text,
                                reson: resonController.text,
                                moneydowry: moneyController.text,
                                city: cityController.text);}
                            if(isSelected==false){
                              ScaffoldMessenger.of(context)
                                  .showSnackBar( SnackBar(
                                padding: EdgeInsetsDirectional.only(
                                    bottom: 3.h, start: 2.5.w, top: 2.h),
                                duration: Duration(milliseconds: 2000),
                                backgroundColor: Colors.red,
                                content: Text(
                                  "من فضلك اقسم بان كل المعلومات صحيحة لتستطيع التسجيل ",
                                  style: TextStyle(
                                      fontFamily: "Hs", fontSize: 11.sp),
                                ),
                              ));
                            }
                            if(termsSelected==false){
                              ScaffoldMessenger.of(context)
                                  .showSnackBar( SnackBar(
                                padding: EdgeInsetsDirectional.only(
                                    bottom: 3.h, start: 2.5.w, top: 2.h),
                                duration: Duration(milliseconds: 2000),
                                backgroundColor: Colors.red,
                                content: Text(
                                  "من فضلك وافق علي الشروط و الاحكام  لتستطيع التسجيل ",
                                  style: TextStyle(
                                      fontFamily: "Hs", fontSize: 11.sp),
                                ),
                              ));
                            }
                            /*   Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VerificationPhone()));*/
                          }),
                      SizedBox(
                        height: 2.5.h,
                      ),
                      AlreadyHaveAccountText(),
                  SizedBox(
                    height: 3.h,
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
