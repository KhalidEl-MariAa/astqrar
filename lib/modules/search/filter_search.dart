import 'dart:developer';

import 'package:astarar/modules/search/cubit/states.dart';
import 'package:astarar/modules/search/result.dart';
import 'package:astarar/shared/components/components.dart';
import 'package:astarar/shared/components/logo/normal_logo.dart';
import 'package:astarar/shared/components/user/register/radiobuttonregister.dart';
import 'package:astarar/shared/styles/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';

import 'cubit/cubit.dart';

class FilterSearchScreen extends StatefulWidget {
  final String textSearch;

  const FilterSearchScreen({Key? key, required this.textSearch})
      : super(key: key);

  @override
  _FilterSearchScreenState createState() => _FilterSearchScreenState();
}

class _FilterSearchScreenState extends State<FilterSearchScreen> {
  List<String> gender = ["ذكر", "انثي"];
  List<String> MilirtyFemaleStatus = [
    'مطلقة بكر',
    'مطلقة',
    'أرملة',
    'عزباء بكر'
  ];
  List<String> MilirtyMaleStatus = ['أعزب', 'أرمل', 'مطلق'];
  List<String> personalityMale = ['وسيم', 'غير وسيم', 'مقبول الشكل'];
  List<String> personalityFemale = ['نوعا ما جميلة', 'متوسطة الجمال', 'جميلة'];
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
  List<String> experience = [
    'دكتوراة',
    'جامعي',
    'ابتدائي',
    'ثانوي',
    'متوسط',
    'غير متعلم'
  ];
  List lastNameList = ["عائلة", "قبيلة"];
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
  List<String> skinColor = ['بيضاء', 'سمراء', 'سوداء', 'قمحي'];
  List<String> illnesstypeMale = [
    'سليم من الأمراض',
    'من ذوي الاحتياجات الخاصة',
    'معي مرض مزمن'
  ];
  List<String> illnesstypeFemale = [
    'سليمة من الأمراض',
    'من ذوي الاحتياجات الخاصة',
    'معي مرض مزمن'
  ];

  List<String> merrageType = ['تعدد', 'مسيار', 'علني'];

  int? genderIndex;

  int? selectedMiliirtyFemaleType;
  int? selectedMiliirtyMaleType;

  int? selectedPersonalityMale;

  int? selectedPersonalityFemale;

  int? selectedNumberOfKidsMale;

  int? selectedNumberOfKidsFemale;

  int? selectedExperience;

  int? selectedLastNameIndex;

  int? selectedJopTypeMale;

  int? selectedJopTypeFemale;

  int? selectedSkinColorIndex;

  int? selectedillnesstypeMaleIndex;

  int? selectedillnesstypeFemaleIndex;

  int? selectedlastName;
  int? selectedMerrageType;

  var minHeight = TextEditingController();
  var maxHeight = TextEditingController();

  var minWeight = TextEditingController();
  var maxWeight = TextEditingController();

  var minAge = TextEditingController();
  var maxAge = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {
        if (state is FilterSearchSuccessState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ResultScreen()));
        }
      },
      builder: (context, state) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(11.h),
              child: NormalLogo(
                isBack: true,
                appbarTitle: "الفلتر",
              )),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 0.9.h,
                  ),

                  //الجنس
                  Text("نوع الجنس",
                      style: TextStyle(color: black, fontSize: 12.3.sp)),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: (MediaQuery.of(context).orientation ==
                            Orientation.landscape)
                        ? 4
                        : 2,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    childAspectRatio: 0.6 / 0.1,
                    children: List.generate(
                        gender.length,
                        (index1) => WhiteRadioButton(
                            value: index1,
                            groupvalue: genderIndex,
                            title: gender[index1],
                            changeFunction: () {
                              setState(() {
                                genderIndex = index1;
                                log(
                                  gender[index1],
                                );
                              });
                            })),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  //الحالة الاجتماعية
                  if (genderIndex != null)
                    Text("الحالة الاجتماعية",
                        style: TextStyle(color: black, fontSize: 12.3.sp)),
                  if (genderIndex != null)
                    SizedBox(
                      height: 1.5.h,
                    ),
                  if (genderIndex == 0)
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: (MediaQuery.of(context).orientation ==
                              Orientation.landscape)
                          ? 4
                          : 2,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      childAspectRatio: 0.6 / 0.1,
                      children: List.generate(
                          MilirtyMaleStatus.length,
                          (index1) => WhiteRadioButton(
                              value: index1,
                              groupvalue: selectedMiliirtyMaleType,
                              title: MilirtyMaleStatus[index1],
                              changeFunction: () {
                                setState(() {
                                  selectedMiliirtyMaleType = index1;
                                  log(
                                    MilirtyMaleStatus[index1],
                                  );
                                });
                              })),
                    ),
                  if (genderIndex == 1)
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: (MediaQuery.of(context).orientation ==
                              Orientation.landscape)
                          ? 4
                          : 2,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      childAspectRatio: 0.6 / 0.1,
                      children: List.generate(
                          MilirtyFemaleStatus.length,
                          (index1) => WhiteRadioButton(
                              value: index1,
                              groupvalue: selectedMiliirtyFemaleType,
                              title: MilirtyFemaleStatus[index1],
                              changeFunction: () {
                                setState(() {
                                  selectedMiliirtyFemaleType = index1;
                                  log(
                                    MilirtyFemaleStatus[index1],
                                  );
                                });
                              })),
                    ),
                  SizedBox(
                    height: 1.5.h,
                  ), //المظهر

                  if (genderIndex != null)
                    Text("المظهر",
                        style: TextStyle(color: black, fontSize: 12.3.sp)),
                  if (genderIndex != null)
                    SizedBox(
                      height: 1.5.h,
                    ),
                  if (genderIndex == 0)
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: (MediaQuery.of(context).orientation == Orientation.landscape) ? 4: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      childAspectRatio: 0.6 / 0.1,
                      children: List.generate(
                          personalityMale.length,
                          (index1) => WhiteRadioButton(
                              value: index1,
                              groupvalue: selectedPersonalityMale,
                              title: personalityMale[index1],
                              changeFunction: () {
                                setState(() {
                                  selectedPersonalityMale = index1;
                                  log(
                                    personalityMale[index1],
                                  );
                                });
                              })),
                    ),
                  if (genderIndex == 1)
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: (MediaQuery.of(context).orientation ==
                              Orientation.landscape)
                          ? 4
                          : 2,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      childAspectRatio: 0.6 / 0.1,
                      children: List.generate(
                          personalityFemale.length,
                          (index1) => WhiteRadioButton(
                              value: index1,
                              groupvalue: selectedPersonalityFemale,
                              title: personalityFemale[index1],
                              changeFunction: () {
                                setState(() {
                                  selectedPersonalityFemale = index1;
                                  log(
                                    personalityFemale[index1],
                                  );
                                });
                              })),
                    ),
                  if (genderIndex != null)
                    SizedBox(
                      height: 1.5.h,
                    ),
                  //الاطفال
                  if (genderIndex != null)
                    Text("الاطفال",
                        style: TextStyle(color: black, fontSize: 12.3.sp)),
                  if (genderIndex != null)
                    SizedBox(
                      height: 1.5.h,
                    ),
                  if (genderIndex == 0)
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: (MediaQuery.of(context).orientation ==
                              Orientation.landscape)
                          ? 4
                          : 1,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      childAspectRatio: 0.6 / 0.05,
                      children: List.generate(
                          numberOfKids.length,
                          (index1) => WhiteRadioButton(
                              value: index1,
                              groupvalue: selectedNumberOfKidsMale,
                              title: numberOfKids[index1],
                              changeFunction: () {
                                setState(() {
                                  selectedNumberOfKidsMale = index1;
                                  log(
                                    numberOfKids[index1],
                                  );
                                });
                              })),
                    ),
                  if (genderIndex == 1)
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: (MediaQuery.of(context).orientation ==
                              Orientation.landscape)
                          ? 4
                          : 1,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      childAspectRatio: 0.6 / 0.05,
                      children: List.generate(
                          numberOfKidsFemale.length,
                          (index1) => WhiteRadioButton(
                              value: index1,
                              groupvalue: selectedNumberOfKidsFemale,
                              title: numberOfKidsFemale[index1],
                              changeFunction: () {
                                setState(() {
                                  selectedNumberOfKidsFemale = index1;
                                  log(
                                    numberOfKidsFemale[index1],
                                  );
                                });
                              })),
                    ),
                  if (genderIndex != null)
                    SizedBox(
                      height: 1.5.h,
                    ),

                  Text("الموهل العلمي",
                      style: TextStyle(color: black, fontSize: 12.3.sp)),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: (MediaQuery.of(context).orientation ==
                            Orientation.landscape)
                        ? 4
                        : 2,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    childAspectRatio: 0.6 / 0.1,
                    children: List.generate(
                        experience.length,
                        (index1) => WhiteRadioButton(
                            value: index1,
                            groupvalue: selectedExperience,
                            title: experience[index1],
                            changeFunction: () {
                              setState(() {
                                selectedExperience = index1;
                                log(
                                  experience[index1],
                                );
                              });
                            })),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),

                  Text("الاسم ينتهي ب ",
                      style: TextStyle(color: black, fontSize: 12.3.sp)),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: (MediaQuery.of(context).orientation ==
                            Orientation.landscape)
                        ? 4
                        : 2,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    childAspectRatio: 0.6 / 0.1,
                    children: List.generate(
                        lastNameList.length,
                        (index1) => WhiteRadioButton(
                            value: index1,
                            groupvalue: selectedlastName,
                            title: lastNameList[index1],
                            changeFunction: () {
                              setState(() {
                                selectedlastName = index1;
                                log(
                                  lastNameList[selectedlastName!],
                                );
                              });
                            })),
                  ),
                  if (genderIndex != null)
                    SizedBox(
                      height: 1.5.h,
                    ),

                  if (genderIndex != null)
                    Text("الوظيفة",
                        style: TextStyle(color: black, fontSize: 12.3.sp)),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  if (genderIndex == 0)
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: (MediaQuery.of(context).orientation ==
                              Orientation.landscape)
                          ? 4
                          : 2,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      childAspectRatio: 0.6 / 0.1,
                      children: List.generate(
                          jobType.length,
                          (index1) => WhiteRadioButton(
                              value: index1,
                              groupvalue: selectedJopTypeMale,
                              title: jobType[index1],
                              changeFunction: () {
                                setState(() {
                                  selectedJopTypeMale = index1;
                                  log(
                                    jobType[index1],
                                  );
                                });
                              })),
                    ),
                  if (genderIndex == 1)
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: (MediaQuery.of(context).orientation ==
                              Orientation.landscape)
                          ? 4
                          : 2,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      childAspectRatio: 0.6 / 0.1,
                      children: List.generate(
                          jobTypeFemale.length,
                          (index1) => WhiteRadioButton(
                              value: index1,
                              groupvalue: selectedJopTypeFemale,
                              title: jobTypeFemale[index1],
                              changeFunction: () {
                                setState(() {
                                  selectedJopTypeFemale = index1;
                                });
                              })),
                    ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Text("لون البشرة",
                      style: TextStyle(color: black, fontSize: 12.3.sp)),
                  SizedBox(
                    height: 1.5.h,
                  ),

                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: (MediaQuery.of(context).orientation ==
                            Orientation.landscape)
                        ? 4
                        : 2,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    childAspectRatio: 0.6 / 0.1,
                    children: List.generate(
                        skinColor.length,
                        (index1) => WhiteRadioButton(
                            value: index1,
                            groupvalue: selectedSkinColorIndex,
                            title: skinColor[index1],
                            changeFunction: () {
                              setState(() {
                                selectedSkinColorIndex = index1;
                                log(
                                  skinColor[index1],
                                );
                              });
                            })),
                  ),
                  if (genderIndex != null)
                    SizedBox(
                      height: 1.5.h,
                    ),

                  //الحالة الصحية
                  if (genderIndex != null)
                    Text("الحالة الصحية",
                        style: TextStyle(color: black, fontSize: 12.3.sp)),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  if (genderIndex == 0)
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: (MediaQuery.of(context).orientation ==
                              Orientation.landscape)
                          ? 4
                          : 1,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      childAspectRatio: 0.6 / 0.05,
                      children: List.generate(
                          illnesstypeMale.length,
                          (index1) => WhiteRadioButton(
                              value: index1,
                              groupvalue: selectedillnesstypeMaleIndex,
                              title: illnesstypeMale[index1],
                              changeFunction: () {
                                setState(() {
                                  selectedillnesstypeMaleIndex = index1;
                                  log(
                                    illnesstypeMale[index1],
                                  );
                                });
                              })),
                    ),
                  if (genderIndex == 1)
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: (MediaQuery.of(context).orientation ==
                              Orientation.landscape)
                          ? 4
                          : 1,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      childAspectRatio: 0.6 / 0.05,
                      children: List.generate(
                          illnesstypeFemale.length,
                          (index1) => WhiteRadioButton(
                              value: index1,
                              groupvalue: selectedillnesstypeFemaleIndex,
                              title: illnesstypeFemale[index1],
                              changeFunction: () {
                                setState(() {
                                  selectedillnesstypeFemaleIndex = index1;
                                  log(
                                    illnesstypeFemale[index1],
                                  );
                                });
                              })),
                    ),

                  SizedBox(
                    height: 1.5.h,
                  ),

                  Text("الطول",
                      style: TextStyle(color: black, fontSize: 12.3.sp)),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 44.w,
                        child: defaultTextFormField(
                            context: context,
                            controller: minHeight,
                            labelTextcolor: Colors.white54,
                            borderColor: primary,
                            container: white,
                            type: TextInputType.number,
                            validate: (value) {
                              return null;
                            },
                            label: "الحد الادني للطول"),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Container(
                        width: 44.w,
                        child: defaultTextFormField(
                            context: context,
                            controller: maxHeight,
                            labelTextcolor: Colors.white54,
                            borderColor: primary,
                            container: white,
                            type: TextInputType.number,
                            validate: (value) {
                              return null;
                            },
                            label: "الحد الاقصي للطول"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),

                  //الوزن
                  Text("الوزن",
                      style: TextStyle(color: black, fontSize: 12.3.sp)),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 44.w,
                        child: defaultTextFormField(
                            context: context,
                            controller: minWeight,
                            labelTextcolor: Colors.white54,
                            borderColor: primary,
                            container: white,
                            type: TextInputType.number,
                            validate: (value) {
                              return null;
                            },
                            label: "الحد الادني للوزن"),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Container(
                        width: 44.w,
                        child: defaultTextFormField(
                            context: context,
                            controller: maxWeight,
                            labelTextcolor: Colors.white54,
                            borderColor: primary,
                            container: white,
                            type: TextInputType.number,
                            validate: (value) {
                              return null;
                            },
                            label: "الحد الاقصي للوزن"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),

                  Text("العمر",
                      style: TextStyle(color: black, fontSize: 12.3.sp)),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 44.w,
                        child: defaultTextFormField(
                            context: context,
                            controller: minAge,
                            labelTextcolor: Colors.white54,
                            borderColor: primary,
                            container: white,
                            type: TextInputType.number,
                            validate: (value) {
                              return null;
                            },
                            label: "الحد الادني للعمر"),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Container(
                        width: 44.w,
                        child: defaultTextFormField(
                            context: context,
                            controller: maxAge,
                            labelTextcolor: Colors.white54,
                            borderColor: primary,
                            container: white,
                            type: TextInputType.number,
                            validate: (value) {
                              return null;
                            },
                            label: "الحد الاقصي للعمر"),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 1.5.h,
                  ),

                  Text(
                    "نوع الزواج",
                    style: TextStyle(color: black, fontSize: 11.sp),
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
                        : 2,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 0.8 / 0.02.h,
                    children: List.generate(
                        3,
                        (index1) => WhiteRadioButton(
                            value: index1,
                            groupvalue: selectedMerrageType,
                            title: merrageType[index1],
                            changeFunction: () {
                              setState(() {
                                selectedMerrageType = index1;
                              });
                            })),
                  ),
                  SizedBox(
                    height: 3.5.h,
                  ),
                  doubleInfinityMaterialButton(
                      text: "بحث",
                      onPressed: () {
                        searchOnPressed(context);

                      }),
                  SizedBox(
                    height: 3.5.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  void searchOnPressed(BuildContext context) 
  {
    if (genderIndex == null) {
      SearchCubit.get(context).filterSearch(
        textSearch: widget.textSearch,
        minHeight: int.tryParse(minHeight.text),
        maxHeight: int.tryParse(maxHeight.text),
        minWeight: int.tryParse(minWeight.text),
        maxWeight: int.tryParse(minWeight.text),
        minAge: int.tryParse(minAge.text),
        maxAge: int.tryParse(maxAge.text),
        skinColor: selectedSkinColorIndex != null
            ? skinColor[selectedSkinColorIndex!]
            : null,
        typeOfMarriage: selectedMerrageType != null
            ? merrageType[selectedMerrageType!]
            : null,
        lastName: selectedlastName != null
            ? lastNameList[selectedlastName!]
            : null,
        qualifications: selectedExperience != null
            ? experience[selectedExperience!]
            : null,
        gender: genderIndex != null
            ? genderIndex == 0
                ? 1
                : 2
            : 0,
      );
    }
    if (genderIndex == 0) {
      SearchCubit.get(context).filterSearch(
          textSearch: widget.textSearch,
          minHeight: int.tryParse(minHeight.text),
          maxHeight: int.tryParse(maxHeight.text),
          minWeight: int.tryParse(minWeight.text),
          maxWeight: int.tryParse(minWeight.text),
          minAge: int.tryParse(minAge.text),
          maxAge: int.tryParse(maxAge.text),
          jobType: selectedJopTypeMale != null
              ? jobType[selectedJopTypeMale!]
              : null,
          typeOfMarriage: selectedMerrageType != null
              ? merrageType[selectedMerrageType!]
              : null,
          skinColor: selectedSkinColorIndex != null
              ? skinColor[selectedSkinColorIndex!]
              : null,
          illnessType: selectedillnesstypeMaleIndex != null
              ? illnesstypeMale[
                  selectedillnesstypeMaleIndex!]
              : null,
          lastName: selectedlastName != null
              ? lastNameList[selectedlastName!]
              : null,
          qualifications: selectedExperience != null
              ? experience[selectedExperience!]
              : null,
          childern: selectedNumberOfKidsMale != null
              ? numberOfKids[selectedNumberOfKidsMale!]
              : null,
          personality: selectedPersonalityMale != null
              ? personalityMale[selectedPersonalityMale!]
              : null,
          gender: genderIndex != null
              ? genderIndex == 0
                  ? 1
                  : 2
              : 0,
          milirity: selectedMiliirtyMaleType != null
              ? MilirtyMaleStatus[selectedMiliirtyMaleType!]
              : null);
    }
    if (genderIndex == 1) {
      SearchCubit.get(context).filterSearch(
          textSearch: widget.textSearch,
          minHeight: int.tryParse(minHeight.text),
          maxHeight: int.tryParse(maxHeight.text),
          minWeight: int.tryParse(minWeight.text),
          maxWeight: int.tryParse(minWeight.text),
          minAge: int.tryParse(minAge.text),
          maxAge: int.tryParse(maxAge.text),
          typeOfMarriage: selectedMerrageType != null
              ? merrageType[selectedMerrageType!]
              : null,
          jobType: selectedJopTypeFemale != null
              ? jobTypeFemale[selectedJopTypeFemale!]
              : null,
          skinColor: selectedSkinColorIndex != null
              ? skinColor[selectedSkinColorIndex!]
              : null,
          illnessType: selectedillnesstypeMaleIndex != null
              ? illnesstypeFemale[
                  selectedillnesstypeFemaleIndex!]
              : null,
          lastName: selectedlastName != null
              ? lastNameList[selectedlastName!]
              : null,
          qualifications: selectedExperience != null
              ? experience[selectedExperience!]
              : null,
          childern: selectedNumberOfKidsFemale != null
              ? numberOfKidsFemale[
                  selectedNumberOfKidsFemale!]
              : null,
          personality: selectedPersonalityFemale != null
              ? personalityFemale[
                  selectedPersonalityFemale!]
              : null,
          gender: genderIndex != null
              ? genderIndex == 0
                  ? 1
                  : 2
              : 0,
          milirity: selectedMiliirtyFemaleType != null
              ? MilirtyFemaleStatus[
                  selectedMiliirtyFemaleType!]
              : null);
    }    
  }


}//end class
