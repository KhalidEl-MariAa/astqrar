import '../../constants.dart';
import '../../models/country.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../models/user.dart';
import '../../shared/components/components.dart';
import '../../shared/components/loading_gif.dart';
import '../../shared/components/logo/normal_logo.dart';
import '../../shared/components/radiobuttonregister.dart';
import '../../shared/styles/colors.dart';
import '../change_password/change_password.dart';
import '../change_profile_img/change_profile_img.dart';
import '../home/layout/cubit/cubit.dart';
import '../home/layout/layout.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  UserProfileScreenState createState() => UserProfileScreenState();
}

class UserProfileScreenState extends State<UserProfileScreen> {
  int selectedlastName = 0;

  String gender = "ذكر";
  var formkey = GlobalKey<FormState>();

  var lastNameFamilyController = TextEditingController();

  var jobNameController = TextEditingController();
  var illnessTypeController = TextEditingController();
  var numberOfKidsController = TextEditingController();

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var personalCardController = TextEditingController();
  var cityController = TextEditingController();
  var ageController = TextEditingController();
  var phoneController = TextEditingController();
  var weightController = TextEditingController();
  var heightController = TextEditingController();
  var nationalityController = TextEditingController();
  var dowryController = TextEditingController();
  var conditionsController = TextEditingController();

  late User current_user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserProfileCubit()..getUserData(),
      child: BlocConsumer<UserProfileCubit, UserProfileStates>(
        listener: (context, state) {
          on_state_is_changed(context, state);
        },
        builder: (context, state) => ConditionalBuilder(
          condition: state is GetUserDataLoadingState,
          builder: (context) =>
              Scaffold(backgroundColor: WHITE, body: const LoadingGif()),
          fallback: (context) => Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              // backgroundColor: backGround,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(11.h),
                child: NormalLogo(appbarTitle: "الملف الشخصي", isBack: true),
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

                        if (IS_DEVELOPMENT_MODE)
                          Text(
                            "id: " + current_user.id.toString(),
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w900),
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
                              } else if (!value.contains("@")) {
                                return "من فضلك ادخل البريد الالكتروني بطريقة صحيحة";
                              } else {
                                current_user.email = value;
                                return null;
                              }
                            },
                            labelText: "البريد الالكتروني",
                            //  labelTextcolor: white,
                            container: Colors.grey[100],
                            styleText: Colors.black,
                            borderColor: PRIMARY,
                            label: "الرجاء ادخال البريد الالكتروني",
                            prefixIcon: Icons.email_outlined),

                        SizedBox(
                          height: 1.5.h,
                        ),

                        defaultTextFormField(
                            context: context,
                            container: Colors.grey[100],
                            styleText: Colors.black,
                            borderColor: PRIMARY,
                            controller: nameController,
                            //   labelTextcolor: white,
                            type: TextInputType.text,
                            validate: (String? value) {
                              current_user.user_Name = value;
                              return (value!.isEmpty)
                                  ? "من فضلك ادخل الاسم"
                                  : null;
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
                            borderColor: PRIMARY,
                            validate: (String? value) {
                              current_user.city = value;
                              return (value!.isEmpty)
                                  ? "من فضلك ادخل المدينة"
                                  : null;
                            },
                            labelText: "المدينة",
                            label: "الرجاء ادخال المدينة",
                            prefixIcon: Icons.person_outline),
                        SizedBox(
                          height: 1.5.h,
                        ),

                        defaultTextFormField(
                            context: context,
                            controller: phoneController,
                            type: TextInputType.number,
                            validate: (String? value) {
                              current_user.phone = value;
                              return (value!.isEmpty)
                                  ? "من فضلك ادخل الهاتف"
                                  : null;
                            },
                            container: Colors.grey[100],
                            styleText: Colors.black,
                            borderColor: PRIMARY,
                            labelText: "رقم الهاتف",
                            label: "الرجاء ادخال رقم الهاتف",
                            prefixIcon: Icons.phone),

                        // SizedBox(height: 1.5.h,),
                        // defaultTextFormField(
                        //     context: context,
                        //     container: Colors.grey[100],
                        //     styleText: Colors.black,
                        //     borderColor: PRIMARY,
                        //     controller: nationalityController,
                        //     type: TextInputType.text,
                        //     validate: (String? value) {
                        //       current_user.nationality = value;
                        //       return (value!.isEmpty)? "من فضلك ادخل الجنسية": null;
                        //     },
                        //     labelText: "الجنسية",
                        //     label: "الرجاء ادخال الجنسية",
                        //     prefixIcon: Icons.person_outline),

                        SizedBox(
                          height: 1.5.h,
                        ),

                        Row(
                          children: [
                            Text(
                              "الجنسية: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500),
                            ),

                            SizedBox(width: 1.w, ),
                            
                            DropdownButton<Country>(
                              value: LayoutCubit.Countries.where(
                                          (e) => e.id == current_user.countryId)
                                      .firstOrNull ??
                                  LayoutCubit.Countries[0],
                              style:
                                  const TextStyle(color: BLACK, fontSize: 16),
                              underline: Container(
                                height: 2,
                                color: BLACK,
                              ),
                              onChanged: (Country? c) {
                                setState(() {
                                  current_user.countryId = c?.id;
                                });
                              },
                              items: LayoutCubit.Countries.map<
                                  DropdownMenuItem<Country>>((Country c) {
                                return DropdownMenuItem<Country>(
                                  value: c,
                                  child: Text(c.NameAr ?? "----"),
                                );
                              }).toList(),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 1.5.h,
                        ),

                        Text(
                          "الاسم ينتهي",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500),
                        ),

                        GridView.count(
                            shrinkWrap: true,
                            crossAxisCount:
                                (MediaQuery.of(context).orientation ==
                                        Orientation.landscape)
                                    ? 4
                                    : 2,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(0),
                            childAspectRatio: 0.6 / 0.1,
                            children: getListofRadioButtons(
                                SpecificationIDs.name_end_with)),

                        defaultTextFormField(
                            context: context,
                            container: Colors.grey[100],
                            styleText: Colors.black,
                            borderColor: PRIMARY,
                            controller: lastNameFamilyController,
                            type: TextInputType.text,
                            labelTextcolor: Colors.black,
                            validate: (value) {
                              current_user.tribe = value;
                              return null;
                            },
                            label: "ادخل اسم العائلة/القبيلة"),

                        SizedBox(
                          height: 1.5.h,
                        ),
                        defaultTextFormField(
                            context: context,
                            container: Colors.grey[100],
                            styleText: Colors.black,
                            borderColor: PRIMARY,
                            controller: ageController,
                            type: TextInputType.number,
                            validate: (String? value) {
                              current_user.age =
                                  int.parse(value == "" ? "18" : value ?? "18");
                              return (current_user.age < 18)
                                  ? "من فضلك ادخل العمر، غير مسموح لمن هم أقل من 18 سنة"
                                  : null;
                            },
                            labelText: "العمر",
                            label: "الرجاء ادخال العمر",
                            prefixIcon: Icons.person_outline),
                        SizedBox(
                          height: 1.5.h,
                        ),

                        defaultTextFormField(
                            context: context,
                            container: Colors.grey[100],
                            styleText: Colors.black,
                            borderColor: PRIMARY,
                            controller: heightController,
                            type: TextInputType.number,
                            validate: (String? value) {
                              current_user.height = value;
                              return;
                              // return (value!.isEmpty)? "من فضلك ادخل الطول": null;
                            },
                            labelText: "الطول",
                            label: "الرجاء ادخال الطول",
                            prefixIcon: Icons.person_outline),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        defaultTextFormField(
                            context: context,
                            container: Colors.grey[100],
                            styleText: Colors.black,
                            borderColor: PRIMARY,
                            controller: weightController,
                            type: TextInputType.number,
                            validate: (String? value) {
                              current_user.weight = value;
                              return;
                              // return (value!.isEmpty)? "من فضلك ادخل الوزن": null;
                            },
                            labelText: "الوزن",
                            label: "الرجاء ادخال الوزن",
                            prefixIcon: Icons.person_outline),
                        SizedBox(
                          height: 1.5.h,
                        ),

                        Text(
                          "لون الشعر",
                          style: TextStyle(color: BLACK, fontSize: 12.sp),
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
                          padding: const EdgeInsets.all(0),
                          mainAxisSpacing: 5,
                          childAspectRatio: 0.6 / 0.1,
                          children: getListofRadioButtons(
                              SpecificationIDs.hair_colour),
                        ),

                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          "نوع الشعر",
                          style: TextStyle(color: BLACK, fontSize: 14),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        GridView.count(
                            shrinkWrap: true,
                            crossAxisCount:
                                (MediaQuery.of(context).orientation ==
                                        Orientation.landscape)
                                    ? 4
                                    : 2,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(0),
                            childAspectRatio: 0.6 / 0.1,
                            children: getListofRadioButtons(
                                SpecificationIDs.hair_type)),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          "لون البشرة",
                          style: TextStyle(color: BLACK, fontSize: 14),
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
                          padding: const EdgeInsets.all(0),
                          childAspectRatio: 0.6 / 0.1,
                          children: getListofRadioButtons(
                              SpecificationIDs.skin_colour),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          "من عرق",
                          style: TextStyle(color: BLACK, fontSize: 14),
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
                          childAspectRatio: 0.6 / 0.1,
                          children:
                              getListofRadioButtons(SpecificationIDs.strain),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          "الموهل العلمي",
                          style: TextStyle(color: BLACK, fontSize: 14),
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
                          childAspectRatio: 0.6 / 0.19,
                          children: getListofRadioButtons(
                              SpecificationIDs.qualification),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          "الوظيفة",
                          style: TextStyle(color: BLACK, fontSize: 14),
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
                          childAspectRatio: 0.6 / 0.1,
                          children: getListofRadioButtons(SpecificationIDs.job),
                        ),

                        defaultTextFormField(
                            context: context,
                            controller: jobNameController,
                            type: TextInputType.text,
                            validate: (String? value) {
                              current_user.nameOfJob = value;
                              return null;
                            },
                            container: Colors.grey[100],
                            styleText: Colors.black,
                            borderColor: PRIMARY,
                            labelText: "اسم الوظيفة",
                            label: "الرجاء ادخال اسم الوظيفة (ان وجدت)",
                            prefixIcon: Icons.person),

                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          "الحالة الصحية",
                          style: TextStyle(color: BLACK, fontSize: 14),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),

                        GridView.count(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          crossAxisCount: (MediaQuery.of(context).orientation ==
                                  Orientation.landscape)
                              ? 5
                              : 1,
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: 0.9 / 0.1,
                          children: getListofRadioButtons(
                              SpecificationIDs.health_status),
                        ),

                        SizedBox(
                          height: 1.5.h,
                        ),

                        defaultTextFormField(
                            context: context,
                            controller: illnessTypeController,
                            container: Colors.grey[100],
                            styleText: Colors.black,
                            borderColor: PRIMARY,
                            type: TextInputType.text,
                            validate: (String? value) {
                              current_user.illnessType = value;
                              return null;
                            },
                            labelText: "نوع المرض",
                            label: "الرجاء ادخال نوع المرض (ان وجد)",
                            prefixIcon: Icons.person),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          "الحالة الاجتماعية",
                          style: TextStyle(color: BLACK, fontSize: 14),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),

                        GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: (MediaQuery.of(context).orientation ==
                                  Orientation.landscape)
                              ? 5
                              : 2,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(0),
                          childAspectRatio: 0.8 / 0.15,
                          children: getListofRadioButtons(
                              SpecificationIDs.social_status),
                        ),

                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          "هل لديك اطفال",
                          style: TextStyle(color: BLACK, fontSize: 14),
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
                              : 1,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: .05,
                          childAspectRatio: 0.8 / 0.07,
                          children: getListofRadioButtons(
                              SpecificationIDs.have_children),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),

                        defaultTextFormField(
                            context: context,
                            container: Colors.grey[100],
                            styleText: Colors.black,
                            borderColor: PRIMARY,
                            controller: numberOfKidsController,
                            type: TextInputType.number,
                            validate: (String? value) {
                              var no_kids = current_user.subSpecifications
                                  .any((sub) => sub.id == 77);
                              bool anyone_is_selected =
                                  current_user.subSpecifications.any((sub) =>
                                      sub.specId ==
                                      SpecificationIDs.have_children);
                              // 77 -> 'بدون أطفال'
                              if (no_kids || !anyone_is_selected) {
                                return null;
                              } else if (value!.isEmpty) {
                                return "من فضلك اكتب عدد الاطفال";
                              }
                              current_user.numberOfKids =
                                  int.parse(numberOfKidsController.text);
                              return null;
                            },
                            labelText: "عدد الاطفال",
                            label: "الرجاء ادخال عدد الاطفال (ان وجد)",
                            prefixIcon: Icons.person),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          "نبذة عن مظهرك",
                          style: TextStyle(color: BLACK, fontSize: 14),
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
                          childAspectRatio: 0.8 / 0.15,
                          children: getListofRadioButtons(
                              SpecificationIDs.appearance),
                        ),

                        SizedBox(
                          height: 1.5.h,
                        ),

                        Text(
                          "الوضع المالي",
                          style: TextStyle(color: BLACK, fontSize: 14),
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
                          childAspectRatio: 0.8 / 0.15,
                          children: getListofRadioButtons(
                              SpecificationIDs.financial_situation),
                        ),

                        Text(
                          "نوع الزواج",
                          style: TextStyle(color: BLACK, fontSize: 14),
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
                          childAspectRatio: 0.8 / 0.15,
                          children: getListofRadioButtons(
                              SpecificationIDs.marriage_Type),
                        ),

                        SizedBox(
                          height: 1.5.h,
                        ),
                        defaultTextFormField(
                            context: context,
                            controller: dowryController,
                            container: Colors.grey[100],
                            styleText: Colors.black,
                            borderColor: PRIMARY,
                            type: TextInputType.number,
                            validate: (String? value) {
                              current_user.dowry = value;
                              return;
                              // return (value!.isEmpty)? "من فضلك ادخل المهر": null;
                            },
                            labelText: "قيمة المهر",
                            label: "قيمة المهر(0 الي 100 الف)",
                            prefixIcon: Icons.person),
                        SizedBox(
                          height: 1.5.h,
                        ),

                        TextFormField(
                          controller: conditionsController,
                          validator: (String? value) {
                            current_user.terms = value;
                            return;
                            // return (value!.isEmpty)? "من فضلك ادخل شروطك": null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(
                                  '[\u0600-\u06FF\\s]'), // Arabic Unicode range
                            ),
                          ],
                          decoration: InputDecoration(
                            hintText: "شروطك - يسمح فقط بالحروف العربية",
                            hintStyle: TextStyle(color: BLACK, fontSize: 12),
                            hintMaxLines: 5,
                            enabled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: PRIMARY,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: PRIMARY),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: PRIMARY),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          minLines: 1,
                          style: TextStyle(color: BLACK),
                        ),

                        SizedBox(
                          height: 3.5.h,
                        ),
                        doubleInfinityMaterialButton(
                          text: "تحديث",
                          onPressed: () { 
                            confirmOnPress(context);
                          },
                        ),

                        Center(
                          child: ConditionalBuilder(
                            condition: state is UpdateUserDataLoadingState,
                            builder: (context) => CircularProgressIndicator(),
                            fallback: (context) => Text(
                              "",
                              style: TextStyle(color: Colors.yellow),
                            ),
                          ),
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
                              style: GoogleFonts.almarai(
                                  color: PRIMARY,
                                  fontSize: 12.sp,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 2.0.h,
                        ),

                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => ChangeProfileImg());
                          },
                          child: Center(
                            child: Text(
                              "تغيير الصورة الشخصية",
                              style: GoogleFonts.almarai(
                                  color: PRIMARY,
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
  } //end widget

  void confirmOnPress(BuildContext context) {
    if (!formkey.currentState!.validate()) {
      showToast(msg: "يوجد بيانات غير صحيحة", state: ToastStates.ERROR);
      return;
    }

    UserProfileCubit.get(context).updateUserData(this.current_user);
  } //edn confirmPress

  List<Widget> getListofRadioButtons(int specificationId) {
    var Spec = LayoutCubit.Specifications[specificationId];

    if (Spec == null) return [Text("No Elements")];

    List<Widget> radios = [];
    Spec["subSpecifications"].forEach((sub_id, sub) {
      SubSpecification found_or_created;
      found_or_created = this.current_user.subSpecifications.firstWhere(
          (user_sub) => user_sub.specId == sub["specificationId"], orElse: () {
        var new_sub =
            new SubSpecification(0, sub["nameAr"], Spec["id"], Spec["nameAr"]);
        return new_sub;
      });

      radios.add(WhiteRadioButton(
          value: sub["id"],
          groupvalue: found_or_created.id,
          title: sub["nameAr"],
          changeFunction: () {
            setState(() {
              if (found_or_created.id == 0) {
                this.current_user.subSpecifications.add(found_or_created);
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

  void on_state_is_changed(BuildContext context, UserProfileStates state) {
    if (state is GetUserDataSucccessState) {
      this.current_user = state.current_user;
      emailController.text = current_user.email ?? "";
      nameController.text = current_user.user_Name ?? "";
      personalCardController.text = current_user.nationalID ?? "";
      cityController.text = current_user.city ?? "";
      // nationalityController.text = current_user.nationality?? "";
      lastNameFamilyController.text = current_user.tribe ?? "";

      ageController.text = current_user.age.toString();
      phoneController.text = current_user.phone ?? "";
      heightController.text = current_user.height?.toString() ?? "";
      weightController.text = current_user.weight?.toString() ?? "";
      jobNameController.text = current_user.nameOfJob ?? "";
      illnessTypeController.text = current_user.illnessType ?? "";
      numberOfKidsController.text = current_user.numberOfKids?.toString() ?? "";

      conditionsController.text = current_user.terms ?? "";
      dowryController.text = current_user.dowry ?? "";
    } else if (state is GetUserDataErrorState) {
      showToast(msg: state.error, state: ToastStates.ERROR);
    } else if (state is UpdateUserDataSucccessState) {
      showToast(msg: "تم تحديث البيانات بنجاح", state: ToastStates.SUCCESS);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LayoutScreen()),
          (route) => false);
    } else if (state is UpdateUserDataErrorState) {
      showToast(msg: state.error, state: ToastStates.ERROR);
    }
  }
}//end class
