import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../styles/colors.dart';


class RadioButtonRegister extends StatelessWidget 
{
  final int value;
  final int? groupvalue;
  final String title;
  final Function changeFunction;
  
  final Color unselectedWidgetColor = WHITE;
  final Color textWidgetColor = WHITE;

  //Constructor
  RadioButtonRegister({
      required this.value, 
      required this.groupvalue,
      required this.title,
      required this.changeFunction});

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Row(
        children: [
          Theme(
            data: ThemeData(
              unselectedWidgetColor: this.unselectedWidgetColor,
            ),
            
            child: Radio<int>(
              activeColor: PRIMARY,
              value: value,
              groupValue: groupvalue,
              onChanged: (value) { changeFunction(); },
            ),
          ),
          Text(title,
            style: TextStyle(
              fontSize: 10.sp,
              color: this.textWidgetColor
            ),
          )
        ],
      ),
    );
  }
}

class WhiteRadioButton extends RadioButtonRegister
{
  //Constructor
  WhiteRadioButton({
    required int value, 
    required int? groupvalue,
    required String title,
    required Function changeFunction}) : 
  super(
    value: value, 
    groupvalue:  groupvalue,
    title: title,
    changeFunction: changeFunction
  );

  final Color unselectedWidgetColor = GREY;
  final Color textWidgetColor = BLACK;
}