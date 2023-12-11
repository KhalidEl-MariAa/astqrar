import 'package:astarar/shared/components/components.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';
import '../../models/user.dart';

class UserItemWidget extends StatelessWidget 
{
  final Function onclickUser;
  final Function removeUser;
  final bool visibileRemoveIcon;
  final User otherUser;
  
  UserItemWidget({
      required this.otherUser,
      required this.onclickUser,
      required this.removeUser,
      required this.visibileRemoveIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onclickUser();
      },
      child: Container(
        // color: Colors.purple,
        // height: 50.h,
        child: Stack(
          children: [
            Positioned(
              top: 5,
              child: 
                // اللي شايل الصورة والاسم
                Container(
                  height: 20.h,
                  // width: 35.w,
                  decoration: BoxDecoration(
                    color: WHITE, // Colors.pink,
                  ),

                  child: Column(
                    children: [
                      Container(
                        height: 12.5.h,
                        width: 32.w,
                        decoration: 
                          BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(                            
                              opacity: this.otherUser.IsActive! ? 1.0 : 0.5,
                              fit: BoxFit.fitHeight,
                              image:  getUserImage(this.otherUser)
                            ),
                        ),
                      ),
                      
                      SizedBox(height: 0.5.h,),
                      
                      Text(
                        this.otherUser.user_Name??"--------",
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
