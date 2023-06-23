import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../styles/colors.dart';

class NormalLogo extends StatelessWidget {
  final String appbarTitle;
  final bool isBack;

  NormalLogo({required this.appbarTitle, required this.isBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/appbarimage.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: AppBar(
        toolbarHeight: 13.h,
        title: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            Row(
              children: [
          if(isBack)   InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding:  EdgeInsetsDirectional.only(end: 2.w),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: white,
                        size: 13.sp,
                      ),
                    )),
                Text(
                  appbarTitle,
                  style: TextStyle(color: white),
                ),
              ],
            ),
          ],
        ),
        titleSpacing: -5.w,

        //  leadingWidth: back == false ? 10 : 56,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(width: 0,),
        /*  leading: leading ??
                    Visibility(
                      visible: back,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 25,
                          color: MyColors.white,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                actions: actions,*/
      ),
    );
  }
}
