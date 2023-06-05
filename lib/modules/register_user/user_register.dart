import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:astarar/layout/cubit/states.dart';
import 'package:astarar/models/get_information_user.dart';
import 'package:astarar/modules/linkperson/layout_linkPerson/layout_link_person.dart';
import 'package:astarar/modules/register_user/cubit.dart';
import 'package:astarar/modules/register_user/states.dart';
import 'package:astarar/modules/terms/terms.dart';
import 'package:astarar/shared/alreadyhaneaccount_text.dart';
import 'package:astarar/shared/components/checkedbox_register.dart';
import 'package:astarar/shared/components/components.dart';
import 'package:astarar/shared/components/header_logo.dart';
import 'package:astarar/shared/components/user/register/radiobuttonregister.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:astarar/layout/cubit/cubit.dart';
import 'package:sizer/sizer.dart';
import '../../models/user.dart';
import '../../models/server_response_model.dart';
import '../../shared/network/end_points.dart';
import '../../shared/network/remote.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class UserRegister extends StatefulWidget 
{
  // final String? delegateId;

  UserRegister({Key? key }) : super(key: key);
  // UserRegister({Key? key, required this.delegateId}) : super(key: key);

  @override
  _UserRegisterState createState() => _UserRegisterState();
}


class _UserRegisterState extends State<UserRegister> 
{
  late Map<String, int> specifications;
  _UserRegisterState() {
    Map<String, int> specifications = new AppCubit().getSpecifications();
  }
  
  bool isLoading = false;
  User newUser = User();

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

  int selectedlastName = 0;
  int selectedHairColorName = 0;
  int selectedHairTypeName = 0;
  int selectedSkinColorName = 0;
  int selectedParentSkinColorName = 0;
  int selectedExperience = 0;
  int selectedJobType = 0;
  int selectedIllnessType = 0;
  int selectedMiliirtyType = 0;
  int selectedMiliirtyMaleType = 0;
  int selectedNumberOfKids = 0;
  int selectedPersonality = 0;
  int selectedMoney = 0;
  // int kids = 0;
  int selectedMerrageType = 0;
  String error_msg = "";
  String gender = "ذكر";

  late SubSpecification _selectedJobType;


  List<String> hairColor = ['اسود', 'اشقر', 'بني', 'ابيض'];
  List<String> hairtype = ['ناعم', 'خشن', 'متجعد'];
  List<String> skinColor = ['بيضاء', 'سمراء', 'سوداء', 'قمحي'];
  List<String> parentSkinColor = ['ابيض', 'اسمر', 'اسود'];
  List<String> experience = [
    'دكتوراة',
    'جامعي',
    'ابتدائي',
    'ثانوي',
    'متوسط',
    'غير متعلم',
    'دبلوم'
  ];
  List<String> jobType = [
    'موظف قطاعي حكومي',
    'موظف عسكري',
    'عاطل عن العمل',
    'موظف قطاع خاص',
    'أعمال حرة'
  ];
  List<String> jobTypeFemale = [
    'موظفة قطاعي حكومي',
    'موظفة عسكري',
    'عاطلة عن العمل',
    'موظفة قطاع خاص',
    'أعمال حرة'
  ];
  List<String> illnesstype = [
    'سليم من الأمراض',
    'من ذوي الاحتياجات الخاصة',
    'معي مرض مزمن'
  ];
  List<String> illnesstypeFemale = [
    'سليمة من الأمراض',
    'من ذوي الاحتياجات الخاصة',
    'معي مرض مزمن'
  ];
  List<String> MilirtyStatus = ['مطلقة بكر', 'مطلقة', 'أرملة', 'عزباء بكر'];
  List<String> MilirtyMaleStatus = ['أعزب', 'أرمل', 'مطلق', 'متزوج'];

  List<String> numberOfKids = [
    'بدون أطفال',
    'مع والدتهم',
    'معي أطفال',
    'معي أطفال وبعد الزواج مع والدتهم'
  ];
  List<String> numberOfKidsFemale = [
    'بدون أطفال',
    'مع والدهم',
    'معي أطفال',
    'معي أطفال وبعد الزواج مع والدهم'
  ];
  List<String> personality = ['وسيم', 'غير وسيم', 'مقبول الشكل'];
  List<String> personalityFemale = ['نوعا ما جميلة', 'متوسطة الجمال', 'جميلة'];

  List<String> money = [
    'ثري رجل أعمال',
    'ميسور الحال',
    'متوسط الثراء',
    'ضعف في القدرة المالية'
  ];
  List<String> moneyFemale = [
    'ثرية',
    'ميسورة الحال',
    'متوسطة الثراء',
    'ضعف في القدرة المالية'
  ];
  List<String> merrageType = ['تعدد', 'مسيار', 'علني'];
  
  
  

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterClientCubit(),
      child: BlocConsumer<RegisterClientCubit, RegisterClientStates>(
        listener: (context, state) { on_state_changed(context, state); },
        builder: (context, state) => BlocBuilder<AppCubit, AppStates>(
          builder: (context, state) => Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: backGround,
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formkey,                      
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        // Set the desired padding value for all children
                        // padding: EdgeInsets.symmetric(vertical: 40.2.h), 
                          children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: (){ Navigator.pop(context); },
                                child: Text("رجوع",
                                  style: TextStyle(color: white, fontSize: 12.sp),
                                ),
                              )
                            ]
                          ),
                          
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
                                  color: backGround,
                                ),
                                child: DropdownButton(
                                  underline: Text(" "),
                                  isExpanded: true,
                                  elevation: 10,
                                  iconDisabledColor: Colors.grey,
                                  iconEnabledColor: primary,
                                  icon: Padding(
                                    padding: EdgeInsetsDirectional.only(end: 2.w, top: 1.h),
                                    child: const Icon(Icons.arrow_circle_down_sharp),
                                  ),

                                  hint: Padding(
                                    padding: EdgeInsets.symmetric( horizontal: 2.w, vertical: 0.h),
                                    child: Text(
                                      gender,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ),
                                  items: <String>['انثي', 'ذكر'].map((String value) 
                                  {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      alignment: Alignment.centerRight,
                                      child: Material(
                                        elevation: 5,
                                        shadowColor: Colors.grey[400],
                                        child: Container(
                                            width: double.infinity,
                                            alignment: Alignment.centerRight,
                                            child: Text(value,
                                                textAlign: TextAlign.start)),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() { gender = newValue!; });
                                  },
                                ),
                              ),
                            ),

                          defaultTextFormField(
                            context: context,
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            // onchange: (v) => setState(() {  newUser.email = v;  }),
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                  return "من فضلك ادخل البريد الالكتروني";
                              }else if (!value.contains("@")) {
                                  return "من فضلك ادخل البريد الالكتروني بطريقة صحيحة";
                              }else{
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
                              // onchange: (v) => setState(() {  newUser.userName = v;  }),
                              type: TextInputType.text,
                              validate: (String? value) {
                                newUser.userName = value;
                                return (value!.isEmpty)? "من فضلك ادخل الاسم": null;
                              },
                              labelText: "الاسم",
                              label: "الرجاء ادخال اسمك",
                              prefixIcon: Icons.person_outline),

                          defaultTextFormField(
                              context: context,
                              controller: nationalIdController,
                              // onchange: (v) { 
                              //   setState(() {  newUser.nationalID = v;  }); 
                              //   return ; 
                              // },                            
                              type: TextInputType.number,
                              validate: (String? value) {
                                newUser.nationalID = value;
                                return (value!.isEmpty)? "من فضلك ادخل رقم الهوية": null;
                              },
                              labelText: "رقم الهوية",
                              label: "الرجاء ادخال رقم الهوية",
                              prefixIcon: Icons.person_outline),

                          defaultTextFormField(
                              context: context,
                              controller: cityController,
                              // onchange: (v) => setState(() {  newUser.city = v;  }),
                              type: TextInputType.text,
                              validate: (String? value) {
                                newUser.city = value;
                                return (value!.isEmpty)? "من فضلك ادخل المدينة": null;
                              },
                              labelText: "المدينة",
                              label: "الرجاء ادخال المدينة",
                              prefixIcon: Icons.person_outline),

                          defaultTextFormField(
                              context: context,
                              controller: nationalityController,
                              // onchange: (v) { 
                              //   setState(() {  newUser.nationality = v;  }); 
                              //   return ; 
                              // },
                              type: TextInputType.text,
                              validate: (String? value) {
                                newUser.nationality = value;
                                return (value!.isEmpty)?"من فضلك ادخل الجنسية": null;
                              },
                              labelText: "الجنسية",
                              label: "الرجاء ادخال الجنسية",
                              prefixIcon: Icons.person_outline
                          ),

                          Text(
                            "الاسم ينتهي",
                            style: TextStyle(color: white),
                          ),

                          RadioListTile<int>(
                                value: 0,
                                title: Text("قبيلة",
                                  style: TextStyle(color: white, fontSize: 12.sp),
                                ),
                                groupValue: selectedlastName,
                                activeColor: primary,
                                onChanged: (value) {
                                  setState(() { selectedlastName = 0; });
                                }), 

                          RadioListTile<int>(
                            value: 1,
                            title: Text("عائلة", 
                                style: TextStyle(color: white, fontSize: 12.sp),
                            ),
                            activeColor: primary,
                            groupValue: selectedlastName,
                            onChanged: (value) {
                              setState(() { selectedlastName = 1; });
                            }),

                          defaultTextFormField(
                                context: context,
                                controller: tribeController,
                                // onchange: (v) => setState(() {  newUser.tribe = v;  }),
                                type: TextInputType.text,
                                validate: (value) {
                                  newUser.tribe = value; 
                                  return null;
                                  // return (selectedlastName == 1 && value!.isEmpty) "من فضلك ادخل اسم العائلة": null;
                                },
                                labelText: "العائلة / القبيلة",
                                label: "ادخل اسم العائلة/القبيلة",
                                prefixIcon: Icons.person_outline,
                          ),
                                

                          defaultTextFormField(
                              context: context,
                              controller: phoneController,
                              // onchange: (v) => setState(() {  newUser.phone = v;  }),
                              type: TextInputType.number,
                              validate: (String? value) {
                                newUser.phone = value; 
                                return (value!.isEmpty)? "من فضلك ادخل الهاتف": null;
                              },
                              labelText: "رقم الهاتف",
                              label: "الرجاء ادخال رقم الهاتف",
                              prefixIcon: Icons.phone),

                          defaultTextFormField(
                              context: context,
                              controller: ageController,
                              // onchange: (v) => setState(() {  newUser.age = v;  }),
                              type: TextInputType.number,
                              validate: (String? value) {
                                newUser.age = value;
                                return (value!.isEmpty)? "من فضلك ادخل العمر": null;
                              },
                              labelText: "العمر",
                              //  labelTextcolor: white,
                              label: "الرجاء ادخال العمر",
                              prefixIcon: Icons.person_outline),


                          defaultTextFormField(
                              context: context,
                              controller: heightController,
                              // onchange: (v) => setState(() {  newUser.height = v;  }),
                              type: TextInputType.number,
                              validate: (String? value) {
                                newUser.height = value;
                                return (value!.isEmpty)?"من فضلك ادخل الطول": null;
                              },
                              labelText: "الطول",
                              label: "الرجاء ادخال الطول",
                              prefixIcon: Icons.person_outline),

                          defaultTextFormField(
                              context: context,
                              controller: weightController,
                              // onchange: (v) =>  setState(() {  newUser.weight = v;  }),
                              type: TextInputType.number,
                              validate: (String? value) {
                                newUser.weight = value;
                                return (value!.isEmpty)? "من فضلك ادخل الوزن": null;
                              },
                              labelText: "الوزن",
                              label: "الرجاء ادخال الوزن",
                              prefixIcon: Icons.person_outline),

                          Text("لون الشعر",
                            style: TextStyle(color: white, fontSize: 11.sp),
                          ),

                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount:
                                (MediaQuery.of(context).orientation == Orientation.landscape)? 4: 2,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 0.6 / 0.015.h,
                            children: List.generate( hairColor.length,
                                (index1) => RadioButtonRegister(
                                    isRegisterScreen: true,
                                    value: index1,
                                    groupvalue: selectedHairColorName,
                                    title: hairColor[index1],
                                    changeFunction: () {
                                      setState(() { selectedHairColorName = index1; });
                                      // print(hairColor[selectedHairColorName]);
                                    })
                                  ),
                          ),

                          Text("نوع الشعر",
                            style: TextStyle(color: white, fontSize: 11.sp),
                          ),

                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount:
                                (MediaQuery.of(context).orientation == Orientation.landscape)? 4: 2,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 0.6 / 0.015.h,
                            children: List.generate( hairtype.length,
                                (index1) => RadioButtonRegister(
                                    isRegisterScreen: true,
                                    value: index1,
                                    groupvalue: selectedHairTypeName,
                                    title: hairtype[index1],
                                    changeFunction: () {
                                      setState(() {
                                        selectedHairTypeName = index1;
                                      });
                                    })),
                          ),

                          Text("لون البشرة",
                            style: TextStyle(color: white, fontSize: 11.sp),
                          ),

                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount:
                                (MediaQuery.of(context).orientation == Orientation.landscape)? 4: 2,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 0.6 / 0.015.h,
                            children: List.generate( 3,
                                (index1) => RadioButtonRegister(
                                    isRegisterScreen: true,
                                    value: index1,
                                    groupvalue: selectedSkinColorName,
                                    title: skinColor[index1],
                                    changeFunction: () {
                                      setState(() {
                                        selectedSkinColorName = index1;
                                      });
                                    })),
                          ),

                          Text("من عرق",
                            style: TextStyle(color: white, fontSize: 11.sp),
                          ),

                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount:
                                (MediaQuery.of(context).orientation == Orientation.landscape)? 4: 2,
                            padding: EdgeInsets.all(0),
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 0.6 / 0.015.h,
                            children: List.generate( parentSkinColor.length,
                                (index1) => RadioButtonRegister(
                                    isRegisterScreen: true,
                                    value: index1,
                                    groupvalue: selectedParentSkinColorName,
                                    title: parentSkinColor[index1],
                                    changeFunction: () {
                                      setState(() { selectedParentSkinColorName = index1; });
                                    })),
                          ),

                          Text("الموهل العلمي",
                            style: TextStyle(color: white, fontSize: 11.sp),
                          ),

                          GridView.count(
                            shrinkWrap: true,
                            padding: EdgeInsets.all(0),
                            crossAxisCount:
                                (MediaQuery.of(context).orientation == Orientation.landscape)? 5: 3,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 0.6 / 0.025.h,
                            children: List.generate(
                                experience.length,
                                (index1) => RadioButtonRegister(
                                    isRegisterScreen: true,
                                    value: index1,
                                    groupvalue: selectedExperience,
                                    title: experience[index1],
                                    changeFunction: () {
                                      setState(() { selectedExperience = index1; });
                                    })),
                          ),

                          //TODO: fix eeee
                          //الوظيفة                          
                          Text(AppCubit.Specifications[SpecificationIDs.job]["nameAr"] + "eeeaaaaaaeeeeee",
                            style: TextStyle(color: white, fontSize: 11.sp),
                          ),

                          GridView.count(
                            shrinkWrap: true,
                            padding: EdgeInsets.all(0),
                            crossAxisCount:
                                (MediaQuery.of(context).orientation == Orientation.landscape)? 5: 2,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 0.6 / 0.02.h,
                            children: getListofRadioButtons(SpecificationIDs.job ), 
                          ),
         

                          // Text("الوظيفة",
                          //   style: TextStyle(color: white, fontSize: 11.sp),
                          // ),

                          // if (gender == "ذكر")
                          //   GridView.count(
                          //     shrinkWrap: true,
                          //     padding: EdgeInsets.all(0),
                          //     crossAxisCount:
                          //         (MediaQuery.of(context).orientation == Orientation.landscape)? 5: 2,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     childAspectRatio: 0.6 / 0.02.h,
                          //     children: List.generate(
                          //         jobType.length,
                          //         (i) => RadioButtonRegister(
                          //             isRegisterScreen: true,
                          //             value: i,
                          //             groupvalue: selectedJobType,
                          //             title: jobType[i] + selectedJobType.toString(),
                          //             changeFunction: () {
                          //               setState(() {
                          //                 selectedJobType = i;
                          //               });
                          //             })),
                          //   ),
                          // if (gender == "انثي")
                          //   GridView.count(
                          //     shrinkWrap: true,
                          //     padding: EdgeInsets.all(0),
                          //     crossAxisCount:
                          //         (MediaQuery.of(context).orientation == Orientation.landscape)? 5: 2,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     childAspectRatio: 0.6 / 0.02.h,
                          //     children: List.generate( jobTypeFemale.length,
                          //         (index1) => RadioButtonRegister(
                          //             isRegisterScreen: true,
                          //             value: index1,
                          //             groupvalue: selectedJobType,
                          //             title: jobTypeFemale[index1],
                          //             changeFunction: () { setState(() {
                          //                 selectedJobType = index1;
                          //               });
                          //             })),
                          //   ),
                          // defaultTextFormField(
                          //     context: context,
                          //     controller: nameOfJobController,
                          //     // onchange: (v) { 
                          //     //   setState(() {  newUser.nameOfJob = v;  }); 
                          //     //   return ; 
                          //     // },
                          //     type: TextInputType.text,
                          //     validate: (String? value) {
                          //       newUser.nameOfJob = value;
                          //       return null;
                          //     },
                          //     labelText: "اسم الوظيفة",
                          //     label: "الرجاء ادخال اسم الوظيفة (ان وجدت)",
                          //     prefixIcon: Icons.person),


                          //TODO: fix kkkkkkk
                          //الحالة الصحية
                          Text(AppCubit.Specifications[SpecificationIDs.health_status]["nameAr"] + "kkkkksssssskkkkkkkkk",
                            style: TextStyle(color: white, fontSize: 11.sp),
                          ),

                          GridView.count(
                            shrinkWrap: true,
                            padding: EdgeInsets.all(0),
                            crossAxisCount:
                                (MediaQuery.of(context).orientation == Orientation.landscape)? 5: 2,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 0.6 / 0.02.h,
                            children: getListofRadioButtons(SpecificationIDs.health_status), 
                          ),


                          // Text("الحالة الصحية",
                          //   style: TextStyle(color: white, fontSize: 14),
                          // ),

                          // if (gender == "ذكر")
                          //   GridView.count(
                          //     padding: EdgeInsets.all(0),
                          //     shrinkWrap: true,
                          //     crossAxisCount:
                          //         (MediaQuery.of(context).orientation == Orientation.landscape)? 5: 1,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     childAspectRatio: 0.8 / 0.01.h,
                          //     children: List.generate( illnesstype.length,
                          //         (i) => RadioButtonRegister(
                          //             isRegisterScreen: true,
                          //             value: i,
                          //             groupvalue: selectedIllnessType,
                          //             title: illnesstype[i],
                          //             changeFunction: () {
                          //               setState(() { selectedIllnessType = i; });
                          //             })),
                          //   ),
                          // if (gender == "انثي")
                          //   GridView.count(
                          //     padding: EdgeInsets.all(0),
                          //     shrinkWrap: true,
                          //     crossAxisCount:
                          //         (MediaQuery.of(context).orientation == Orientation.landscape)? 5: 1,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     childAspectRatio: 0.8 / 0.01.h,
                          //     children: List.generate( illnesstypeFemale.length,
                          //         (index1) => RadioButtonRegister(
                          //             isRegisterScreen: true,
                          //             value: index1,
                          //             groupvalue: selectedIllnessType,
                          //             title: illnesstypeFemale[index1],
                          //             changeFunction: () {
                          //               setState(() { selectedIllnessType = index1; });
                          //             })),
                          //   ),

                          defaultTextFormField(
                              context: context,
                              controller: illnessTypeController,
                              // onchange: (v) => setState(() {  
                              //   newUser.illnessType = v;  
                              // }),
                              type: TextInputType.text,
                              validate: (String? value) { 
                                newUser.illnessType = value;  
                                return null;
                              },
                              labelText: "نوع المرض",
                              label: "الرجاء ادخال نوع المرض (ان وجد)",
                              prefixIcon: Icons.person),

                          // Text("الحالة الاجتماعية",
                          //   style: TextStyle(color: white, fontSize: 14),
                          // ),

                          // if (gender == "ذكر")
                          //   GridView.count(
                          //     shrinkWrap: true,
                          //     crossAxisCount:
                          //         (MediaQuery.of(context).orientation == Orientation.landscape)? 5: 2,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     childAspectRatio: 0.8 / 0.02.h,

                          //     children: List.generate(
                          //         MilirtyMaleStatus.length,
                          //         (index1) => RadioButtonRegister(
                          //             isRegisterScreen: true,
                          //             value: index1,
                          //             groupvalue: selectedMiliirtyMaleType,
                          //             title: MilirtyMaleStatus[index1],
                          //             changeFunction: () {
                          //               setState(() { selectedMiliirtyMaleType = index1; });
                          //             })),
                          //   ),


                          
                          //الحالة الاجتماعية
                          Text(AppCubit.Specifications[SpecificationIDs.social_status]["nameAr"] ,
                            style: TextStyle(color: white, fontSize: 11.sp),
                          ),

                          GridView.count(
                            shrinkWrap: true,
                            padding: EdgeInsets.all(0),
                            crossAxisCount:
                                (MediaQuery.of(context).orientation == Orientation.landscape)? 5: 2,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 0.6 / 0.02.h,
                            children: getListofRadioButtons(SpecificationIDs.social_status), 
                          ),

                          // if (gender == "انثي")
                          //   GridView.count(
                          //     shrinkWrap: true,
                          //     padding: EdgeInsets.all(0),
                          //     crossAxisCount:
                          //         (MediaQuery.of(context).orientation == Orientation.landscape)? 5: 2,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     childAspectRatio: 0.8 / 0.02.h,
                          //     children: List.generate(
                          //         MilirtyStatus.length,
                          //         (index1) => RadioButtonRegister(
                          //             isRegisterScreen: true,
                          //             value: index1,
                          //             groupvalue: selectedMiliirtyType,
                          //             title: MilirtyStatus[index1],
                          //             changeFunction: () {
                          //               setState(() {
                          //                 selectedMiliirtyType = index1;
                          //               });
                          //             })),
                          //   ),

                          // Spacer(),
                          // Text("هل لديك اطفال",
                          //   style: TextStyle(color: white, fontSize: 11.sp),
                          // ),

                          // if (gender == "ذكر")
                          //   GridView.count(
                          //     shrinkWrap: true,
                          //     padding: EdgeInsets.all(0),
                          //     crossAxisCount:
                          //         (MediaQuery.of(context).orientation == Orientation.landscape)? 5: 1,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     mainAxisSpacing: .05,
                          //     childAspectRatio: 0.8 / 0.01.h,
                          //     children: List.generate(
                          //         numberOfKids.length,
                          //         (index1) => RadioButtonRegister(
                          //             isRegisterScreen: true,
                          //             value: index1,
                          //             groupvalue: selectedNumberOfKids,
                          //             title: numberOfKids[index1],
                          //             changeFunction: () {
                          //               setState(() { selectedNumberOfKids = index1; });
                          //             })),
                          //   ),

                          // if (gender == "انثي")
                          //   GridView.count(
                          //     shrinkWrap: true,
                          //     padding: EdgeInsets.all(0),
                          //     crossAxisCount:
                          //         (MediaQuery.of(context).orientation == Orientation.landscape)? 5: 1,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     mainAxisSpacing: .05,
                          //     childAspectRatio: 0.8 / 0.01.h,
                          //     children: List.generate(
                          //         numberOfKidsFemale.length,
                          //         (index1) => RadioButtonRegister(
                          //             isRegisterScreen: true,
                          //             value: index1,
                          //             groupvalue: selectedNumberOfKids,
                          //             title: numberOfKidsFemale[index1],
                          //             changeFunction: () {
                          //               setState(() { selectedNumberOfKids = index1; });
                          //             })),
                          //   ),

                          //هل لديك اطفال
                          Text(AppCubit.Specifications[SpecificationIDs.have_children]["nameAr"] + "CCCCCCCCCCcc",
                            style: TextStyle(color: white, fontSize: 11.sp),
                          ),

                          GridView.count(
                            shrinkWrap: true,
                            padding: EdgeInsets.all(0),
                            crossAxisCount:
                                (MediaQuery.of(context).orientation == Orientation.landscape)? 5: 1,
                            physics: const NeverScrollableScrollPhysics(),
                            mainAxisSpacing: .05,
                            childAspectRatio: 0.8 / 0.01.h,
                            children: getListofRadioButtons(SpecificationIDs.have_children), 
                          ),

                          defaultTextFormField(
                              context: context,
                              controller: numberOfKidsController,
                              // onchange: (v) => setState(() { newUser.numberOfKids = int.parse(v); }),
                              type: TextInputType.number,
                              validate: (String? value){
                                newUser.subSpecifications.forEach((e) { log("${e.id}, ${e.value} ");});
                                var no_kids = newUser.subSpecifications.any((sub) => sub.id == 77);
                                // 77 -> 'بدون أطفال'
                                if( no_kids ) {
                                  return null;
                                }else if(value!.isEmpty){
                                  return "من فضلك اكتب عدد الاطفال";
                                }
                                newUser.numberOfKids = int.parse(numberOfKidsController.text);
                                return null;

                              },
                              labelText: "عدد الاطفال",
                              label: "الرجاء ادخال عدد الاطفال (ان وجد)",
                              prefixIcon: Icons.person),

                          Text("نبذة عن مظهرك",
                            style: TextStyle(color: white, fontSize: 11.sp),
                          ),
                          if (gender == "ذكر")
                            GridView.count(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(0),
                              crossAxisCount:
                                  (MediaQuery.of(context).orientation == Orientation.landscape)? 5: 2,
                              physics: const NeverScrollableScrollPhysics(),
                              childAspectRatio: 0.8 / 0.02.h,
                              children: List.generate(
                                  personality.length,
                                  (index1) => RadioButtonRegister(
                                      isRegisterScreen: true,
                                      value: index1,
                                      groupvalue: selectedPersonality,
                                      title: personality[index1],
                                      changeFunction: () {
                                        setState(() { selectedPersonality = index1; });
                                      })),
                            ),
                          if (gender == "انثي")
                            GridView.count(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(0),
                              crossAxisCount:
                                  (MediaQuery.of(context).orientation == Orientation.landscape)? 5: 2,
                              physics: const NeverScrollableScrollPhysics(),
                              childAspectRatio: 0.8 / 0.02.h,
                              children: List.generate(
                                personalityFemale.length,
                                (index1) => RadioButtonRegister(
                                    isRegisterScreen: true,
                                    value: index1,
                                    groupvalue: selectedPersonality,
                                    title: personalityFemale[index1],
                                    changeFunction: () {
                                      setState( (){selectedPersonality = index1;} );
                                    }
                                )
                              ),
                            ),

                          Text(
                            "الوضع المالي",
                            style: TextStyle(color: white, fontSize: 11.sp),
                          ),

                          if (gender == "ذكر")
                            GridView.count(
                              shrinkWrap: true,
                              padding: EdgeInsets.all(0),
                              crossAxisCount:
                                  (MediaQuery.of(context).orientation == Orientation.landscape)? 5: 2,
                              physics: const NeverScrollableScrollPhysics(),
                              childAspectRatio: 0.8 / 0.02.h,
                              children: List.generate(
                                  money.length,
                                  (index1) => RadioButtonRegister(
                                      isRegisterScreen: true,
                                      value: index1,
                                      groupvalue: selectedMoney,
                                      title: money[index1],
                                      changeFunction: () {
                                        setState(() { selectedMoney = index1; });
                                      })),
                            ),

                          if (gender == "انثي")
                            GridView.count(
                              shrinkWrap: true,
                              padding: EdgeInsets.all(0),
                              crossAxisCount:
                                  (MediaQuery.of(context).orientation == Orientation.landscape)? 5: 2,
                              physics: const NeverScrollableScrollPhysics(),
                              childAspectRatio: 0.8 / 0.02.h,
                              children: List.generate(
                                  moneyFemale.length,
                                  (index1) => RadioButtonRegister(
                                      isRegisterScreen: true,
                                      value: index1,
                                      groupvalue: selectedMoney,
                                      title: moneyFemale[index1],
                                      changeFunction: () {
                                        setState(() { selectedMoney = index1; });
                                      })),
                            ),

                          Text("نوع الزواج",
                            style: TextStyle(color: white, fontSize: 11.sp),
                          ),
                          GridView.count(
                            shrinkWrap: true,
                            padding: EdgeInsets.all(0),
                            crossAxisCount:
                                (MediaQuery.of(context).orientation ==Orientation.landscape)? 5: 2,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 0.8 / 0.02.h,
                            children: List.generate(
                                merrageType.length,
                                (index1) => RadioButtonRegister(
                                    isRegisterScreen: true,
                                    value: index1,
                                    groupvalue: selectedMerrageType,
                                    title: merrageType[index1],
                                    changeFunction: () {
                                      setState(() { selectedMerrageType = index1; });
                                    })),
                          ),

                          defaultTextFormField(
                              context: context,
                              labelText: "قيمة المهر",
                              controller: dowryController,
                              // onchange: (v) => setState(() {  newUser.dowry = v;  }),
                              type: TextInputType.number,
                              validate: (String? value) {
                                newUser.dowry = value;
                                return (value!.isEmpty)? "من فضلك ادخل المهر": null;
                              },
                              label: "قيمة المهر(0 الي 100 الف)",
                              prefixIcon: Icons.person),

                          TextFormField(
                            controller: termsController,
                            // onChanged: (v) => setState(() {  newUser.terms = v;  }),
                            validator: (String? value) {
                              newUser.terms = value;
                              return (value!.isEmpty)? "من فضلك ادخل شروطك": null;
                            },
                            decoration: InputDecoration(
                              hintText: "شروطك",
                              hintStyle: TextStyle(color: white, fontSize: 12),
                              hintMaxLines: 5,
                              enabled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide( width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              filled: true,
                              fillColor: backGround,
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: 3,
                            minLines: 1,
                            style: TextStyle(color: white),
                          ),

                          defaultTextFormField(
                            context: context,
                            controller: passwordController,
                            // onchange: (val) => setState( () =>  newUser.password = val ),
                            type: TextInputType.text,
                            validate: (String? value) {
                              //TODO: change apssword length to 7
                              if (value!.isEmpty) {
                                return "من فضلك ادخل كلمة السر";
                              }else if (value.length < 3) {
                                return " من فضلك ادخل كلمة مرور لا تقل عن 7 حروف";                                
                              }else{
                                newUser.password = value;
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
                              if (newUser.password != val) {
                                return "كلمة السر و تاكيد كلمة السر غير متطابقان";
                              }else if (val!.isEmpty) {
                                return "من فضلك ادخل تاكيد كلمة السر";
                              }else{
                                newUser.password = val;
                                return null;
                              }
                            },
                            labelText: "تاكيد كلمة السر",
                            label: "تاكيد كلمة السر",
                            prefixIcon: Icons.lock_outline_rounded,
                          ),

                          CheckedBoxRegister(
                              onchanged: () {
                                setState(() { isDataConfirmed = !isDataConfirmed; });
                              },
                              text: "اقسم بالله ان المعلومات التي قمت بادخلها صحيحة و التطبيق غير مسئول عن اي معلومات اخري غير صحيحة",
                              isSelected: isDataConfirmed,
                              focusColor: primary,
                              TextColor: white),

                          Row(
                            children: [
                              Checkbox(
                                  value: isTermsConfirmed,
                                  onChanged: (bool? value) {
                                    setState(() { isTermsConfirmed = !isTermsConfirmed; });
                                  },
                                  focusColor: primary,
                                  autofocus: true,
                              ),
                              Text("اوافق علي  ",
                                  style: TextStyle( color: primary, fontSize: 10.sp)),
                              InkWell(
                                child: Text("الشروط و الاحكام",
                                    style: TextStyle(
                                        color: primary,
                                        fontSize: 10.sp,
                                        decoration: TextDecoration.underline)),
                                onTap: () {
                                  Navigator.push( context,
                                      MaterialPageRoute( builder: (context) => TermsScreen()));
                                },
                              )
                            ],
                          ),

                          doubleInfinityMaterialButton(
                              text: "تسجيل",
                              onPressed: () { registeNewUser(context); }),

                          SizedBox(
                            child: isLoading ? CircularProgressIndicator() : SizedBox(),
                          ),
                          SizedBox(
                            height: 2.5.h,
                            child: Text(
                              error_msg, 
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            
                          ),

                          //TODO: remove Delegate
                          const AlreadyHaveAccountText(),

                        ], ),

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

  void on_state_changed(BuildContext context, RegisterClientStates state){}

  void handleResponse(ServerResponse response)
  {
    if(response.key == 1) 
    {
      showToast(msg: "تم التسجيل بنجاح", state: ToastStates.SUCCESS);
      // TODO: uncomment show LayoutLinkPerson
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const LayoutLinkPerson() ), 
      //   (route) => false,
      // );

      // TODO: uncomment all clear lines.
      // nameController.clear();
      // cityController.clear();
      // nationalityController.clear();
      // ageController.clear();
      // lastNameFamilyController.clear();
      // heightController.clear();
      // weightController.clear();
      // jobNameController.clear();
      // illnessTypeController.clear();
      // numberOfKidsController.clear();
      // monyOfPony.clear();
      // conditionsController.clear();
    }else{

      showToast(
          msg: response.msg!,
          state: ToastStates.ERROR);
    }
  }

  void registeNewUser(BuildContext context)
  {

    if( !formkey.currentState!.validate() ){
      showToast(msg: "بعض المدخلات غير صحيحة!!", state: ToastStates.ERROR);
      return;
    }

    setState(() {
      isLoading = true;
    });
    // emit( RegisterClientLoadingState() );
    
    // var json_str_newUser = json.encode(newUser);
    // var json_obj_newUser = json.decode(json_str_newUser);

    DioHelper.postData(
      url: REGISTERCLIENT, 
      data: newUser.toMap()
    )
    .then((value) {
      print('************--------------------------********************');
      print(value.toString());
      ServerResponse response = ServerResponse.fromJson(value.data);
      handleResponse(response);

      setState(() {
        isLoading = false;
      });

    }).catchError((error) {
      print('xxxxxxxxxxxxxxx+++++++++++++++++++++++++++++++++xxxxxxxxxxxxxxxxxxxxxxxxx');
      ServerResponse response = new ServerResponse(0, error.message);
      handleResponse(response);
      // emit( RegisterClientErrorState(error.toString()) );
      setState(() {
        isLoading = false;
      });
    });


  }
  
  List<Widget> getListofRadioButtons(int specificationId) 
  {
    var Spec = AppCubit.Specifications[ specificationId ];

    if(Spec == null)
      return [Text("No Elements")];

    List<Widget> radios = [];
    Spec["subSpecifications"].forEach((sub_id, sub) 
    {
      SubSpecification found_or_created;
      found_or_created = newUser.subSpecifications
                      .firstWhere( (user_sub) => user_sub.specId == sub["specificationId"],
                      orElse: () {
                        var new_sub = new SubSpecification(sub["id"], sub["nameAr"], Spec["id"], Spec["nameAr"]);
                        newUser.subSpecifications.add( new_sub );
                        return new_sub;
                      });

      radios.add(
        RadioButtonRegister(
          isRegisterScreen: true,
          value: sub["id"],
          groupvalue: found_or_created.id, 
          title: sub["nameAr"] ,
          changeFunction: () {
            setState(() {
              found_or_created.id = sub["id"];
              found_or_created.value = sub["nameAr"];
              found_or_created.specId = Spec["id"];
              found_or_created.name = Spec["nameAr"];
            });
          })
      );      
    });
    return radios;
  }

  // void registeNewUserXX(BuildContext context)
  // {
  //   if( !termsSelected || !isSelected2)
  //   {
  //     showToast(
  //       msg: "لكي تتم عملية التسجيل: من فضلك قم بالموافقة على الشروط واقسم بأن المعلومات التي أدخلتها صحيحة ", 
  //       state: ToastStates.ERROR);
  //   }
    
  //   if(formkey.currentState!.validate()) 
  //   {                                  
  //     if(gender == "ذكر") 
  //     {
  //       RegisterClientCubit.get(context).specifications = [
  //         selectedlastName == 0 ? "قبيلة" : "عائلة",
  //         hairColor[selectedHairColorName!],
  //         hairtype[selectedHairTypeName],
  //         skinColor[selectedSkinColorName],
  //         parentSkinColor[selectedParentSkinColorName],
  //         experience[selectedExperience],
  //         jobType[selectedJobType],
  //         illnesstype[selectedIllnessType],
  //         gender == "انثي"
  //             ? MilirtyStatus[selectedMiliirtyType]
  //             : MilirtyMaleStatus[selectedMiliirtyMaleType],
  //         numberOfKids[selectedNumberOfKids],
  //         personality[selectedPersonality],
  //         money[selectedMoney],
  //         merrageType[selectedMerrageType]
  //       ];

  
  //       RegisterClientCubit.get(context).convert();

  //       if (formkey.currentState!.validate()) {
  //         RegisterClientCubit.get(context).RegisterClient(
  //           childrensNumber: kids,
  //           kindOfSick: illnessTypeController.text,
  //           tribe: lastNameNotFamilyController != null
  //               ? lastNameNotFamilyController.text
  //               : lastNameFamilyController.text,
  //           nameOfJob: jobNameController.text,
  //           specialNeeds: selectedIllnessType == 2 ?true: false,
  //           gender: gender == "ذكر" ? "1" : "2",
  //           name: nameController.text,
  //           email: emailController.text,
  //           age: ageController.text,
  //           nationality: nationalityController.text,
  //           natonalityId: personalCardController.text,
  //           city: cityController.text,
  //           password: passwordController.text,
  //           phone: phoneController.text,
  //           height: heightController.text,
  //           width: weightController.text,
  //           dowry: monyOfPony.text,
  //           // delegateId: widget.delegateId,
  //           terms: conditionsController.text);
  //       }
  //     }
  //     if (gender == "انثي") 
  //     {
  //       RegisterClientCubit.get(context).specifications = [
  //         selectedlastName == 0 ? "قبيلة" : "عائلة",
  //         hairColor[selectedHairColorName],
  //         hairtype[selectedHairTypeName],
  //         skinColor[selectedSkinColorName],
  //         parentSkinColor[selectedParentSkinColorName],
  //         experience[selectedExperience],
  //         jobTypeFemale[selectedJobType],
  //         illnesstypeFemale[selectedIllnessType],
  //         gender == "انثي"
  //             ? MilirtyStatus[selectedMiliirtyType]
  //             : MilirtyMaleStatus[selectedMiliirtyMaleType],
  //         numberOfKidsFemale[selectedNumberOfKids],
  //         personalityFemale[selectedPersonality],
  //         moneyFemale[selectedMoney],
  //         merrageType[selectedMerrageType]
  //       ];
  //       RegisterClientCubit.get(context).convert();

  //       if (formkey.currentState!.validate()) {
  //         RegisterClientCubit.get(context)
  //             .RegisterClient(
  //                 childrensNumber: kids,
  //                 kindOfSick: illnessTypeController.text,
  //                 tribe: lastNameNotFamilyController != null? 
  //                   lastNameNotFamilyController.text: 
  //                   lastNameFamilyController.text,
  //                 nameOfJob: jobNameController.text,
  //                 specialNeeds: selectedIllnessType == 2? true: false,
  //                 gender: gender == "ذكر" ? "1" : "2",
  //                 name: nameController.text,
  //                 email: emailController.text,
  //                 age: ageController.text,
  //                 nationality: nationalityController.text,
  //                 natonalityId: personalCardController.text,
  //                 city: cityController.text,
  //                 password: passwordController.text,
  //                 phone: phoneController.text,
  //                 height: heightController.text,
  //                 width: weightController.text,
  //                 dowry: monyOfPony.text,
  //                 terms: conditionsController.text);
  //       }
  //     }
  // Navigator.push(context, MaterialPageRoute(builder: (context)=>VerificationPhone()));
  //   }else{
  //     showToast(msg: "بعض المدخلات غير صحيحة!!", state: ToastStates.ERROR);
  //   }
  // }

} //end class
