import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';

class UserItemWidget extends StatelessWidget 
{
  final String username;
  final int genderValue;
  final Function onclickUser;
  final Function removeUser;
  final bool visibileRemoveIcon;
  
  UserItemWidget(
      {required this.username,
      required this.genderValue,
      required this.onclickUser,
      required this.removeUser,
      required this.visibileRemoveIcon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onclickUser();
      },
      child: Container(
        height: 22.h,
        child: Stack(
          children: [
            Positioned(
              top:10,
              child: Container(
                  height: 19.h,
                  width: 35.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 14.5.h,
                        width: 32.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: genderValue == 1
                                ? AssetImage(maleImage)
                                : AssetImage(femaleImage),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        username,
                        style: GoogleFonts.almarai(fontSize: 9.sp),
                      )
                    ],
                  )),
            ),
        if(TYPE_OF_USER==2 && visibileRemoveIcon)     
          Positioned(
                top:1,
                left: 0,
                child: InkWell(
                    onTap: (){ removeUser(); },
                    child: Icon(Icons.remove_circle,color: Colors.red,size: 19.sp,)
                ))
          ],
        ),
      ),
    );
  }
}
