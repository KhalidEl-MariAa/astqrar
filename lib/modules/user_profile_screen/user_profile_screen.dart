import 'dart:developer';

import 'package:astarar/layout/layout.dart';
import 'package:astarar/modules/change_password/change_password.dart';
import 'package:astarar/modules/user_profile_screen/cubit/cubit.dart';
import 'package:astarar/modules/user_profile_screen/cubit/states.dart';
import 'package:astarar/shared/components/components.dart';
import 'package:astarar/shared/components/loading_gif.dart';
import 'package:astarar/shared/components/logo/normal_logo.dart';
import 'package:astarar/shared/components/user/register/radiobuttonregister.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  UserProfileScreenState createState() => UserProfileScreenState();
}

var lastNameFamilyController = TextEditingController();
var lastNameNotFamilyController = TextEditingController();

var jobNameController = TextEditingController();
var illnessTypeController = TextEditingController();
var numberOfKidsController = TextEditingController();

int selectedlastName = 0;

String gender = "ذكر";
var formkey = GlobalKey<FormState>();

class UserProfileScreenState extends State<UserProfileScreen> {
  static var emailController = TextEditingController();
  static var nameController = TextEditingController();
  static var personalCardController = TextEditingController();
  static var cityController = TextEditingController();
  static var ageController = TextEditingController();
  static var phoneController = TextEditingController();
  static var weightController = TextEditingController();
  static var heightController = TextEditingController();
  static var nationalityController = TextEditingController();
  static var monyOfPony = TextEditingController();
  static var conditionsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserProfileCubit()..getUserData(),
      child: BlocConsumer<UserProfileCubit, UserProfileStates>(
        listener: (context, state) {
          if (state is UpdateUserDataSucccessState) {
            if (state.updateProfileModel.key == 1) {
              showToast(
                  msg: "تم تحديث البيانات بنجاح", state: ToastStates.SUCCESS);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false);
            } else {
              showToast(msg: "حدث خطا ما", state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) => ConditionalBuilder(
          condition: UserProfileCubit.get(context).getUserDataDone,
          fallback: (context) => Scaffold(
            backgroundColor: white,
              body:
              const LoadingGif()),
          builder: (context) => Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              // backgroundColor: backGround,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(11.h),
                child: NormalLogo(appbarTitle: "الملف الشخصي",isBack: true),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //    const HeaderLogo(),
                        SizedBox(
                          height: 4.h,
                        ),

                        SizedBox(
                          height: 1.5.h,
                        ),
                        defaultTextFormField(
                            context: context,
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "من فضلك ادخل البريد الالكتروني";
                              }
                              if (!value!.contains("@gmail.com")) {
                                return "من فضلك ادخل البريد الالكتروني بطريقة صحيحة";
                              }
                            },
                            labelText: "البريد الالكتروني",
                            //  labelTextcolor: white,
                            container: Colors.grey[100],
                            styleText: Colors.black,
                            borderColor: primary,
                            label: "الرجاء ادخال البريد الالكتروني",
                            prefixIcon: Icons.email_outlined),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        defaultTextFormField(
                            context: context,
                            container: Colors.grey[100],
                            styleText: Colors.black,
                            borderColor: primary,
                            controller: nameController,
                            //   labelTextcolor: white,
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
                          height: 1.5.h,
                        ),
                        defaultTextFormField(
                            context: context,
                            controller: cityController,
                            type: TextInputType.text,
                            container: Colors.grey[100],
                            styleText: Colors.black,
                            borderColor: primary,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "من فضلك ادخل المدينة";
                              }
                            },
                            labelText: "المدينة",
                            label: "الرجاء ادخال المدينة",
                            //labelTextcolor: white,
                            prefixIcon: Icons.person_outline),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        defaultTextFormField(
                            context: context,
                            container: Colors.grey[100],
                            styleText: Colors.black,
                            borderColor: primary,
                            controller: nationalityController,
                            type: TextInputType.text,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "من فضلك ادخل الجنسية";
                              }
                            },
                            labelText: "الجنسية",
                            //labelTextcolor: white,
                            label: "الرجاء ادخال الجنسية",
                            prefixIcon: Icons.person_outline),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          "الاسم ينتهي",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        Transform.scale(
                          scale: 0.8,
                          child: RadioListTile<int>(
                              value: 0,
                              activeColor: primary,
                              secondary: Container(
                                width: 45.w,
                                child: defaultTextFormField(
                                    context: context,
                                    container: Colors.grey[100],
                                    styleText: Colors.black,
                                    borderColor: primary,
                                    controller: lastNameNotFamilyController,
                                    type: TextInputType.text,
                                    labelTextcolor: Colors.black,
                                    validate: (value) {
                                     /* if (selectedlastName == 0 &&
                                          value!.isEmpty) {
                                        return "من فضلك ادخل اسم القبيلة";
                                      }*/
                                    },
                                    label: "ادخل اسم"),
                              ),
                              title: Text(
                                "قبيلة",
                                style: TextStyle(color: black, fontSize: 12.sp),
                              ),
                              groupValue: selectedlastName,
                              onChanged: (value) {
                                setState(() {
                                  selectedlastName = 0;
                                });
                              }),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Transform.scale(
                          scale: 0.8,
                          child: RadioListTile<int>(
                              value: 1,
                              activeColor: primary,
                              secondary: Container(
                                width: 45.w,
                                child: defaultTextFormField(
                                    context: context,
                                    controller: lastNameFamilyController,
                                    type: TextInputType.text,
                                    validate: (value) {
                                   /*   if (selectedlastName == 1 &&
                                          value!.isEmpty) {
                                        return "من فضلك ادخل اسم العائلة";
                                      }*/
                                    },
                                    container: Colors.grey[100],
                                    styleText: Colors.black,
                                    borderColor: primary,
                                    label: "ادخل اسم",
                                    labelTextcolor: white),
                              ),
                              title: Text(
                                "عائلة",
                                style: TextStyle(color: black, fontSize: 12.sp),
                              ),
                              groupValue: selectedlastName,
                              onChanged: (value) {
                                setState(() {
                                  selectedlastName = 1;
                                });
                              }),
                        ),
                        /*   SizedBox(
                          height: 1.5.h,
                        ),
                        defaultTextFormField(
                            context: context,
                            controller: phoneController,
                            type: TextInputType.number,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "من فضلك ادخل الهاتف";
                              }
                            },
                            container: Colors.grey[100],
                            styleText: Colors.black,
                            borderColor: primary,
                            labelText: "رقم الهاتف",
                            //  labelTextcolor: white,
                            label: "الرجاء ادخال رقم الهاتف",
                            prefixIcon: Icons.phone),*/
                        SizedBox(
                          height: 1.5.h,
                        ),
                        defaultTextFormField(
                            context: context,
                            container: Colors.grey[100],
                            styleText: Colors.black,
                            borderColor: primary,
                            controller: ageController,
                            type: TextInputType.number,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "من فضلك ادخل العمر";
                              }
                            },
                            labelText: "العمر",
                            //  labelTextcolor: white,
                            label: "الرجاء ادخال العمر",
                            prefixIcon: Icons.person_outline),
                        SizedBox(
                          height: 1.5.h,
                        ),

                        /*      defaultTextFormField(
                                context: context,
                                controller: ageController,
                                type: TextInputType.number,
                                validate: (String? value) {},
                                labelText: "العمر",
                                label: "الرجاء ادخال العمر",
                                //labelTextcolor: white,
                                prefixIcon: Icons.person_outline),
                            SizedBox(height: 1.5.h,),
*/
                        defaultTextFormField(
                            context: context,
                            container: Colors.grey[100],
                            styleText: Colors.black,
                            borderColor: primary,
                            controller: heightController,
                            type: TextInputType.number,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "من فضلك ادخل الطول";
                              }
                            },
                            labelText: "الطول",
                            label: "الرجاء ادخال الطول",
                            // labelTextcolor: white,
                            prefixIcon: Icons.person_outline),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        defaultTextFormField(
                            context: context,
                            container: Colors.grey[100],
                            styleText: Colors.black,
                            borderColor: primary,
                            controller: weightController,
                            type: TextInputType.number,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "من فضلك ادخل الوزن";
                              }
                            },
                            labelText: "الوزن",
                            label: "الرجاء ادخال الوزن",
                            //   labelTextcolor: white,
                            prefixIcon: Icons.person_outline),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          "لون الشعر",
                          style: TextStyle(color: black, fontSize: 12.sp),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: (MediaQuery.of(context).orientation ==
                                  Orientation.landscape)
                              ? 4
                              : 2,
                          physics: const NeverScrollableScrollPhysics(),
                          // crossAxisCount: 2,
                          //  crossAxisSpacing: 0.0,
                          padding: const EdgeInsets.all(0),
                          mainAxisSpacing: 5,
                          childAspectRatio: 0.6 / 0.1,
                          children: List.generate(
                              4,
                              (index1) => RadioButtonRegister(
                                  isRegisterScreen: false,
                                  value: index1,
                                  groupvalue: UserProfileCubit.get(context)
                                      .hairColorint!,
                                  title: UserProfileCubit.get(context)
                                      .hairColor[index1],
                                  changeFunction: () {
                                    setState(() {
                                      UserProfileCubit.get(context)
                                          .hairColorint = index1;
                                    });
                                  })),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          "نوع الشعر",
                          style: TextStyle(color: black, fontSize: 14),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: (MediaQuery.of(context).orientation ==
                                  Orientation.landscape)
                              ? 4
                              : 2,
                          physics: const NeverScrollableScrollPhysics(),
                          // crossAxisCount: 2,
                          //  crossAxisSpacing: 0.0,

                          //    mainAxisSpacing: .0,
                          padding: const EdgeInsets.all(0),
                          childAspectRatio: 0.6 / 0.1,
                          children: List.generate(
                              3,
                              (index1) => RadioButtonRegister(
                                  isRegisterScreen: false,
                                  value: index1,
                                  groupvalue: UserProfileCubit.get(context)
                                      .hairTypeint!,
                                  title: UserProfileCubit.get(context)
                                      .hairtype[index1],
                                  changeFunction: () {
                                    setState(() {
                                      UserProfileCubit.get(context)
                                          .hairTypeint = index1;
                                      log(
                                        UserProfileCubit.get(context)
                                            .hairtype[index1],
                                      );
                                    });
                                  })),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          "لون البشرة",
                          style: TextStyle(color: black, fontSize: 14),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: (MediaQuery.of(context).orientation ==
                                  Orientation.landscape)
                              ? 4
                              : 2,
                          physics: const NeverScrollableScrollPhysics(),
                          // crossAxisCount: 2,
                          //  crossAxisSpacing: 0.0,
                          padding: const EdgeInsets.all(0),

                          //    mainAxisSpacing: .0,
                          childAspectRatio: 0.6 / 0.1,
                          children: List.generate(
                              3,
                              (index1) => RadioButtonRegister(
                                  isRegisterScreen: false,
                                  value: index1,
                                  groupvalue: UserProfileCubit.get(context)
                                      .skinColorint!,
                                  title: UserProfileCubit.get(context)
                                      .skinColor[index1],
                                  changeFunction: () {
                                    setState(() {
                                      UserProfileCubit.get(context)
                                          .skinColorint = index1;
                                    });
                                  })),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          "من عرق",
                          style: TextStyle(color: black, fontSize: 14),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: (MediaQuery.of(context).orientation ==
                                  Orientation.landscape)
                              ? 4
                              : 2,
                          padding: const EdgeInsets.all(0),
                          physics: const NeverScrollableScrollPhysics(),
                          // crossAxisCount: 2,
                          //  crossAxisSpacing: 0.0,

                          //    mainAxisSpacing: .0,
                          childAspectRatio: 0.6 / 0.1,
                          children: List.generate(
                              3,
                              (index1) => RadioButtonRegister(
                                  isRegisterScreen: false,
                                  value: index1,
                                  groupvalue: UserProfileCubit.get(context)
                                      .parentSkinColorint!,
                                  title: UserProfileCubit.get(context)
                                      .parentSkinColor[index1],
                                  changeFunction: () {
                                    setState(() {
                                      UserProfileCubit.get(context)
                                          .parentSkinColorint = index1;
                                    });
                                  })),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          "الموهل العلمي",
                          style: TextStyle(color: black, fontSize: 14),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(0),
                          crossAxisCount: (MediaQuery.of(context).orientation ==
                                  Orientation.landscape)
                              ? 5
                              : 3,
                          physics: const NeverScrollableScrollPhysics(),
                          // crossAxisCount: 2,
                          //  crossAxisSpacing: 0.0,

                          //    mainAxisSpacing: .0,
                          childAspectRatio: 0.6 / 0.19,
                          children: List.generate(
                              UserProfileCubit.get(context)
                                  .experience.length ,
                              (index1) => RadioButtonRegister(
                                  isRegisterScreen: false,
                                  value: index1,
                                  groupvalue: UserProfileCubit.get(context)
                                      .experienceint!,
                                  title: UserProfileCubit.get(context)
                                      .experience[index1],
                                  changeFunction: () {
                                    setState(() {
                                      UserProfileCubit.get(context)
                                          .experienceint = index1;
                                    });
                                  })),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          "الوظيفة",
                          style: TextStyle(color: black, fontSize: 14),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        if (UserProfileCubit.get(context).genderUser == 1)
                          GridView.count(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0),
                            crossAxisCount:
                                (MediaQuery.of(context).orientation ==
                                        Orientation.landscape)
                                    ? 5
                                    : 2,
                            physics: const NeverScrollableScrollPhysics(),
                            // crossAxisCount: 2,
                            //  crossAxisSpacing: 0.0,

                            //    mainAxisSpacing: .0,
                            childAspectRatio: 0.6 / 0.19,
                            children: List.generate(
                                5,
                                (index1) => RadioButtonRegister(
                                    isRegisterScreen: false,
                                    value: index1,
                                    groupvalue: UserProfileCubit.get(context)
                                        .jopTypeint!,
                                    title: UserProfileCubit.get(context)
                                        .jobType[index1],
                                    changeFunction: () {
                                      setState(() {
                                        UserProfileCubit.get(context)
                                            .jopTypeint = index1;
                                      });
                                    })),
                          ),
                        if (UserProfileCubit.get(context).genderUser == 2)
                          GridView.count(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0),
                            crossAxisCount:
                                (MediaQuery.of(context).orientation ==
                                        Orientation.landscape)
                                    ? 5
                                    : 2,
                            physics: const NeverScrollableScrollPhysics(),
                            // crossAxisCount: 2,
                            //  crossAxisSpacing: 0.0,

                            //    mainAxisSpacing: .0,
                            childAspectRatio: 0.6 / 0.19,
                            children: List.generate(
                                5,
                                (index1) => RadioButtonRegister(
                                    isRegisterScreen: false,
                                    value: index1,
                                    groupvalue: UserProfileCubit.get(context)
                                        .jopTypeFemaleint!,
                                    title: UserProfileCubit.get(context)
                                        .jobTypeFemale[index1],
                                    changeFunction: () {
                                      setState(() {
                                        UserProfileCubit.get(context)
                                            .jopTypeFemaleint = index1;
                                      });
                                    })),
                          ),
                        defaultTextFormField(
                            context: context,
                            controller: jobNameController,
                            type: TextInputType.number,
                            validate: (String? value) {},
                            container: Colors.grey[100],
                            styleText: Colors.black,
                            borderColor: primary,
                            labelText: "اسم الوظيفة",
                            //  labelTextcolor: white,
                            label: "الرجاء ادخال اسم الوظيفة (ان وجدت)",
                            prefixIcon: Icons.person),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          "الحالة الصحية",
                          style: TextStyle(color: black, fontSize: 14),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        if (UserProfileCubit.get(context).genderUser == 1)
                          GridView.count(
                            padding: const EdgeInsets.all(0),
                            shrinkWrap: true,
                            crossAxisCount:
                                (MediaQuery.of(context).orientation ==
                                        Orientation.landscape)
                                    ? 5
                                    : 1,
                            physics: const NeverScrollableScrollPhysics(),
                            // crossAxisCount: 2,
                            //  crossAxisSpacing: 0.0,

                            //    mainAxisSpacing: .0,
                            childAspectRatio: 0.9 / 0.1,
                            children: List.generate(
                                3,
                                (index1) => RadioButtonRegister(
                                    isRegisterScreen: false,
                                    value: index1,
                                    groupvalue: UserProfileCubit.get(context)
                                        .illnessTypeint!,
                                    title: UserProfileCubit.get(context)
                                        .illnesstype[index1],
                                    changeFunction: () {
                                      setState(() {
                                        UserProfileCubit.get(context)
                                            .illnessTypeint = index1;
                                      });
                                    })),
                          ),
                        if (UserProfileCubit.get(context).genderUser == 2)
                          GridView.count(
                            padding: const EdgeInsets.all(0),
                            shrinkWrap: true,
                            crossAxisCount:
                                (MediaQuery.of(context).orientation ==
                                        Orientation.landscape)
                                    ? 5
                                    : 1,
                            physics: const NeverScrollableScrollPhysics(),
                            // crossAxisCount: 2,
                            //  crossAxisSpacing: 0.0,

                            //    mainAxisSpacing: .0,
                            childAspectRatio: 0.9 / 0.1,
                            children: List.generate(
                                3,
                                (index1) => RadioButtonRegister(
                                    isRegisterScreen: false,
                                    value: index1,
                                    groupvalue: UserProfileCubit.get(context)
                                        .illnessTypeFemaleint!,
                                    title: UserProfileCubit.get(context)
                                        .illnesstypeFemale[index1],
                                    changeFunction: () {
                                      setState(() {
                                        UserProfileCubit.get(context)
                                            .illnessTypeFemaleint= index1;
                                      });
                                    })),
                          ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        defaultTextFormField(
                            context: context,
                            controller: illnessTypeController,
                            container: Colors.grey[100],
                            styleText: Colors.black,
                            borderColor: primary,
                            type: TextInputType.number,
                            validate: (String? value) {},
                            labelText: "نوع المرض",
                            //  labelTextcolor: white,
                            label: "الرجاء ادخال نوع المرض (ان وجد)",
                            prefixIcon: Icons.person),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          "الحالة الاجتماعية",
                          style: TextStyle(color: black, fontSize: 14),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        if (UserProfileCubit.get(context)
                                .getUserDataModel
                                .data!
                                .gender ==
                            1)
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount:
                                (MediaQuery.of(context).orientation ==
                                        Orientation.landscape)
                                    ? 5
                                    : 2,
                            physics: const NeverScrollableScrollPhysics(),
                            // crossAxisCount: 2,
                            //  crossAxisSpacing: 0.0,
                            padding: const EdgeInsets.all(0),
                            //    mainAxisSpacing: .0,
                            childAspectRatio: 0.8 / 0.15,

                            children: List.generate(
                                4,
                                (index1) => RadioButtonRegister(
                                    isRegisterScreen: false,
                                    value: index1,
                                    groupvalue: UserProfileCubit.get(context)
                                        .MilirtyMaleStatusint!,
                                    title: UserProfileCubit.get(context)
                                        .MilirtyMaleStatus[index1],
                                    changeFunction: () {
                                      setState(() {
                                        UserProfileCubit.get(context)
                                            .MilirtyMaleStatusint = index1;
                                      });
                                    })),
                          ),
                        if (UserProfileCubit.get(context)
                                .getUserDataModel
                                .data!
                                .gender ==
                            2)
                          GridView.count(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0),
                            crossAxisCount:
                                (MediaQuery.of(context).orientation ==
                                        Orientation.landscape)
                                    ? 5
                                    : 2,
                            physics: const NeverScrollableScrollPhysics(),
                            // crossAxisCount: 2,
                            //  crossAxisSpacing: 0.0,

                            //    mainAxisSpacing: .0,
                            childAspectRatio: 0.8 / 0.15,
                            children: List.generate(
                                4,
                                (index1) => RadioButtonRegister(
                                    isRegisterScreen: false,
                                    value: index1,
                                    groupvalue: UserProfileCubit.get(context)
                                        .MilirtyStatusint!,
                                    title: UserProfileCubit.get(context)
                                        .MilirtyStatus[index1],
                                    changeFunction: () {
                                      setState(() {
                                        UserProfileCubit.get(context)
                                            .MilirtyStatusint = index1;
                                      });
                                    })),
                          ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          "هل لديك اطفال",
                          style: TextStyle(color: black, fontSize: 14),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        if (UserProfileCubit.get(context).genderUser == 1)
                          GridView.count(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0),
                            crossAxisCount:
                                (MediaQuery.of(context).orientation ==
                                        Orientation.landscape)
                                    ? 5
                                    : 1,
                            physics: const NeverScrollableScrollPhysics(),
                            // crossAxisCount: 2,
                            //   crossAxisSpacing: ,

                            mainAxisSpacing: .05,
                            childAspectRatio: 0.8 / 0.07,
                            children: List.generate(
                                4,
                                (index1) => RadioButtonRegister(
                                    isRegisterScreen: false,
                                    value: index1,
                                    groupvalue: UserProfileCubit.get(context)
                                        .numberOfKidsint!,
                                    title: UserProfileCubit.get(context)
                                        .numberOfKids[index1],
                                    changeFunction: () {
                                      setState(() {
                                        UserProfileCubit.get(context)
                                            .numberOfKidsint = index1;
                                      });
                                    })),
                          ),
                        if (UserProfileCubit.get(context).genderUser == 2)
                          GridView.count(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0),
                            crossAxisCount:
                                (MediaQuery.of(context).orientation ==
                                        Orientation.landscape)
                                    ? 5
                                    : 1,
                            physics: const NeverScrollableScrollPhysics(),
                            // crossAxisCount: 2,
                            //   crossAxisSpacing: ,

                            mainAxisSpacing: .05,
                            childAspectRatio: 0.8 / 0.07,
                            children: List.generate(
                                4,
                                (index1) => RadioButtonRegister(
                                    isRegisterScreen: false,
                                    value: index1,
                                    groupvalue: UserProfileCubit.get(context)
                                        .numberOfKidsFemaleint!,
                                    title: UserProfileCubit.get(context)
                                        .numberOfKidsFemale[index1],
                                    changeFunction: () {
                                      setState(() {
                                        UserProfileCubit.get(context)
                                            .numberOfKidsFemaleint = index1;
                                      });
                                    })),
                          ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        defaultTextFormField(
                            context: context,
                            container: Colors.grey[100],
                            styleText: Colors.black,
                            borderColor: primary,
                            controller: numberOfKidsController,
                            type: TextInputType.number,
                            validate: (String? value) {
                          /*    if (UserProfileCubit.get(context)
                                          .numberOfKidsint !=
                                      0 &&
                                  value!.isEmpty) {
                                return "من فضلك اكتب عدد الاطفال";
                              }*/
                            },
                            labelText: "عدد الاطفال",
                            //  labelTextcolor: white,
                            label: "الرجاء ادخال عدد الاطفال (ان وجد)",
                            prefixIcon: Icons.person),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          "نبذة عن مظهرك",
                          style: TextStyle(color: black, fontSize: 14),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        if (UserProfileCubit.get(context).genderUser == 1)
                          GridView.count(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0),
                            crossAxisCount:
                                (MediaQuery.of(context).orientation ==
                                        Orientation.landscape)
                                    ? 5
                                    : 2,
                            physics: const NeverScrollableScrollPhysics(),
                            // crossAxisCount: 2,
                            //  crossAxisSpacing: 0.0,

                            //    mainAxisSpacing: .0,
                            childAspectRatio: 0.8 / 0.15,
                            children: List.generate(
                                3,
                                (index1) => RadioButtonRegister(
                                    isRegisterScreen: false,
                                    value: index1,
                                    groupvalue: UserProfileCubit.get(context)
                                        .personalityint!,
                                    title: UserProfileCubit.get(context)
                                        .personality[index1],
                                    changeFunction: () {
                                      setState(() {
                                        UserProfileCubit.get(context)
                                            .personalityint = index1;
                                      });
                                    })),
                          ),
                        if (UserProfileCubit.get(context).genderUser == 2)
                          GridView.count(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0),
                            crossAxisCount:
                                (MediaQuery.of(context).orientation ==
                                        Orientation.landscape)
                                    ? 5
                                    : 2,
                            physics: const NeverScrollableScrollPhysics(),
                            // crossAxisCount: 2,
                            //  crossAxisSpacing: 0.0,

                            //    mainAxisSpacing: .0,
                            childAspectRatio: 0.8 / 0.15,
                            children: List.generate(
                                3,
                                (index1) => RadioButtonRegister(
                                    isRegisterScreen: false,
                                    value: index1,
                                    groupvalue: UserProfileCubit.get(context)
                                        .personalityFemaleint!,
                                    title: UserProfileCubit.get(context)
                                        .personalityFemale[index1],
                                    changeFunction: () {
                                      setState(() {
                                        UserProfileCubit.get(context)
                                            .personalityFemaleint = index1;
                                      });
                                    })),
                          ),

                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          "الوضع المالي",
                          style: TextStyle(color: black, fontSize: 14),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        if (UserProfileCubit.get(context).genderUser == 1)   GridView.count(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(0),
                          crossAxisCount: (MediaQuery.of(context).orientation ==
                                  Orientation.landscape)
                              ? 5
                              : 2,
                          physics: const NeverScrollableScrollPhysics(),
                          // crossAxisCount: 2,
                          //  crossAxisSpacing: 0.0,

                          //    mainAxisSpacing: .0,
                          childAspectRatio: 0.8 / 0.15,
                          children: List.generate(
                              4,
                              (index1) => RadioButtonRegister(
                                  isRegisterScreen: false,
                                  value: index1,
                                  groupvalue:
                                      UserProfileCubit.get(context).moneyint!,
                                  title: UserProfileCubit.get(context)
                                      .money[index1],
                                  changeFunction: () {
                                    setState(() {
                                      UserProfileCubit.get(context).moneyint =
                                          index1;
                                    });
                                  })),
                        ),
                        if (UserProfileCubit.get(context).genderUser == 2)   GridView.count(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(0),
                          crossAxisCount: (MediaQuery.of(context).orientation ==
                              Orientation.landscape)
                              ? 5
                              : 2,
                          physics: const NeverScrollableScrollPhysics(),
                          // crossAxisCount: 2,
                          //  crossAxisSpacing: 0.0,

                          //    mainAxisSpacing: .0,
                          childAspectRatio: 0.8 / 0.15,
                          children: List.generate(
                              4,
                                  (index1) => RadioButtonRegister(
                                  isRegisterScreen: false,
                                  value: index1,
                                  groupvalue:
                                  UserProfileCubit.get(context).moneyFemaleint??0,
                                  title: UserProfileCubit.get(context)
                                      .moneyFemale[index1],
                                  changeFunction: () {
                                    setState(() {
                                      UserProfileCubit.get(context).moneyFemaleint =
                                          index1;
                                    });
                                  })),
                        ),


                        SizedBox(
                          height: 1.5.h,
                        ),
                        defaultTextFormField(
                            context: context,
                            controller: monyOfPony,
                            container: Colors.grey[100],
                            styleText: Colors.black,
                            borderColor: primary,
                            type: TextInputType.number,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "من فضلك ادخل المهر";
                              }
                            },
                            labelText: "قيمة المهر",
                            //  labelTextcolor: white,
                            label: "قيمة المهر(0 الي 100 الف)",
                            prefixIcon: Icons.person),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        TextFormField(
                          controller: conditionsController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "من فضلك ادخل شروطك";
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "شروطك",
                            hintStyle: TextStyle(color: black, fontSize: 12),
                            hintMaxLines: 5,
                            enabled: true,

                            //   alignLabelWithHint: false,
                            //   prefixIcon: Icon(Icons.person_outline),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: primary,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: primary),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: primary),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          minLines: 1,
                          style: TextStyle(color: black),
                        ),

                        SizedBox(
                          height: 3.5.h,
                        ),
                        doubleInfinityMaterialButton(
                          text: "تاكيد",
                          onPressed: () {
                            if (formkey!.currentState!.validate()) {
                              if (UserProfileCubit.get(context).genderUser ==
                                  1) {
                                UserProfileCubit.get(context).specifications = [
                                  selectedlastName == 0 ? "قبيلة" : "عائلة",
                                  UserProfileCubit.get(context).hairColor[
                                      UserProfileCubit.get(context)
                                          .hairColorint!],
                                  UserProfileCubit.get(context).hairtype[
                                      UserProfileCubit.get(context)
                                          .hairTypeint!],
                                  UserProfileCubit.get(context).skinColor[
                                      UserProfileCubit.get(context)
                                          .skinColorint!],
                                  UserProfileCubit.get(context).parentSkinColor[
                                      UserProfileCubit.get(context)
                                          .parentSkinColorint!],
                                  UserProfileCubit.get(context).experience[
                                      UserProfileCubit.get(context)
                                          .experienceint!],
                                  UserProfileCubit.get(context).jobType[
                                      UserProfileCubit.get(context)
                                          .jopTypeint!],
                                  UserProfileCubit.get(context).illnesstype[
                                      UserProfileCubit.get(context)
                                          .illnessTypeint!],
                                  UserProfileCubit.get(context).genderUser == 2
                                      ? UserProfileCubit.get(context)
                                              .MilirtyStatus[
                                          UserProfileCubit.get(context)
                                              .MilirtyStatusint!]
                                      : UserProfileCubit.get(context)
                                              .MilirtyMaleStatus[
                                          UserProfileCubit.get(context)
                                              .MilirtyMaleStatusint!],
                                  UserProfileCubit.get(context).numberOfKids[
                                      UserProfileCubit.get(context)
                                          .numberOfKidsint!],
                                  UserProfileCubit.get(context).personality[
                                      UserProfileCubit.get(context)
                                          .personalityint!],
                                  UserProfileCubit.get(context).money[
                                      UserProfileCubit.get(context).moneyint!]
                                ];
                                UserProfileCubit.get(context).convert();
                                UserProfileCubit.get(context).updateUserData();
                              } else {
                                UserProfileCubit.get(context).specifications = [
                                  selectedlastName == 0 ? "قبيلة" : "عائلة",
                                  UserProfileCubit.get(context).hairColor[
                                      UserProfileCubit.get(context)
                                          .hairColorint!],
                                  UserProfileCubit.get(context).hairtype[
                                      UserProfileCubit.get(context)
                                          .hairTypeint!],
                                  UserProfileCubit.get(context).skinColor[
                                      UserProfileCubit.get(context)
                                          .skinColorint!],
                                  UserProfileCubit.get(context).parentSkinColor[
                                      UserProfileCubit.get(context)
                                          .parentSkinColorint!],
                                  UserProfileCubit.get(context).experience[
                                      UserProfileCubit.get(context)
                                          .experienceint!],
                                  UserProfileCubit.get(context).jobTypeFemale[
                                      UserProfileCubit.get(context)
                                          .jopTypeFemaleint!],
                                  UserProfileCubit.get(context).illnesstypeFemale[
                                      UserProfileCubit.get(context)
                                          .illnessTypeFemaleint!],
                                  UserProfileCubit.get(context).genderUser == 2
                                      ? UserProfileCubit.get(context)
                                              .MilirtyStatus[
                                          UserProfileCubit.get(context)
                                              .MilirtyStatusint!]
                                      : UserProfileCubit.get(context)
                                              .MilirtyMaleStatus[
                                          UserProfileCubit.get(context)
                                              .MilirtyStatusint!],
                                  UserProfileCubit.get(context).numberOfKidsFemale[
                                      UserProfileCubit.get(context)
                                          .numberOfKidsFemaleint!],
                                  UserProfileCubit.get(context).personalityFemale[
                                      UserProfileCubit.get(context)
                                          .personalityFemaleint!],
                                  UserProfileCubit.get(context).moneyFemale[
                                      UserProfileCubit.get(context).moneyFemaleint!]
                                ];
                                UserProfileCubit.get(context).convert();
                                UserProfileCubit.get(context).updateUserData();
                              }
                            }
                            /*  if(formkey.currentState!.validate()&&termsSelected&&isSelected2){
                                    RegisterClientCubit.get(context).specifications = [
                                      selectedlastName==0?"قبيلة":"عائلة",
                                      hairColor[selectedHairColorName],
                                      hairtype[selectedHairTypeName],
                                      skinColor[selectedSkinColorName],
                                      parentSkinColor[selectedParentSkinColorName],
                                      experience[selectedExperience],
                                      jobType[selectedJobType],
                                      illnesstype[selectedIllnessType],
                                      gender=="انثي"?
                                      MilirtyStatus[selectedMiliirtyType]:MilirtyMaleStatus[selectedMiliirtyMaleType],
                                      numberOfKids[selectedNumberOfKids],
                                      personality[selectedPersonality],
                                      money[selectedMoney]];
                                    print(RegisterClientCubit.get(context).specifications);
                                    RegisterClientCubit.get(context).convert();
                         /*           if (formkey.currentState!.validate()) {
                                      RegisterClientCubit.get(context).RegisterClient(
                                          specialNeeds:selectedIllnessType==2?true:false,
                                          gender: gender=="ذكر"?"1":"2",
                                          name: nameController.text,
                                          email: emailController.text,
                                          age: ageController.text,
                                          nationality: nationalityController.text,
                                          natonalityId: personalCardController.text,
                                          city: cityController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text,
                                          height: heightController.text,
                                          width: weightController.text,
                                          dowry: monyOfPony.text,
                                          terms: conditionsController.text);
                                    }}
                                  if(termsSelected==false){
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar( SnackBar(
                                      padding: EdgeInsetsDirectional.only(
                                          bottom: 3.h, start: 2.5.w, top: 2.h),
                                      duration: Duration(milliseconds: 2000),
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        "من فضلك اقسم ان المعلومات التي ادخلتها صحيحة لتستطيع التسجيل ",
                                        style: TextStyle(
                                            fontFamily: "Hs", fontSize: 11.sp),
                                      ),
                                    ));
                                  }
*/
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>VerificationPhone()));
                                }*/
                          },
                        ),
                        SizedBox(
                          height: 2.5.h,
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => ChangePassword());
                          },
                          child: Center(
                            child: Text(
                              "تغيير كلمة المرور",
                              style: GoogleFonts.poppins(
                                  color: primary,
                                  fontSize: 12.sp,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                      ],
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
}
