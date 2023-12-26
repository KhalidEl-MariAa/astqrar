import 'components.dart';
import '../styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../models/user.dart';

class UserItemWidget extends StatelessWidget 
{
  final Function onclickUser;
  final Function removeUser;
  final bool showRemoveIcon;
  final User otherUser;
  
  UserItemWidget({
      required this.otherUser,
      required this.onclickUser,
      required this.removeUser,
      required this.showRemoveIcon,
  });

  @override
  Widget build(BuildContext context) {
    return 
    InkWell(
      onTap: () {
        onclickUser();
      },
      child: 
        // اللي شايل الصورة والاسم
        Column(
          children: [
            Container(
              height: 13.h, //Must be determined
              child: 
                ClipOval(
                  child: getUserImage( this.otherUser )
                )
            ),

            SizedBox(height: 0.5.h,),                                              
            
            Text(
              this.otherUser.user_Name??"--------",
              style: GoogleFonts.almarai(fontSize: 9.sp),
            ),

            Text( this.otherUser.city??"" ),

          ],
          
        ),

    );
  }
}
