
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CheckedBoxRegister extends StatelessWidget {
  Function onchanged;
  bool isSelected;
  Color focusColor;
  Color TextColor;
  String text;
  CheckedBoxRegister({required this.onchanged,required this.text,required this.isSelected,required this.focusColor,required this.TextColor});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Checkbox(
            value: isSelected,
            onChanged: (bool? value) {
             onchanged();
            },

//            fillColor:MaterialStateColor.resolveWith((states) =>Colors.white) ,
            focusColor: focusColor,
            autofocus: true),
        Container(
          width: 75.w,
          child: Text(
              text,
              maxLines: 2,
              style: TextStyle(color: TextColor, fontSize: 10.sp)),
        )
      ],
    );
  }
}
