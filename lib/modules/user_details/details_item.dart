

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

/**
 * Example:
 *  DetailsItem(title: 'الجنسية', subTitle: "هندي"))
 *  DetailsItem(title: 'لون البشرة', subTitle: "قمحي"))
 */
class DetailsItem extends StatelessWidget 
{
  final String title;
  final String subTitle;

  DetailsItem({required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only( top: 1.5.h, start: 5.w),
          child: Text(
            title,
            style: GoogleFonts.almarai(fontSize: 15,fontWeight: FontWeight.w500)
          ),
        ),

        SizedBox( height: 0.5.h, ),

        Padding(
          padding: EdgeInsetsDirectional.only(start:5.w),
          child: Text(
            subTitle,
            style: GoogleFonts.almarai(color: Colors.grey[500])
          ),
        ),
      ],
    );
  }
}
