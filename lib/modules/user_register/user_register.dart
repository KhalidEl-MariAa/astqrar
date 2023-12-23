import 'dart:developer';

import 'package:astarar/modules/home/6_profile/user_profile/user_profile.dart';

import '../../shared/components/defaultTextFormField.dart';
import '../../shared/components/double_infinity_material_button.dart';

import '../login/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../models/user.dart';
import '../../shared/components/checkedbox_register.dart';
import '../../shared/components/components.dart';
import '../../shared/components/header_logo.dart';
import '../../shared/components/logo/normal_logo.dart';
import '../../shared/components/radiobuttonregister.dart';
import '../../shared/styles/colors.dart';
import '../home/4_more/2_terms/terms.dart';
import '../home/layout/cubit/cubit.dart';
import '../home/layout/layout.dart';
import '../login/cubit/cubit.dart';
import '../login/not_subscribed.dart';
import 'alreadyhaneaccount_text.dart';
import 'cubit.dart';
import 'states.dart';

class UserRegister extends StatefulWidget {
  UserRegister({Key? key}) : super(key: key);

  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  List<String> Gender = ['ذكر', 'أنثى'];

  _UserRegisterState() {
    new LayoutCubit().loadSpecificationsFromBackend();
  }

  var formkey = GlobalKey<FormState>();

  User newUser = User()..gender = 1;

  var emailController = TextEditingController();
  var userNameController = TextEditingController();
  var nationalIdController = TextEditingController();
  var cityController = TextEditingController();
  var nationalityController = TextEditingController();

  var tribeController = TextEditingController();
  var phoneController = TextEditingController();
  var ageController = TextEditingController();
  var heightController = TextEditingController();
  var weightController = TextEditingController();

  var nameOfJobController = TextEditingController();
  var illnessTypeController = TextEditingController();
  var numberOfKidsController = TextEditingController();
  var dowryController = TextEditingController();
  var termsController = TextEditingController();

  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  bool isDataConfirmed = false;
  bool isTermsConfirmed = false;

  @override
  Widget build(BuildContext context) 
  {
    return 
      Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: NormalLogo(
                appbarTitle: "تسجيل جديد",
                isBack: true,
              )),
          backgroundColor: BG_DARK_COLOR,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     InkWell(
                      //       onTap: (){ Navigator.pop(context); },
                      //       child: Text("رجوع",
                      //         style: TextStyle(color: white, fontSize: 12.sp),
                      //       ),
                      //     )]
                      // ),

                      const HeaderLogo(),

                      Material(
                        elevation: 5,
                        shadowColor: Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          height: 7.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: BG_DARK_COLOR,
                          ),
                          child: DropdownButton<String>(
                            underline: Text(" "),
                            isExpanded: true,
                            elevation: 10,
                            iconDisabledColor: Colors.grey,
                            iconEnabledColor: PRIMARY,
                            icon: Padding(
                              padding: EdgeInsetsDirectional.only(
                                  end: 2.w), //, top: 1.h
                              child:
                                  const Icon(Icons.arrow_circle_down_sharp),
                            ),
                            hint: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 2.w),
                              child: Text(
                                this.Gender[(newUser.gender??1) - 1],
                                textAlign: TextAlign.start,
                                style: GoogleFonts.almarai(
                                    color: PRIMARY,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                newUser.gender =
                                    this.Gender.indexOf(newValue!) + 1;
                              });
                            },
                            items: this.Gender.map((String g) {
                              return DropdownMenuItem<String>(
                                value: g,
                                alignment: Alignment.centerRight,
                                child: Material(
                                  elevation: 5,
                                  shadowColor: PRIMARY,
                                  child: Container(
                                    width: double.infinity,
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      g,
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.almarai(
                                          color: BLACK,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),

                      defaultTextFormField(
                          context: context,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "من فضلك ادخل البريد الالكتروني";
                            } else if (!value.contains("@")) {
                              return "من فضلك ادخل البريد الالكتروني بطريقة صحيحة";
                            } else {
                              newUser.email = value;
                              return null;
                            }
                          },
                          labelText: "البريد الالكتروني",
                          label: "الرجاء ادخال البريد الالكتروني",
                          prefixIcon: Icons.email_outlined),

                      defaultTextFormField(
                          context: context,
                          controller: userNameController,
                          type: TextInputType.text,
                          validate: (String? value) {
                            newUser.user_Name = value;
                            return (value!.isEmpty)
                                ? "من فضلك ادخل الاسم"
                                : null;
                          },
                          labelText: "الاسم",
                          label: "الرجاء ادخال اسمك",
                          prefixIcon: Icons.person_outline),

                      // defaultTextFormField(
                      //     context: context,
                      //     controller: nationalIdController,
                      //     type: TextInputType.number,
                      //     validate: (String? value) {
                      //       newUser.nationalID = value;
                      //       return (value!.isEmpty)
                      //           ? "من فضلك ادخل رقم الهوية"
                      //           : null;
                      //     },
                      //     labelText: "رقم الهوية",
                      //     label: "الرجاء ادخال رقم الهوية",
                      //     prefixIcon: Icons.person_outline),
                      // Text('        سيتم تسجيل الدخول عن طريق رقم الهوية',
                      //   style: TextStyle(
                      //     color: Colors.yellow,
                      //     fontSize: 13,
                      //   ),
                      // ),
                      // SizedBox(height: 2.h,),


                      defaultTextFormField(
                          context: context,
                          controller: phoneController,
                          type: TextInputType.number,
                          validate: (String? value) {
                            newUser.phone = value;
                            return (value!.isEmpty)? "من فضلك ادخل الجوال": null;
                          },
                          labelText: "رقم الجوال",
                          label: "الرجاء ادخال رقم الجوال",
                          prefixIcon: Icons.phone_android_rounded),

                      Text('        سيتم طلب منك رقم الجوال عند استعادة كلمة المرور',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 13,
                        ),
                      ),

                      SizedBox(height: 4.h,),

                      defaultTextFormField(
                        context: context,
                        controller: passwordController,
                        type: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return "من فضلك ادخل كلمة السر";
                          } else if (value.length < 7) {
                            return " من فضلك ادخل كلمة مرور لا تقل عن 7 حروف";
                          } else {
                            newUser.showPassword = value;
                            return null;
                          }
                        },
                        labelText: "كلمة السر",
                        label: "كلمة السر",
                        prefixIcon: Icons.lock_outline_rounded,
                      ),

                      defaultTextFormField(
                        context: context,
                        controller: confirmPasswordController,
                        type: TextInputType.text,
                        validate: (val) {
                          if (newUser.showPassword != val) {
                            return "كلمة السر و تاكيد كلمة السر غير متطابقان";
                          } else if (val!.isEmpty) {
                            return "من فضلك ادخل تاكيد كلمة السر";
                          } else {
                            newUser.showPassword = val;
                            return null;
                          }
                        },
                        labelText: "تاكيد كلمة السر",
                        label: "تاكيد كلمة السر",
                        prefixIcon: Icons.lock_outline_rounded,
                      ),

                      CheckedBoxRegister(
                          onchanged: () {
                            setState(() {
                              isDataConfirmed = !isDataConfirmed;
                            });
                          },
                          text:
                              "أتعهد بأن جميع المعلومات المدخلة صحيحة واتحمل كامل المسؤولية والاجراءات القانونية المتخذة في حال ثبت غير ذلك",
                          isSelected: isDataConfirmed,
                          focusColor: PRIMARY,
                          TextColor: WHITE),

                      Row(
                        children: [
                          Checkbox(
                            value: isTermsConfirmed,
                            onChanged: (bool? value) {
                              setState(() {
                                isTermsConfirmed = !isTermsConfirmed;
                              });
                            },
                            focusColor: PRIMARY,
                            autofocus: true,
                          ),
                          Text("اوافق علي  ",
                              style: TextStyle(
                                  color: PRIMARY, fontSize: 10.sp)),
                          InkWell(
                            child: Text("الشروط و الاحكام",
                                style: TextStyle(
                                    color: PRIMARY,
                                    fontSize: 10.sp,
                                    decoration: TextDecoration.underline)),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TermsScreen()));
                            },
                          )
                        ],
                      ),

                      SizedBox(height: 1.h, ),

                      // Bloc inside Bloc
                      BlocProvider<LoginCubit>(
                        create: (BuildContext context) => LoginCubit(),
                        child: 
                          BlocProvider<RegisterCubit>(
                            create: (BuildContext context) => RegisterCubit(),
                            child: 
                              Column(
                                children: 
                                [
                                  BlocConsumer<RegisterCubit, RegisterState>(
                                    listener: (context, state) {
                                      on_state_changed(context, state);
                                    },
                                    builder: (context, state) => 
                                      ConditionalBuilder(
                                        condition: state is RegisterState_Loading,
                                        builder: (context) => Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        fallback: (context) => doubleInfinityMaterialButton(
                                            text: "تسجيل",
                                            onPressed: () {
                                              registerOnPressed(context);
                                            }),
                                      ),
                                  ),

                                  BlocConsumer<LoginCubit, LoginStates>(
                                      listener: (context, state) {
                                        handle_login_state_change(context, state);
                                      },
                                      builder: (context, state) => ConditionalBuilder(
                                          condition: state is LoginLoadingState,
                                          builder: (context) => Center(
                                                child: Text(
                                                  "جاري تسجيل الدخول",
                                                  style: TextStyle( color: WHITE, fontSize: 20.sp),
                                                ),
                                              ),
                                          fallback: (context) => 
                                            Text(
                                                "",
                                                style: TextStyle(color: WHITE),
                                              )),
                                  ),

                                ],)
                                
                              ),
                      ),
                     
                      const AlreadyHaveAccountText(),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
  }

  void registerOnPressed(BuildContext context) {
    if (!isDataConfirmed || !isTermsConfirmed) {
      showToast(
          msg: "يجب الموافقة على الشروط والقسم بصحة البيانات",
          state: ToastStates.ERROR);
      return;
    }

    RegisterCubit.get(context).RegisterClient(newUser, formkey);
  }

  void on_state_changed(BuildContext context, RegisterState state) 
  {
    if (state is RegisterState_Success) {
      if (state.response.key == 1) {
        showToast(msg: "تم التسجيل بنجاح", state: ToastStates.SUCCESS);

        // clearAllFields();

        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(builder: (context) => LoginScreen()),
        //   (route) => false,
        // );
      }
    } else if (state is RegisterState_Error) {
      showToast(msg: state.err_msg, state: ToastStates.ERROR);
    } else if (state is RegisterState_Loading) {
      log('Registering ...............');
    } else if (state is LoginAfterRegisterState) 
    {
      LoginCubit.get(context).UserLogin(
          phoneNumber: phoneController.text,
          password: passwordController.text);
    }
  }

  void handle_login_state_change(context, state) 
  {
    if (state is LoginSuccessAndActiveState) {

      showToast(msg: "تم تسجيل الدخول بنجاح", state: ToastStates.SUCCESS);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LayoutScreen()),
          (route) => false);
    } else if (state is LoginSuccessButInActiveState) {
      showToast(
          // عميل مسجل لكن غير مشترك
          msg: "تم تسجيل الدخول بنجاح ، الرجاء الاشتراك لتفعيل الحساب",
          state: ToastStates.WARNING);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => NotSubscribedScreen()),
          (route) => true);
    } else if (state is LoginSuccessButProfileIsNotCompleted) {

      navigateTo(context: context, widget: UserProfileScreen( )  );

    } else if (state is LoginErrorState) {
      showToast(msg: state.error, state: ToastStates.ERROR);
    }
  }

  List<Widget> getListofRadioButtons(int specificationId) {
    var Spec = LayoutCubit.Specifications[specificationId];

    if (Spec == null) return [Text("No Elements")];

    List<Widget> radios = [];
    Spec["subSpecifications"].forEach((sub_id, sub) {
      // subSpecifications
      SubSpecification found_or_created;
      found_or_created = newUser.subSpecifications.firstWhere(
          (user_sub) => user_sub.specId == sub["specificationId"], orElse: () {
        var new_sub =
            new SubSpecification(0, sub["nameAr"], Spec["id"], Spec["nameAr"]);
        return new_sub;
      });

      radios.add(RadioButtonRegister(
          value: sub["id"],
          groupvalue: found_or_created.id,
          title: sub["nameAr"],
          changeFunction: () {
            setState(() {
              if (found_or_created.id == 0) {
                newUser.subSpecifications.add(found_or_created);
              }
              found_or_created.id = sub["id"];
              found_or_created.value = sub["nameAr"];
              found_or_created.specId = Spec["id"];
              found_or_created.name = Spec["nameAr"];
            });
          }));
    });
    return radios;
  }

  void clearAllFields() {
    emailController.clear();
    userNameController.clear();
    nationalIdController.clear();
    nationalityController.clear();
    phoneController.clear();

    dowryController.clear();
    termsController.clear();
    passwordController.clear();
    confirmPasswordController.clear();

    // cityController.clear();
    // tribeController.clear();
    // ageController.clear();
    // heightController.clear();
    // weightController.clear();
    // nameOfJobController.clear();
    // illnessTypeController.clear();
    // numberOfKidsController.clear();
  }
} //end class
