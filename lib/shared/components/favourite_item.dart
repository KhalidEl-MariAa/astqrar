import '../contants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class FavouriteItem extends StatelessWidget {
  final String name;
  final int gender;
  final Function onClicked;
  final Widget widget;
  const FavouriteItem(
      {Key? key,
      required this.widget,
      required this.name,
      required this.gender,
      required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onClicked();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Container(
            height: 11.5.h,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.h),
              child: Row(
                children: [
                  Image(
                    width: 14.w,
                    height: 14.h,
                    image: gender == 1
                        ? AssetImage(maleImage)
                        : AssetImage(femaleImage),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.poppins(fontSize: 10.sp),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                    ],
                  ),
                  const Spacer(),
                  widget,
                ],
              ),
            ),
          ),
        ));
  }
}
