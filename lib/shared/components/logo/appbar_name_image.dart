import '../../../modules/login/login.dart';
import '../../contants/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../styles/colors.dart';

class AppBarWithNameAndImage extends StatelessWidget {
  const AppBarWithNameAndImage({Key? key}) : super(key: key);

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
        toolbarHeight: 15.h,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 3.h,
            ),
            Text(
              isLogin?name!:"اهلا بك ",
              style: TextStyle(color: white,fontSize: 11.sp),
            ),

            if(isLogin)    Text(
              age! + " " + "عاما",
              textAlign: TextAlign.start,
              style:
              TextStyle(color: customGrey, fontSize: 11.sp),
            ),
            if(isLogin==false)
              Row(
                children: [
                  Text(
                    "سجل دخول",
                    textAlign: TextAlign.start,
                    style:
                    TextStyle(color: white, fontSize: 10.sp),
                  ),
                  SizedBox(width: 1.w,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                    },
                    child: Text(
                      "من هنا",
                      textAlign: TextAlign.start,
                      style:
                      TextStyle(color: white, fontSize: 10.sp,decoration:TextDecoration.underline),
                    ),
                  ),
                ],
              ),
          ],
        ),
        //   titleSpacing: -10,
        leadingWidth:21.5.w,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 3.w,top:0.h ),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: white,
                  size: 13.sp,
                ),
              ),
            ),
            SizedBox(width: 2.w,),
            Padding(
              padding: EdgeInsetsDirectional.only(
                  top: 2.h, start: 0.w),
              child:
              Container(
                height: 7.h,
                width: 12.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: genderUser == 1
                            ? AssetImage(maleImage)
                            : AssetImage(
                            femaleImage))),
              ),
            ),
          ],
        ),
      //   leading: Padding(
      // padding: EdgeInsetsDirectional.only(
      // top: 2.h, start: 2.5.w),
      //   child: Container(
      //     height: 2.h,
      //     decoration: BoxDecoration(
      //         shape: BoxShape.circle,
      //         image: DecorationImage(
      //             image: genderUser == 1
      //                 ? AssetImage(maleImage)
      //                 : AssetImage(femaleImage))),
      //   )),
      ),
    );
  }
}
