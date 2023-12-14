

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../shared/styles/colors.dart';

class EmptySlider extends StatelessWidget 
{
  const EmptySlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: 
        CarouselSlider.builder(
          itemCount: 1,
          itemBuilder: (context, realindex, index) => 
            Container(
              width: double.infinity,
              height: 35.h,
              decoration: BoxDecoration(
                  color: DARK_PRIMARY,
                  borderRadius: BorderRadius.circular(15)),
              child: 
                Column(
                  // crossAxisAlignment: EdgeInsets.symmetric(horizontal: 2.w),
                  children: [
                    SizedBox(height: 1.0.h,),

                    Text(
                      "حياكم الله",
                        style: GoogleFonts.almarai(
                            color: WHITE, fontSize: 16.0.sp, fontWeight: FontWeight.w400),
                      ),

                    SizedBox(height: 4.0.h,),

                    Text(
                      " في تطبيق استقرار جميع عروض الزواج متوفرة لدينا",
                        style: GoogleFonts.almarai(
                            color: WHITE, fontSize: 10.5.sp, fontWeight: FontWeight.w400),
                      ),

                  ],
                )
            ),
          options: CarouselOptions(
            height: 19.h,
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
