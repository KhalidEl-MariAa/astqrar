import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../../shared/contants/constants.dart';
import '../../../../shared/styles/colors.dart';
import '../cubit/cubit.dart';
import 'status_button.dart';

class AcceptNotification extends StatelessWidget 
{
  final int notificationType;
  final String userName;
  final int gender;
  final String userId;
  final String message;
  final Function clickUser;
  final String time;
  
  AcceptNotification(
      {required this.notificationType,
      required this.time,
      required this.clickUser,
      required this.userName,
      required this.gender,
      required this.userId,
      required this.message});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        clickUser();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
        child: Container(
          height: notificationType == 0 ? 12.h : 11.h,
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
                        image: gender == 1
                            ? AssetImage(maleImage)
                            : AssetImage(femaleImage))),
              ),
              SizedBox(
                width: 3.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: notificationType == 0 ? 50.w : 70.w,
                    child: Text(
                      notificationType == 0
                          ? "تم ارسال طلب محادثة من قبل ${userName}"
                          : notificationType == 1
                              ? "تمت الموافقة علي طلب المحادثة من قبل ${userName}"
                              : notificationType == 2
                                  ? "تم رفض طلب المحادثة من قبل ${userName}"
                                  : notificationType == 3
                                      ? message
                                      : "",
                      style: GoogleFonts.poppins( fontSize: 9.sp, fontWeight: FontWeight.w600),
                    ),
                  ),

                  SizedBox( height: 2.h,),

                  if (notificationType == 0)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () {
                              NotificationCubit.get(context).acceptChattRequest(userId: userId);
                              // showDialog(
                              //     context: context,
                              //     builder: (context) => SuccessDialog());
                            },
                            child: StatusButton(text: "قبول", color: primary)),
                        SizedBox(
                          width: 3.w,
                        ),
                        InkWell(
                            onTap: () {
                              NotificationCubit.get(context).ignoreRequest(userId: userId);
                            },
                            child: StatusButton(text: "رفض", color: Colors.red)),
                      ],
                    ),
                  if (notificationType != 0)
                    Text(
                      DateFormat.yMMMMd().format(DateTime.parse(time)),
                      //    "12 Aug , 5:20 Pm",
                      style: GoogleFonts.poppins(
                          color: customGrey, fontSize: 7.sp),
                    )
                ],
              ),
              if (notificationType == 0) const Spacer(),
              if (notificationType == 0)
                Text(
                  DateFormat.yMMMEd().format(DateTime.parse(time)),
                  style: GoogleFonts.poppins(color: customGrey, fontSize: 7.sp),
                )
            ],
          ),
        ),
      ),
    );
  }
}
