import 'dart:developer';

import 'package:astarar/shared/components/defaultTextFormField.dart';
import 'package:astarar/shared/components/double_infinity_material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../models/user.dart';
import '../../shared/components/logo/normal_logo.dart';
import '../../shared/components/radiobuttonregister.dart';
import '../../shared/styles/colors.dart';
import '../home/layout/cubit/cubit.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class AdvancedFilterScreen extends StatefulWidget 
{
  final String textSearch;

  const AdvancedFilterScreen({Key? key, required this.textSearch}): super(key: key);

  @override
  _AdvancedFilterScreenState createState() => _AdvancedFilterScreenState();
}

class _AdvancedFilterScreenState extends State<AdvancedFilterScreen> 
{
  List<SubSpecification> selectedSubSpecs = [];

  List<String> gender = ["ذكر", "انثي"];
  int? genderIndex;

  var minHeight = TextEditingController();
  var maxHeight = TextEditingController();
  var minWeight = TextEditingController();
  var maxWeight = TextEditingController();
  var minAge = TextEditingController();
  var maxAge = TextEditingController();

  @override
  Widget build(BuildContext context) 
  {
    // reset filter
    SearchCubit.get(context).query = {};

    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {
        if (state is FilterSearchLoadingState) {
          Navigator.pop( context );
        }else if (state is FilterSearchSuccessState) { }
      },
      builder: (context, state) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(11.h),
              child: NormalLogo(
                isBack: true,
                appbarTitle: "الفلتر",
              )
            ),
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
                      style: TextStyle(color: BLACK, fontSize: 12.3.sp)),
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
                                log(gender[index1],);
                              });
                            })),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),

                  //الحالة الاجتماعية
                  Text("الحالة الاجتماعية", style: TextStyle(color: BLACK, fontSize: 12.3.sp)),
                  SizedBox( height: 1.5.h, ),

                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: (MediaQuery.of(context).orientation ==
                            Orientation.landscape)
                        ? 4
                        : 2,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    childAspectRatio: 0.6 / 0.1,
                    children: getListofRadioButtons(SpecificationIDs.social_status)
                  ),

                  Text("المظهر", style: TextStyle(color: BLACK, fontSize: 12.3.sp)),
                    
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
                    children: getListofRadioButtons(SpecificationIDs.appearance),
                  ),

                  SizedBox(
                    height: 1.5.h,
                  ),

                  //الاطفال
                  Text("الاطفال", style: TextStyle(color: BLACK, fontSize: 12.3.sp)),

                  SizedBox( height: 1.5.h,),

                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: (MediaQuery.of(context).orientation ==
                            Orientation.landscape)
                        ? 4
                        : 1,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    childAspectRatio: 0.6 / 0.05,
                    children: getListofRadioButtons(SpecificationIDs.have_children)
                    ),

                  SizedBox(
                    height: 1.5.h,
                  ),

                  Text("الموهل العلمي", style: TextStyle(color: BLACK, fontSize: 12.3.sp)),
                  SizedBox(height: 1.5.h,),

                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: (MediaQuery.of(context).orientation ==
                            Orientation.landscape)
                        ? 4
                        : 2,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    childAspectRatio: 0.6 / 0.1,
                    children: getListofRadioButtons(SpecificationIDs.qualification)                    
                  ),

                  SizedBox(height: 1.5.h,),

                  Text("الاسم ينتهي ب ", style: TextStyle(color: BLACK, fontSize: 12.3.sp)),
                  SizedBox( height: 1.5.h,),

                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: (MediaQuery.of(context).orientation ==
                            Orientation.landscape)
                        ? 4
                        : 2,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    childAspectRatio: 0.6 / 0.1,
                    children: getListofRadioButtons(SpecificationIDs.name_end_with)
                  ),

                  SizedBox(
                    height: 1.5.h,
                  ),

                  Text("الوظيفة", style: TextStyle(color: BLACK, fontSize: 12.3.sp)),
                  SizedBox(height: 1.5.h,),

                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: (MediaQuery.of(context).orientation ==
                            Orientation.landscape)
                        ? 4
                        : 2,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    childAspectRatio: 0.6 / 0.1,
                    children: getListofRadioButtons(SpecificationIDs.job)
                  ),

                  
                  SizedBox(height: 1.5.h,),
                  
                  Text("لون البشرة", style: TextStyle(color: BLACK, fontSize: 12.3.sp)),
                  SizedBox(height: 1.5.h,),

                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: (MediaQuery.of(context).orientation ==
                            Orientation.landscape)
                        ? 4
                        : 2,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    childAspectRatio: 0.6 / 0.1,
                    children: getListofRadioButtons(SpecificationIDs.skin_colour)
                  ),

                  if (genderIndex != null)
                    SizedBox(height: 1.5.h,),

                  //الحالة الصحية
                  Text("الحالة الصحية", style: TextStyle(color: BLACK, fontSize: 12.3.sp)),
                  SizedBox(height: 1.5.h, ),

                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: (MediaQuery.of(context).orientation ==
                            Orientation.landscape)
                        ? 4
                        : 1,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    childAspectRatio: 0.6 / 0.05,
                    children: getListofRadioButtons(SpecificationIDs.health_status)
                  ),

                  SizedBox(
                    height: 1.5.h,
                  ),

                  Text("الطول", style: TextStyle(color: BLACK, fontSize: 12.3.sp)),
                  SizedBox(height: 1.5.h, ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 44.w,
                        child: defaultTextFormField(
                            context: context,
                            controller: minHeight,
                            labelTextcolor: Colors.white54,
                            borderColor: PRIMARY,
                            container: WHITE,
                            styleText: Colors.black87,
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
                            borderColor: PRIMARY,
                            container: WHITE,
                            styleText: Colors.black87,
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
                      style: TextStyle(color: BLACK, fontSize: 12.3.sp)),
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
                            borderColor: PRIMARY,
                            container: WHITE,
                            styleText: Colors.black87,
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
                            borderColor: PRIMARY,
                            container: WHITE,
                            styleText: Colors.black87,
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
                      style: TextStyle(color: BLACK, fontSize: 12.3.sp)),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: 
                    [
                      Container(
                        width: 44.w,
                        child: defaultTextFormField(
                            context: context,
                            controller: minAge,
                            labelTextcolor: Colors.white54,
                            styleText: Colors.black87,
                            borderColor: PRIMARY,
                            container: Colors.white,
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
                            borderColor: PRIMARY,
                            container: WHITE,
                            styleText: Colors.black87,
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

                  Text("نوع الزواج", style: TextStyle(color: BLACK, fontSize: 11.sp),
                  ),
                  SizedBox(height: 1.h,),
                  
                  GridView.count(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    crossAxisCount: (MediaQuery.of(context).orientation ==
                            Orientation.landscape)
                        ? 5
                        : 2,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 0.8 / 0.02.h,
                    children: getListofRadioButtons(SpecificationIDs.marriage_Type)
                  ),

                  SizedBox(
                    height: 3.5.h,
                  ),

                  doubleInfinityMaterialButton(
                      text: "بحث",
                      onPressed: () { searchOnPressed(context);}),

                  SizedBox(height: 1.5.h,),

                  doubleInfinityMaterialButton(
                      text: "مسح",
                      onPressed: () { clearAll(context); }),

                  SizedBox(height: 1.5.h,),

                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void clearAll(BuildContext context)
  {
    setState(() 
    {
        genderIndex = null;
        minHeight.text = "";
        maxHeight.text = "";
        minAge.text = "";
        maxAge.text = "";
        minWeight.text = "";
        maxWeight.text = "";

        selectedSubSpecs.clear();
    });
    
  }

  String? findSubSpecValueBySpecId_OrEmptyStr(specId)
  {
    //SubSpecification(0, null, 0, null)
    return selectedSubSpecs
            .firstWhere((s) => s.specId == specId,
            orElse: () => SubSpecification(0, null, 0, null)).value;
  }
  void searchOnPressed(BuildContext context) 
  {
      Map query = {
        "maritalStatus": findSubSpecValueBySpecId_OrEmptyStr(SpecificationIDs.social_status),
        "gender": (genderIndex == null)? 0 : genderIndex! + 1,
        "appearance": findSubSpecValueBySpecId_OrEmptyStr(SpecificationIDs.appearance),
        "children": findSubSpecValueBySpecId_OrEmptyStr(SpecificationIDs.have_children),
        "qualification": findSubSpecValueBySpecId_OrEmptyStr(SpecificationIDs.qualification),
        "wifeLineage": findSubSpecValueBySpecId_OrEmptyStr(SpecificationIDs.name_end_with),
        "hasDiseases": findSubSpecValueBySpecId_OrEmptyStr(SpecificationIDs.health_status),
        "skinSolour": findSubSpecValueBySpecId_OrEmptyStr(SpecificationIDs.skin_colour),
        "workNature": findSubSpecValueBySpecId_OrEmptyStr(SpecificationIDs.job),
        
        "minHeight": int.tryParse(minHeight.text)?? 0,
        "maxHeight": int.tryParse(maxHeight.text)?? 0,
        "minWeight": int.tryParse(minWeight.text)?? 0,
        "maxWeight": int.tryParse(minWeight.text)?? 0,
        "minAge": int.tryParse(minAge.text)?? 0,
        "maxAge": int.tryParse(maxAge.text)?? 0,        
        "TextSearch": widget.textSearch,
        "Typeofmarriage": findSubSpecValueBySpecId_OrEmptyStr(SpecificationIDs.marriage_Type),
        "skipPos": SearchCubit.get(context).searchResult.length,
      };

      SearchCubit.get(context).searchResult.clear();
      SearchCubit.get(context).isSearchByTextOnly = false;
      SearchCubit.get(context).query = query;
      SearchCubit.get(context).searchByFilter();

  }

  List<Widget> getListofRadioButtons(int specificationId) 
  {
    var Spec = LayoutCubit.Specifications[ specificationId ];

    if(Spec == null)
      return [Text("No Elements")];

    List<Widget> radios = [];
    Spec["subSpecifications"].forEach((sub_id, sub) 
    {
      SubSpecification? found;
      found = selectedSubSpecs
                      .where( (user_sub) => user_sub.specId == sub["specificationId"])
                      .firstOrNull;

      // log(found.toString());

      radios.add(
        WhiteRadioButton(
          value: sub["id"],
          groupvalue: found?.id, 
          title: sub["nameAr"] ,
          changeFunction: () {
            setState(() {
              if (found == null){
                found = new SubSpecification(sub["id"], sub["nameAr"], Spec["id"], Spec["nameAr"]);
                selectedSubSpecs.add(found!);
              }else{
                found?.id = sub["id"];
                found?.value = sub["nameAr"];
                found?.specId = Spec["id"];
                found?.name = Spec["nameAr"];
              }
            });
          })
      );      
    });
    return radios;
  }

}//end class
