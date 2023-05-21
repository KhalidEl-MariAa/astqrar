import 'package:astarar/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class DetailsClientsDelegatesScreen extends StatelessWidget {
  const DetailsClientsDelegatesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
     textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backGround,
          toolbarHeight: 50,
          title: Text(
            "التفاصيل",
            style: TextStyle(color: Colors.white),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only( top: 2.h,start: 4.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset("assets/chat (7).png"),
                    SizedBox(
                      width: 3.w,
                    ),
                    Text(
                      "تواصل مع الخطابة",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: primary,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
            //  DetailsItemScreen(messageVisibility: false)],
        ]
          ),
        ),
      ),
    );
  }
}
