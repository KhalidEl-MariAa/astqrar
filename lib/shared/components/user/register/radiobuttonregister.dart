import 'package:astarar/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RadioButtonRegister extends StatelessWidget 
{
  final int value;
  final int? groupvalue;
  final String title;
  final bool isRegisterScreen;
  final Function changeFunction;

  RadioButtonRegister({required this.value,required this.isRegisterScreen,required this.groupvalue,required this.title,required this.changeFunction});

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Row(
        children: [
          Theme(
            data: ThemeData(
              //here change to your color
              unselectedWidgetColor: isRegisterScreen?white:grey,
            ),
            child: Radio<int>(
              // fillColor: MaterialStateColor.resolveWith((states) => Colors.grey),
              activeColor: primary,
              value: value,
              groupValue: groupvalue,
              onChanged: (value) { changeFunction(); },
            ),
          ),
          Text(title,style: TextStyle(fontSize: 10.sp,color: isRegisterScreen?white:black),)
        ],
      ),
    );
  }
}
