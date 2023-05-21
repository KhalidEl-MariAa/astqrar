

import 'package:astarar/modules/details_user/cubit/cubit.dart';
import 'package:astarar/modules/details_user/details_user.dart';
import 'package:astarar/modules/home/cubit/cubit.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class SliderHome extends StatelessWidget {

  const SliderHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: CarouselSlider.builder(
          itemCount: HomeCubit.get(context)
              .getAllAdsWithUsersModel
              .data
              .length,
          itemBuilder: (context, realindex, index) => Container(
            width: double.infinity,
            height: 25.h,
            decoration: BoxDecoration(
                color: HexColor("303031"),
                borderRadius: BorderRadius.circular(15)),
            child: InkWell(
              onTap: (){
                if(isLogin==true){
                  GetInformationCubit.get(context)
                      .getInformationUser(
                      userId:
                      HomeCubit.get(context)
                          .getAllAdsWithUsersModel.data[realindex].id!);}
                else{
                  GetInformationCubit.get(context)
                      .getInformationUserByVisitor(
                      userId:
                     HomeCubit.get(context)
                          .getAllAdsWithUsersModel.data[realindex]
                          .id!);
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailsUserScreen(
                              messageVisibility: true,
                            )));
              },
              child: Row(
                children: [
                  Padding(
                    padding:
                    EdgeInsetsDirectional.only(start: 5.w),
                    child: Container(
                      width: 25.w,
                      height: 13.h,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(22.0),
                          image: DecorationImage(
                            image: HomeCubit.get(context)
                                .getAllAdsWithUsersModel
                                .data[realindex]
                                .gender ==
                                1
                                ? AssetImage(maleImage)
                                : AssetImage(femaleImage),
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        HomeCubit.get(context)
                            .getAllAdsWithUsersModel
                            .data[realindex]
                            .userName!,
                        style: TextStyle(
                            color: white, fontSize: 11.sp),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        height: 7.h,
                        width: 45.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "العمر : "+HomeCubit.get(context)
                                    .getAllAdsWithUsersModel
                                    .data[realindex]
                                    .age
                                    .toString()
                                ,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.almarai(color: HexColor("A4A4A4"))
                            ),
                            Text(
                                "الجنسية : "+HomeCubit.get(context)
                                    .getAllAdsWithUsersModel
                                    .data[realindex]
                                    .nationality
                                    .toString()
                                ,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.almarai(color: HexColor("A4A4A4"))
                            ),
                            SizedBox(height: 0.5.h,),
                            Text(
                                "نوع الزواج : "+HomeCubit.get(context)
                                    .getAllAdsWithUsersModel
                                    .data[realindex]
                                    .userSubSpecificationDto[12].specificationValue
                                    .toString()
                                ,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.almarai(color: HexColor("A4A4A4"),fontSize: 10.sp)
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          options: CarouselOptions(
            height: 20.h,
            reverse: false,
            aspectRatio: 20 / 9,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            initialPage: 0,
            //viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(seconds: 5),
            autoPlayCurve: Curves.fastLinearToSlowEaseIn,
            scrollDirection: Axis.horizontal,
          )),
    );
  }
}
