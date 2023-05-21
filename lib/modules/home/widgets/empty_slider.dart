

import 'package:astarar/shared/styles/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class EmptyResult extends StatelessWidget {
  const EmptyResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: CarouselSlider.builder(
          itemCount: 1,
          itemBuilder: (context, realindex, index) => Container(
            width: double.infinity,
            height: 35.h,
            decoration: BoxDecoration(
                color: backGround,
                borderRadius: BorderRadius.circular(15)),
            child: InkWell(
              onTap: (){

              },
              child: Row(
                children: [
                 /* Padding(
                    padding:
                    EdgeInsetsDirectional.only(start: 5.w),
                    child: Container(
                      width: 29.w,
                      height: 14.h,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(22.0),
                          image: DecorationImage(
                            image:  AssetImage("assets/icon.png")
                               ,
                            fit: BoxFit.fill,
                          )),
                    ),
                  ),*/

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: Text(
                     "عَنْ عَبْدِاللَّهِ بْنِ مَسْعُودٍ : قَالَ لَنَا رَسُولُ اللَّهِ ﷺ:\n( يَا مَعْشَرَ الشَّبَابِ، مَنِ اسْتَطَاعَ مِنْكُمُ الْبَاءَةَ فَلْيَتَزَوَّجْ، \n فَإِنَّهُ أَغَض لِلْبَصَرِ، وَأَحْصَنُ لِلْفَرْجِ، وَمَنْ لَمْ يَسْتَطِعْ فَعَلَيْهِ بِالصَّوْمِ؛\n فَإِنَّهُ لَهُ وِجَاءٌ.) مُتَّفَقٌ عَلَيْهِ.",
                      style: TextStyle(
                          color: Colors.white54, fontSize: 9.5.sp),
                    ),
                  )
                ],
              ),
            ),
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
