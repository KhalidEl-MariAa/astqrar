import '../../../../models/user.dart';
import '../../../../modules/details_user/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../../../models/get_information_user.dart';
import '../../dialog_please_login.dart';
import '../details_item.dart';
import '../../../contants/constants.dart';
import '../../../styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class DetailsItemScreen extends StatelessWidget 
{
  final bool messageVisibility;
  final String name;
  final String age;
  final String email;
  final String nationality;
  final String city;
  final int gender;
  final String height;
  final String weight;

  final List<UserSubSpecificationDtoModel> userSubSpecificationDto;
  final Function favouriteFunction;
  final Function chatFunction;
  final bool isFavourite;
  final bool specialNeeds;
  final String dowry;
  final String terms;
  final Function onClickUser;

  final GetInformationStates state;

  DetailsItemScreen({
    required this.state,
    required this.userSubSpecificationDto,
    required this.dowry,
    required this.terms,
    required this.specialNeeds,
    required this.messageVisibility,
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
    required this.name, 
  });

  @override
  Widget build(BuildContext context) 
  {
    return Column(
      children: [
        if(messageVisibility==false&&typeOfUser==1) 
          InkWell(
            onTap: (){ onClickUser(); },
            child: Padding(
              padding: EdgeInsetsDirectional.only( top: 2.h,start: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/chat (7).png"),
                  SizedBox( width: 3.w, ),
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
                    image: gender == 1 ? AssetImage(maleImage,) : AssetImage(femaleImage),
                  )),
            ),
          ),
        ),

        SizedBox( height: 2.h, ),

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
            // Container(
            //     width: 28.w,
            //     child: Text('أخر ظهور:3:26',
            //         style: GoogleFonts.poppins(color: Colors.grey[500])),
            // ),
              const Spacer(),
              Visibility(
                visible: messageVisibility && typeOfUser==1,
                child: 
                ConditionalBuilder(
                  condition: state is AddToFavouriteLoadingState ,
                  builder:  (context) => CircularProgressIndicator(),
                  fallback: (context)  =>                  
                    InkWell(
                      onTap: () 
                      {
                        if(isLogin==false){
                          showDialog(context: context, builder: (context) => const DialogPleaseLogin());
                          return ;
                        }
                        favouriteFunction();
                      },
                      child: Image(
                          height: 3.5.h, 
                          image: isFavourite?
                            const AssetImage("assets/fullFavorite.png")
                            :
                            const AssetImage('assets/Frame 146.png')),
                    ),
                  
                  ),
              ),
              Visibility(
                visible: messageVisibility,
                child: SizedBox( width: 3.w, ),
              ),
              Visibility(
                visible: messageVisibility,
                child: 
                ConditionalBuilder(
                  condition: state is AddHimToMyContactsLoading,
                  builder: (context) => CircularProgressIndicator(),
                  fallback: (context) =>
                    InkWell(
                      onTap: () {
                        if(isLogin==false){
                          showDialog(context: context, builder: (context) => const DialogPleaseLogin());
                          return;
                        }
                        chatFunction();
                      },
                      child: Image(height: 3.h, image: const AssetImage('assets/chat (7).png')),
                    ),

                  )
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
                  child: DetailsItem(
                    title: 'العمر', 
                    subTitle: age + "  عام ")),
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
                  title: 'الاسم ينتهي',
                  subTitle: findSubSpecificationOrEmptyStr(SpecificationIDs.name_end_with),
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
                child: DetailsItem(title: 'الوزن', subTitle: "${weight} ك",
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
                  child: DetailsItem(
                    title: 'لون الشعر', 
                    subTitle: findSubSpecificationOrEmptyStr(SpecificationIDs.hair_colour),                  
                    )),
              Container(
                width: 35.w,
                child: DetailsItem(
                  title: 'من عرق',
                  subTitle: findSubSpecificationOrEmptyStr(SpecificationIDs.strain),                  
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
                  child: DetailsItem(
                    title: 'مؤهل علمي', 
                    subTitle: findSubSpecificationOrEmptyStr(SpecificationIDs.qualification),
                  )
              ),

              Container(
                width: 35.w,
                child: DetailsItem(
                  title: 'الوظيفة',
                  subTitle: findSubSpecificationOrEmptyStr(SpecificationIDs.job),
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
              Container(width: 46.w,child: 
                DetailsItem(
                  title: 'الحالة الصحية', 
                  subTitle: findSubSpecificationOrEmptyStr(SpecificationIDs.health_status),
                )
              ),
              Container(
                width: 35.w,
                child: DetailsItem(
                  title: 'الحالة الاجتماعية',
                  subTitle: findSubSpecificationOrEmptyStr(SpecificationIDs.social_status),
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
                child: DetailsItem(
                  title: 'هل لديك اطفال', 
                  subTitle: findSubSpecificationOrEmptyStr(SpecificationIDs.have_children),)
              ),

              Container(
                width: 35.w,
                child: DetailsItem(
                  title: 'نبذة عن مظهرك',
                  subTitle: findSubSpecificationOrEmptyStr(SpecificationIDs.job),
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
                  title: 'الوضع المالي',
                  subTitle: findSubSpecificationOrEmptyStr(SpecificationIDs.financial_situation),

                  
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
                child: DetailsItem(
                  title: 'نوع الزواج',                   
                  subTitle: findSubSpecificationOrEmptyStr(SpecificationIDs.marriage_Type)                   
                  )),

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
  
  findSubSpecificationOrEmptyStr(int specId) 
  {

    var subkeys = SpecificationIDs.getSubSpecificationKeys(specId);
    return userSubSpecificationDto
                  .firstWhere(
                    (ss) => subkeys.contains(ss.id),
                            orElse: ( ) => UserSubSpecificationDtoModel(0, "X", "---------") )
                  .value
                  .toString();
  }
}
