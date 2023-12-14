

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/styles/colors.dart';
import '../../../user_details/cubit/cubit.dart';
import '../../../user_details/user_details.dart';
import '../../layout/cubit/cubit.dart';
import '../cubit/cubit.dart';

class SliderAds extends StatelessWidget 
{
  const SliderAds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) 
  {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: 
        CarouselSlider.builder(
          itemCount: HomeCubit.get(context).userAds.length,
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
          ),
          itemBuilder: (context, realindex, index) => 
            Container(
              width: double.infinity,
              height: 25.h,
              decoration: BoxDecoration(
                  color: DARK_PRIMARY,
                  borderRadius: BorderRadius.circular(15)),
              child: InkWell(
                onTap: (){
                  if(IS_LOGIN==true){
                    UserDetailsCubit.get(context)
                        .getOtherUser(
                        otherId:
                        HomeCubit.get(context).userAds[realindex].id!);
                  }
                  else{
                    UserDetailsCubit.get(context)
                        .getInformationUserByVisitor(
                        userId: HomeCubit.get(context).userAds[realindex]
                            .id!);
                  }
                  navigateTo(
                    context: context, 
                    widget: UserDetailsScreen(messageVisibility: true,)
                  );
                  
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
                              image: getUserImage(HomeCubit.get(context)
                                      .userAds[realindex]),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),

                    SizedBox(width: 5.w,),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          HomeCubit.get(context)
                              .userAds[realindex]
                              .user_Name??"XX",
                          style: GoogleFonts.almarai(color: WHITE, fontSize: 16, fontWeight: FontWeight.w600 )
                        ),
                        SizedBox(height: 2.h,),
                        Container(
                          // height: 7.h,
                          // width: 45.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "العمر : " + HomeCubit.get(context)
                                      .userAds[realindex]
                                      .age
                                      .toString()
                                  ,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.almarai(color: WHITE, fontWeight: FontWeight.w600)
                              ),

                              Text("الجنسية : " + 
                                  LayoutCubit.Countries
                                    .where((c) => 
                                        c.id == HomeCubit.get(context)
                                              .userAds[realindex]
                                              .countryId)
                                    .first
                                    .NameAr!,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.almarai(color: WHITE,fontWeight: FontWeight.w600)
                              ),
                              SizedBox(height: 0.5.h,),

                              Text(
                                  "نوع الزواج : " + HomeCubit.get(context)
                                          .userAds[realindex]
                                          .typeOfMarriage
                                          ,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.almarai(color: WHITE, fontWeight: FontWeight.w600)
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
        ),
    );
  }
}
