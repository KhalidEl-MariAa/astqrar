import 'package:astarar/models/get_information_user.dart';
import 'package:astarar/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';
import '../../../models/user.dart';

class UserItemWidget extends StatelessWidget 
{
  final String username;
  final int genderValue;
  final Function onclickUser;
  final Function removeUser;
  final bool visibileRemoveIcon;
  late User otherUser;
  // late UserItem otherUserItem;
  
  UserItemWidget(
      {required this.username,
      required this.genderValue,
      required this.onclickUser,
      required this.removeUser,
      required this.visibileRemoveIcon,
      required this.otherUser });

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
                            opacity: this.otherUser.IsActive! ? 1.0 : 0.5,
                            fit: BoxFit.cover,
                            image:  getUserImage(this.otherUser)
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
