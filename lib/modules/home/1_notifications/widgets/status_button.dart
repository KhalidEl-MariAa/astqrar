
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../shared/styles/colors.dart';

class StatusButton extends StatelessWidget {
  final String text;
  final Color color;
  StatusButton({required this.text,required this.color});

  @override
  Widget build(BuildContext context) {
    return   Container(
      height: 4.h,
      width: 18.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: WHITE,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

}
