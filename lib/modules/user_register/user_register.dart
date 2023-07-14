import 'dart:developer';

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
  Widget build(BuildContext context) {
    return BlocProvider<ShopLoginCubit>(
      create: (context) => ShopLoginCubit(),
      child: BlocProvider<RegisterCubit>(
        create: (BuildContext context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            on_state_changed(context, state);
          },
          builder: (context, state) => Directionality(
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

                          defaultTextFormField(
                              context: context,
                              controller: nationalIdController,
                              type: TextInputType.number,
                              validate: (String? value) {
                                newUser.nationalID = value;
                                return (value!.isEmpty)
                                    ? "من فضلك ادخل رقم الهوية"
                                    : null;
                              },
                              labelText: "رقم الهوية",
                              label: "الرجاء ادخال رقم الهوية",
                              prefixIcon: Icons.person_outline),

                          Text('        سيتم تسجيل الدخول عن طريق رقم الهوية',
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 13,
                            ),
                          ),

                          SizedBox(height: 2.h,),


                          defaultTextFormField(
                              context: context,
                              controller: phoneController,
                              type: TextInputType.number,
                              validate: (String? value) {
                                newUser.phone = value;
                                return (value!.isEmpty)? "من فضلك ادخل الهاتف": null;
                              },
                              labelText: "رقم الهاتف",
                              label: "الرجاء ادخال رقم الهاتف",
                              prefixIcon: Icons.phone),

                          Text('        سيتم طلب منك رقم الهاتف في حالة استعادة كلمة المرور',
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 13,
                            ),
                          ),

                          SizedBox(height: 4.h,),
                          // defaultTextFormField(
                          //     context: context,
                          //     controller: cityController,
                          //     type: TextInputType.text,
                          //     validate: (String? value) {
                          //       newUser.city = value;
                          //       return (value!.isEmpty)? "من فضلك ادخل المدينة": null;
                          //     },
                          //     labelText: "المدينة",
                          //     label: "الرجاء ادخال المدينة",
                          //     prefixIcon: Icons.person_outline),

                          //   // "الاسم ينتهي"
                          //   Text(AppCubit.Specifications[SpecificationIDs.name_end_with]["nameAr"],
                          //     style: TextStyle(color: WHITE),
                          //   ),
                          //   GridView.count(
                          //     shrinkWrap: true,
                          //     crossAxisCount:
                          //         (MediaQuery.of(context).orientation == Orientation.landscape)? 4: 1,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     childAspectRatio: 0.6 / 0.007.h,
                          //     children: getListofRadioButtons(SpecificationIDs.name_end_with),
                          //   ),
                          //   defaultTextFormField(
                          //         context: context,
                          //         controller: tribeController,
                          //         type: TextInputType.text,
                          //         validate: (value) {
                          //           newUser.tribe = value;
                          //           return null;
                          //         },
                          //         labelText: "العائلة / القبيلة",
                          //         label: "ادخل اسم العائلة/القبيلة",
                          //         prefixIcon: Icons.person_outline,
                          //   ),
                          //
                          //
                          //   defaultTextFormField(
                          //       context: context,
                          //       controller: ageController,
                          //       type: TextInputType.number,
                          //       validate: (String? value) {
                          //         newUser.age = value;
                          //         return (value!.isEmpty)? "من فضلك ادخل العمر": null;
                          //       },
                          //       labelText: "العمر",
                          //       label: "الرجاء ادخال العمر",
                          //       prefixIcon: Icons.person_outline),
                          //
                          //   defaultTextFormField(
                          //       context: context,
                          //       controller: heightController,
                          //       type: TextInputType.number,
                          //       validate: (String? value) {
                          //         newUser.height = value;
                          //         return (value!.isEmpty)?"من فضلك ادخل الطول": null;
                          //       },
                          //       labelText: "الطول",
                          //       label: "الرجاء ادخال الطول",
                          //       prefixIcon: Icons.person_outline),
                          //
                          //   defaultTextFormField(
                          //       context: context,
                          //       controller: weightController,
                          //       type: TextInputType.number,
                          //       validate: (String? value) {
                          //         newUser.weight = value;
                          //         return (value!.isEmpty)? "من فضلك ادخل الوزن": null;
                          //       },
                          //       labelText: "الوزن",
                          //       label: "الرجاء ادخال الوزن",
                          //       prefixIcon: Icons.person_outline),
                          //
                          //   // "لون الشعر"
                          //   Text(AppCubit.Specifications[SpecificationIDs.hair_colour]["nameAr"],
                          //     style: TextStyle(color: WHITE, fontSize: 11.sp),
                          //   ),
                          //
                          //   GridView.count(
                          //     shrinkWrap: true,
                          //     crossAxisCount:
                          //         (MediaQuery.of(context).orientation == Orientation.landscape)? 4: 2,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     childAspectRatio: 0.6 / 0.015.h,
                          //     children: getListofRadioButtons(SpecificationIDs.hair_colour),
                          //   ),
                          //
                          //   // "نوع الشعر"
                          //   Text(AppCubit.Specifications[SpecificationIDs.hair_type]["nameAr"],
                          //     style: TextStyle(color: WHITE, fontSize: 11.sp),
                          //   ),
                          //
                          //   GridView.count(
                          //     shrinkWrap: true,
                          //     crossAxisCount:
                          //         (MediaQuery.of(context).orientation == Orientation.landscape)? 4: 2,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     childAspectRatio: 0.6 / 0.015.h,
                          //     children: getListofRadioButtons(SpecificationIDs.hair_type),
                          //   ),
                          //
                          //   //"لون البشرة"
                          //   Text(AppCubit.Specifications[SpecificationIDs.skin_colour]["nameAr"],
                          //     style: TextStyle(color: WHITE, fontSize: 11.sp),
                          //   ),
                          //
                          //   GridView.count(
                          //     shrinkWrap: true,
                          //     crossAxisCount:
                          //         (MediaQuery.of(context).orientation == Orientation.landscape)? 4: 2,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     childAspectRatio: 0.6 / 0.015.h,
                          //     children: getListofRadioButtons(SpecificationIDs.skin_colour),
                          //   ),
                          //
                          //   //"من عرق"
                          //   Text(AppCubit.Specifications[SpecificationIDs.strain]["nameAr"],
                          //     style: TextStyle(color: WHITE, fontSize: 11.sp),
                          //   ),
                          //
                          //   GridView.count(
                          //     shrinkWrap: true,
                          //     crossAxisCount:
                          //         (MediaQuery.of(context).orientation == Orientation.landscape)? 4: 2,
                          //     padding: EdgeInsets.all(0),
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     childAspectRatio: 0.6 / 0.015.h,
                          //     children: getListofRadioButtons(SpecificationIDs.strain),
                          //   ),
                          //
                          //   // "الموهل العلمي"
                          //   Text(AppCubit.Specifications[SpecificationIDs.qualification]["nameAr"],
                          //     style: TextStyle(color: WHITE, fontSize: 11.sp),
                          //   ),
                          //
                          //   GridView.count(
                          //     shrinkWrap: true,
                          //     padding: EdgeInsets.all(0),
                          //     crossAxisCount:
                          //         (MediaQuery.of(context).orientation == Orientation.landscape)? 5: 3,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     childAspectRatio: 0.6 / 0.025.h,
                          //     children: getListofRadioButtons(SpecificationIDs.qualification),
                          //   ),
                          //
                          //   //الوظيفة
                          //   Text(AppCubit.Specifications[SpecificationIDs.job]["nameAr"],
                          //     style: TextStyle(color: WHITE, fontSize: 11.sp),
                          //   ),
                          //
                          //   GridView.count(
                          //     shrinkWrap: true,
                          //     padding: EdgeInsets.all(0),
                          //     crossAxisCount:
                          //         (MediaQuery.of(context).orientation == Orientation.landscape)? 5: 2,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     childAspectRatio: 0.6 / 0.02.h,
                          //     children: getListofRadioButtons(SpecificationIDs.job ),
                          //   ),
                          //
                          // //الحالة الصحية
                          //   Text(AppCubit.Specifications[SpecificationIDs.health_status]["nameAr"],
                          //     style: TextStyle(color: WHITE, fontSize: 11.sp),
                          //   ),
                          //
                          //   GridView.count(
                          //     shrinkWrap: true,
                          //     padding: EdgeInsets.all(0),
                          //     crossAxisCount:
                          //         (MediaQuery.of(context).orientation == Orientation.landscape)? 5: 2,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     childAspectRatio: 0.6 / 0.02.h,
                          //     children: getListofRadioButtons(SpecificationIDs.health_status),
                          //   ),
                          //
                          //   defaultTextFormField(
                          //       context: context,
                          //       controller: illnessTypeController,
                          //       type: TextInputType.text,
                          //       validate: (String? value) {
                          //         newUser.illnessType = value;
                          //         return null;
                          //       },
                          //       labelText: "نوع المرض",
                          //       label: "الرجاء ادخال نوع المرض (ان وجد)",
                          //       prefixIcon: Icons.person),
                          //
                          //   //الحالة الاجتماعية
                          //   Text(AppCubit.Specifications[SpecificationIDs.social_status]["nameAr"] ,
                          //     style: TextStyle(color: WHITE, fontSize: 11.sp),
                          //   ),
                          //
                          //   GridView.count(
                          //     shrinkWrap: true,
                          //     padding: EdgeInsets.all(0),
                          //     crossAxisCount:
                          //         (MediaQuery.of(context).orientation == Orientation.landscape)? 5: 2,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     childAspectRatio: 0.6 / 0.02.h,
                          //     children: getListofRadioButtons(SpecificationIDs.social_status),
                          //   ),
                          //
                          //   //هل لديك اطفال
                          //   Text(AppCubit.Specifications[SpecificationIDs.have_children]["nameAr"],
                          //     style: TextStyle(color: WHITE, fontSize: 11.sp),
                          //   ),
                          //
                          //   GridView.count(
                          //     shrinkWrap: true,
                          //     padding: EdgeInsets.all(0),
                          //     crossAxisCount:
                          //         (MediaQuery.of(context).orientation == Orientation.landscape)? 5: 1,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     mainAxisSpacing: .05,
                          //     childAspectRatio: 0.8 / 0.01.h,
                          //     children: getListofRadioButtons(SpecificationIDs.have_children),
                          //   ),
                          //
                          //   defaultTextFormField(
                          //       context: context,
                          //       controller: numberOfKidsController,
                          //       type: TextInputType.number,
                          //       validate: (String? value){
                          //         bool no_kids = newUser.subSpecifications.any((sub) => sub.id == 77);
                          //         bool anyone_is_selected = newUser.subSpecifications.any((sub) => sub.specId == SpecificationIDs.have_children);
                          //         // 77 -> 'بدون أطفال'
                          //         if( no_kids || !anyone_is_selected) {
                          //           return null;
                          //         }else if(value!.isEmpty){
                          //           return "من فضلك اكتب عدد الاطفال";
                          //         }
                          //         newUser.numberOfKids = int.parse(numberOfKidsController.text);
                          //         return null;
                          //
                          //       },
                          //       labelText: "عدد الاطفال",
                          //       label: "الرجاء ادخال عدد الاطفال (ان وجد)",
                          //       prefixIcon: Icons.person),
                          //
                          //   // "نبذة عن مظهرك"
                          //   Text(AppCubit.Specifications[SpecificationIDs.appearance]["nameAr"],
                          //     style: TextStyle(color: WHITE, fontSize: 11.sp),
                          //   ),
                          //
                          //   GridView.count(
                          //     shrinkWrap: true,
                          //     padding: const EdgeInsets.all(0),
                          //     crossAxisCount:
                          //         (MediaQuery.of(context).orientation == Orientation.landscape)? 5: 2,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     childAspectRatio: 0.8 / 0.02.h,
                          //     children: getListofRadioButtons(SpecificationIDs.appearance),
                          //   ),
                          //
                          //   // "الوضع المالي"
                          //   Text(AppCubit.Specifications[SpecificationIDs.financial_situation]["nameAr"],
                          //     style: TextStyle(color: WHITE, fontSize: 11.sp),
                          //   ),
                          //
                          //   GridView.count(
                          //     shrinkWrap: true,
                          //     padding: EdgeInsets.all(0),
                          //     crossAxisCount:
                          //         (MediaQuery.of(context).orientation == Orientation.landscape)? 5: 2,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     childAspectRatio: 0.8 / 0.02.h,
                          //     children: getListofRadioButtons(SpecificationIDs.financial_situation),
                          //   ),
                          //
                          //   // "نوع الزواج"
                          //   Text(AppCubit.Specifications[SpecificationIDs.marriage_Type]["nameAr"],
                          //     style: TextStyle(color: WHITE, fontSize: 11.sp),
                          //   ),
                          //   GridView.count(
                          //     shrinkWrap: true,
                          //     padding: EdgeInsets.all(0),
                          //     crossAxisCount:
                          //         (MediaQuery.of(context).orientation ==Orientation.landscape)? 5: 2,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     childAspectRatio: 0.8 / 0.02.h,
                          //     children: getListofRadioButtons(SpecificationIDs.marriage_Type),
                          //   ),
                          //
                          //   defaultTextFormField(
                          //       context: context,
                          //       labelText: "قيمة المهر",
                          //       controller: dowryController,
                          //       type: TextInputType.number,
                          //       validate: (String? value) {
                          //         newUser.dowry = value;
                          //         return (value!.isEmpty)? "من فضلك ادخل المهر": null;
                          //       },
                          //       label: "قيمة المهر(0 الي 100 الف)",
                          //       prefixIcon: Icons.person),
                          //
                          //   TextFormField(
                          //     controller: termsController,
                          //     validator: (String? value) {
                          //       newUser.terms = value;
                          //       return (value!.isEmpty)? "من فضلك ادخل شروطك": null;
                          //     },
                          //     decoration: InputDecoration(
                          //       hintText: "شروطك",
                          //       hintStyle: TextStyle(color: WHITE, fontSize: 12),
                          //       hintMaxLines: 5,
                          //       enabled: true,
                          //       border: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(10.0),
                          //       ),
                          //       enabledBorder: OutlineInputBorder(
                          //         borderSide: const BorderSide( width: 1, color: Colors.white),
                          //         borderRadius: BorderRadius.circular(15),
                          //       ),
                          //       filled: true,
                          //       fillColor: BG_DARK_COLOR,
                          //     ),
                          //     keyboardType: TextInputType.multiline,
                          //     maxLines: 3,
                          //     minLines: 1,
                          //     style: TextStyle(color: WHITE),
                          //   ),

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

                          SizedBox(
                            height: 1.h,
                          ),

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

                          BlocConsumer<ShopLoginCubit, ShopLoginStates>(
                            listener: (context, state) {
                              handle_login_state_change(context, state);
                            },
                            builder: (context, state) => ConditionalBuilder(
                                condition: state is ShopLoginLoadingState,
                                builder: (context) => Center(
                                      child: Text(
                                        "جاري تسجيل الدخول",
                                        style: TextStyle(
                                            color: WHITE, fontSize: 20.sp),
                                      ),
                                    ),
                                fallback: (context) => Text(
                                      "",
                                      style: TextStyle(color: WHITE),
                                    )),
                          ),

                          const AlreadyHaveAccountText(),
                        ],
                      ),
                    ),
                  ),
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

  void on_state_changed(BuildContext context, RegisterState state) {
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
      log('loading ...............');
    } else if (state is LoginAfterRegisterState) {
      context.read<ShopLoginCubit>().UserLogin(
          nationalId: nationalIdController.text,
          password: passwordController.text);
    }
  }

  void handle_login_state_change(context, state) {
    if (state is ShopLoginSuccessAndActiveState) {

      showToast(msg: "تم تسجيل الدخول بنجاح", state: ToastStates.SUCCESS);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LayoutScreen()),
          (route) => false);
    } else if (state is ShopLoginSuccessButInActiveState) {
      showToast(
          // عميل مسجل لكن غير مشترك
          msg: "تم تسجيل الدخول بنجاح ، الرجاء الاشتراك لتفعيل الحساب",
          state: ToastStates.WARNING);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => NotSubscribedScreen()),
          (route) => true);
    } else if (state is ShopLoginErrorState) {
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
