import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants.dart';
import '../../../../models/get_notifications.dart';
import '../../../../models/user.dart';
import '../../../../shared/styles/colors.dart';
import '../../../user_details/cubit/cubit.dart';
import '../../../user_details/user_details.dart';
import '../cubit/cubit.dart';
import 'status_button.dart';

class NotificationWiget extends StatelessWidget 
{
  // final int notificationType;
  // final String userName;
  // final int gender;
  // final String userId;
  // final String message;
  // final Function clickUser;
  // final String time;

  // NotificationWiget(
  //     {required this.notificationType,
  //     required this.time,
  //     required this.clickUser,
  //     required this.userName,
  //     required this.gender,
  //     required this.userId,
  //     required this.message});

  final NotificationDetailsModel note;
  final User user;
  // final Function clickUser;

  NotificationWiget({    
    required this.note,
    required this.user,
    // required this.clickUser,
  });
  

  @override
  Widget build(BuildContext context) 
  {
    return InkWell(
      onTap: () {
        // clickUser();

        if (this.user.typeUser ==1) 
        {
          UserDetailsCubit.get(context)
              .getOtherUser( otherId: this.user.id!);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserDetailsScreen(
                        messageVisibility: true,
                      )));
        }

      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
        child: Container(
          height: this.note.notificationType == 0 ? 12.h : 11.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 18.w,
                height: 10.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    image: DecorationImage(
                        image: 
                        this.note.notificationType == 10 ? 
                          AssetImage("assets/icon.png")
                        :
                        this.user.gender == 1 ? 
                          AssetImage(maleImage)
                        : 
                          AssetImage(femaleImage)
                    )),
              ),
              SizedBox(
                width: 3.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: this.note.notificationType == 0 ? 50.w : 70.w,
                    child: Text(
                      this.note.notificationType == 0 ?  
                      "تم ارسال طلب محادثة من قبل ${this.user.user_Name}"
                      : 
                      this.note.notificationType == 1 ? 
                      "تمت الموافقة علي طلب المحادثة من قبل ${this.user.user_Name}"
                      :
                      this.note.notificationType == 2 ? 
                      "تم رفض طلب المحادثة من قبل ${this.user.user_Name}"
                      :
                      this.note.notificationType == 3 ? 
                      this.note.message!
                      :
                      this.note.message!
                      ,
                      style: GoogleFonts.poppins( fontSize: 9.sp, fontWeight: FontWeight.w600),
                    ),
                  ),

                  SizedBox( height: 2.h,),

                  if (this.note.notificationType == 0)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () {
                              NotificationCubit.get(context).acceptChattRequest(userId: this.user.id!);
                              // showDialog(
                              //     context: context,
                              //     builder: (context) => SuccessDialog());
                            },
                            child: StatusButton(text: "قبول", color: PRIMARY)),
                        SizedBox( width: 3.w,),
                        InkWell(
                            onTap: () {
                              NotificationCubit.get(context).ignoreRequest(userId: this.user.id!);
                            },
                            child: StatusButton(text: "رفض", color: Colors.red)),
                      ],
                    ),
                  if (this.note.notificationType != 0)
                    Text(
                      DateFormat.yMMMMd().format(DateTime.parse(this.note.time??"")),
                      //    "12 Aug , 5:20 Pm",
                      style: GoogleFonts.poppins(
                          color: CUSTOME_GREY, fontSize: 7.sp),
                    )
                ],
              ),
              if (this.note.notificationType == 0) const Spacer(),
              if (this.note.notificationType == 0)
                Text(
                  DateFormat.yMMMEd().format(DateTime.parse(this.note.time??"")),
                  style: GoogleFonts.poppins(color: CUSTOME_GREY, fontSize: 7.sp),
                )
            ],
          ),
        ),
      ),
    );
  }
}
