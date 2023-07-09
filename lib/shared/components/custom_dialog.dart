import 'dart:developer';

import 'package:astarar/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import '../styles/colors.dart';

class CustomDialog extends StatelessWidget {
  final String text;
  final String price;

  const CustomDialog({Key? key, required this.text, required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      contentPadding: const EdgeInsetsDirectional.only(top: 0),
      titlePadding: const EdgeInsets.only(top: 0),
      /*title: Container(
        color: Colors.white.withOpacity(0.0),
        child: Image(image: Image
            .asset("assets/whatsapp.gif")
            .image,
          height: 100, width: 180,),

        margin: EdgeInsets.symmetric(horizontal: 0),
      ),*/
      actionsPadding: const EdgeInsetsDirectional.only(top: 0),
      actionsOverflowButtonSpacing: 0,
      content: Container(
          height: 13.h,
          width: 90.w,
          decoration: BoxDecoration(
              color: WHITE, borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(
                    top: 5.h, start: 0, end: 0, bottom: 1.h),
                child: Center(
                    child: Text(
                  "السعر :${price}  ريال",
                  style: GoogleFonts.almarai(
                      color: PRIMARY,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700),
                )),
              ),
            ],
          )),
      actions: [
        Padding(
            padding: const EdgeInsetsDirectional.only(start: 0, end: 15),
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: 1.w, end: 1.w),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    color: PRIMARY),
                child: MaterialButton(
                    child: Text(
                      "اضغط هنا لمراسلة الادمن لتاكيد الدفع",
                      style: GoogleFonts.almarai(color: WHITE),
                    ),
                    onPressed: () async {
                      // Convert the WhatsAppUnilink instance to a Uri.
                      // The "launch" method is part of "url_launcher".
                      // final link = WhatsAppUnilink(
                      //   phoneNumber: ADMIN_MOBILE_PHONE,
                      //   text: text,
                      // );

                      String text = "مرحبا \n أريد التأكد من حالة الدفع ";
                      Uri uri = Uri(
                          scheme: "https", 
                          host: "wa.me",
                          path: "/${ADMIN_MOBILE_PHONE}",
                          query: "text=${text}");

                      if (await launchUrl(uri,
                          mode: LaunchMode.platformDefault)) {
                      } else {
                        showToast(
                            msg: 'Could not launch ${uri.toString()}',
                            state: ToastStates.ERROR);
                      }
                    }),
              ),
            ))
      ],
    );
  }
}
