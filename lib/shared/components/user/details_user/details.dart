import 'package:astarar/shared/components/dialog_to_login.dart';
import 'package:astarar/shared/components/user/details_item.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class DetailsItemScreen extends StatelessWidget {
  final bool messageVisibility;
  final String name;
  final String age;
  final String email;
  final String nationality;
  final String city;
  final int gender;
  final String height;
  final String weight;
  final List userSubSpecificationDto;
final Function favouriteFunction;
  final Function chatFunction;
final bool isFavourite;
final bool specialNeeds;
final String dowry;
final String terms;
final Function onClickUser;
  DetailsItemScreen(

      {required this.userSubSpecificationDto,
        required this.dowry,
        required this.terms,
  required this.specialNeeds,required this.messageVisibility,
      required this.gender,
        required this.onClickUser,
      required this.height,
        required this.isFavourite,
        required this.favouriteFunction,
        required this.chatFunction,
      required this.weight,
      required this.city,
      required this.age,
      required this.nationality,
      required this.email,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(messageVisibility==false&&typeOfUser==1) InkWell(
          onTap: (){
            onClickUser();
          },
          child: Padding(
            padding: EdgeInsetsDirectional.only( top: 2.h,start: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/chat (7).png"),
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  "تواصل مع الخطابة",
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: primary,
                      decoration: TextDecoration.underline),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(top: 1.h),
          child: Center(
            child: Container(
              height: 20.h,
              width: 50.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: gender == 1
                        ? AssetImage(
                            maleImage,
                          )
                        : AssetImage(femaleImage),
                  )),
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(end: 2.w),
          child: Row(
            children: [
              Container(
                width: 35.w,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: 4.w),
                  child:
                      Text(name, style: GoogleFonts.poppins(fontSize: 12.sp)),
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
            /*  Container(
                width: 28.w,
                child: Text('أخر ظهور:3:26',
                    style: GoogleFonts.poppins(color: Colors.grey[500])),
              ),*/
              const Spacer(),
              Visibility(
                visible: messageVisibility&&typeOfUser==1,
                child: InkWell(
                  onTap: () {
                    if(isLogin==false){
                      showDialog(context: context, builder: (context)=>const DialogPleaseLogin());
                    }
                    else{
                    favouriteFunction();}
                  },
                  child: Image(
                      height: 3.5.h, image: isFavourite?const AssetImage("assets/fullFavorite.png"):const AssetImage('assets/Frame 146.png')),
                ),
              ),
              Visibility(
                visible: messageVisibility,
                child: SizedBox(
                  width: 3.w,
                ),
              ),
              Visibility(
                visible: messageVisibility,
                child: InkWell(
                  onTap: () {
                    if(isLogin==false){
                      showDialog(context: context, builder: (context)=>const DialogPleaseLogin());
                    }
                    else{
                    chatFunction();
                    }                  },
                  child: Image(
                      height: 3.h, image: const AssetImage('assets/chat (7).png')),
                ),
              ),

            ],
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: HexColor("#FFFFFF")),
          child: Row(
            children: [
              Container(
                  width: 46.w,
                  child: DetailsItem(title: 'العمر', subTitle: age+"  عام ")),
              Container(
                width: 35.w,
                child: DetailsItem(
                  title: 'المدينة',
                  subTitle: city,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: HexColor("#FFFFFF")),
          child: Row(
            children: [
              Container(
                  width: 46.w,
                  child: DetailsItem(title: 'الجنسية', subTitle: nationality)),
              Container(
                width: 35.w,
                child: DetailsItem(
                  subTitle: userSubSpecificationDto[0].specificationValue.toString(),
                  title: 'الاسم ينتهي',
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: HexColor("#FFFFFF")),
          child: Row(
            children: [
              Container(
                  width: 46.w,
                  child: DetailsItem(title: 'الطول', subTitle: "${height} سم")),
              Container(
                width: 35.w,
                child: DetailsItem(
                  title: 'الوزن',
                  subTitle: "${weight} ك",
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: HexColor("#FFFFFF")),
          child: Row(
            children: [
              Container(
                  width: 46.w,
                  child: DetailsItem(title: 'لون الشعر', subTitle: userSubSpecificationDto[1].specificationValue.toString(),)),
              Container(
                width: 35.w,
                child: DetailsItem(
                  subTitle: userSubSpecificationDto[4].specificationValue.toString(),
                  title: 'من عرق',
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: HexColor("#FFFFFF")),
          child: Row(
            children: [
              Container(
                  width: 46.w,
                  child: DetailsItem(title: 'مؤهل علمي', subTitle: userSubSpecificationDto[5].specificationValue.toString(),)),
              Container(
                width: 35.w,
                child: DetailsItem(
                  title: 'الوظيفة',
                  subTitle: userSubSpecificationDto[6].specificationValue.toString(),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: HexColor("#FFFFFF")),
          child: Row(
            children: [
              Container(width: 46.w,child: DetailsItem(title: 'الحالة الصحية', subTitle: userSubSpecificationDto[7].specificationValue.toString(),)),
              Container(
                width: 35.w,
                child: DetailsItem(
                  subTitle: userSubSpecificationDto[8].specificationValue.toString(),
                  title: 'الحالة الاجتماعية',
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: HexColor("#FFFFFF")),
          child: Row(
            children: [
              Container(
    width: 46.w,
    child: DetailsItem(title: 'هل لديك اطفال', subTitle: userSubSpecificationDto[9].specificationValue.toString(),)),
              Container(
                width: 35.w,
                child: DetailsItem(
                  title: 'نبذة عن مظهرك',
                  subTitle: userSubSpecificationDto[10].specificationValue.toString(),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: HexColor("#FFFFFF")),
          child: Row(
            children: [
              Container(width: 46.w,child: DetailsItem(title: 'عاهه جسدية', subTitle: specialNeeds?"يوجد ":"لا يوجد")),

              Container(
                width: 35.w,
                child: DetailsItem(
                  subTitle: userSubSpecificationDto[11].specificationValue.toString(),
                  title: 'الوضع المالي',
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: HexColor("#FFFFFF")),
          child: Row(
            children: [
              Container(width: 46.w,child: DetailsItem(title: 'نوع الزواج', subTitle:userSubSpecificationDto[12].specificationValue.toString() )),

              Container(width: 46.w,child: DetailsItem(title: 'قيمة المهر', subTitle:dowry )),
            ],
          ),
        ),
        Padding(
          padding:  EdgeInsetsDirectional.only(bottom: 2.h),
          child: Container(
            //height: 9.5.h,
            width: double.infinity,
            decoration: BoxDecoration(color: HexColor("#FFFFFF")),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [


                Container(
                  width: 80.w,
                  child: DetailsItem(
                    subTitle:terms,
                    title: 'الشروط',
                  ),
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }
}
