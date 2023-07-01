

import 'package:astarar/modules/home/layout/cubit/cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants.dart';
import '../../../../shared/styles/colors.dart';
import '../../../user_details/cubit/cubit.dart';
import '../../../user_details/user_details.dart';
import '../cubit/cubit.dart';

class SliderAds extends StatelessWidget 
{
  const SliderAds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: 
        CarouselSlider.builder(
          itemCount: HomeCubit.get(context)
              .getAllAdsWithUsersModel
              .data
              .length,
          itemBuilder: (context, realindex, index) => 
            Container(
              width: double.infinity,
              height: 25.h,
              decoration: BoxDecoration(
                  color: BG_DARK_COLOR,
                  borderRadius: BorderRadius.circular(15)),
              child: InkWell(
                onTap: (){
                  if(IS_LOGIN==true){
                    UserDetailsCubit.get(context)
                        .getOtherUser(
                        otherId:
                        HomeCubit.get(context)
                            .getAllAdsWithUsersModel.data[realindex].id!);}
                  else{
                    UserDetailsCubit.get(context)
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
                              UserDetailsScreen(
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
                              color: WHITE, fontSize: 11.sp),
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
                                  style: GoogleFonts.almarai(color: CUSTOME_GREY_2)
                              ),

                              Text("الجنسية : " + 
                                LayoutCubit.Countries.firstWhere((c) => 
                                    c.id == HomeCubit.get(context)
                                          .getAllAdsWithUsersModel
                                          .data[realindex]
                                          .countryId)
                                    .NameAr!,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.almarai(color: CUSTOME_GREY_2)
                              ),
                              SizedBox(height: 0.5.h,),

                              //TODO edit userSubSpecificationDto
                              Text(
                                  "نوع الزواج : " + "--------",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.almarai(color: CUSTOME_GREY_2,fontSize: 10.sp)
                              ),
                              
                              // Text(
                              //     "نوع الزواج : " + HomeCubit.get(context)
                              //         .getAllAdsWithUsersModel
                              //         .data[realindex]
                              //         .userSubSpecificationDto[12].specificationValue
                              //         .toString()
                              //     ,
                              //     textAlign: TextAlign.start,
                              //     style: GoogleFonts.almarai(color: customGrey2,fontSize: 10.sp)
                              // ),
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
