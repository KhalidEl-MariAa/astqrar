
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../styles/colors.dart';
import '../header_logo.dart';

class StackLogo extends StatelessWidget 
{
  final String appbarTitle;
  final List strings;
  StackLogo({required this.appbarTitle,required this.strings});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 17.h,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  AppBar(
                    toolbarHeight: 13.h,

                    title: Row(
                      mainAxisAlignment:MainAxisAlignment.start,
                      children: [
                         InkWell(
                           onTap: (){
                             Navigator.pop(context);
                           },
                             child: Icon(Icons.arrow_back_ios,color: WHITE,size: 13.sp,)),
                        SizedBox(width:2.w),
                        Text(
                          appbarTitle,
                          style: GoogleFonts.almarai(color: WHITE),
                        ),
                      ],
                    ),
                    leadingWidth: 2.w ,
                    centerTitle: false,
                    backgroundColor: BG_DARK_COLOR,
                    elevation: 0,
                    leading:
                    Container()
                    /*Padding(
                      padding:  EdgeInsetsDirectional.only(start: 14.h),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {
                        },
                      ),
                    ),*/
                  ),
                  Positioned(
                    bottom: -17.h,
                    right: 18.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            height: 30.h, width: 76.w, child: const HeaderLogo()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            ListView.separated(
              itemCount: strings.length,
              separatorBuilder: (context,index)=>SizedBox(height: 1.5.h,),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              // mainAxisSize: MainAxisSize.min,
             itemBuilder: (context,index)=>
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 2.h,bottom: 2.h),
                  child: Row(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.only(top: 1.h),
                        child: Container(
                            height: 1.h,
                            width: 5.w,
                            decoration: BoxDecoration(color: PRIMARY,shape: BoxShape.circle)),
                      ),
                      SizedBox(width: 0.2.w,),
                      Container(
                        width: 88.w,
                        child: Text(
                          strings[index],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 132,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),

            ),
          ],
        ),
      ),
    );
  }
}
