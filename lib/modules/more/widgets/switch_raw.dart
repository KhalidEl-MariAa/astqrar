
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SwitchRaw extends StatelessWidget {
  final String image;
  final String text;
  final bool value;
  SwitchRaw({required this.image,required this.text,required this.value});

  @override
  Widget build(BuildContext context) {
    return   Container(
      child: Row(
        children: [
          Image.asset(
           image,
          ),
          SizedBox(width: 8,),
          Text(text,
              style: GoogleFonts.poppins(
                  fontSize: 15, color: Colors.grey[500])),
          Spacer(),
          Switch(
            onChanged: (bool? value) {},
            value:value,
            activeColor: Colors.green,
          )
        ],
      ),
    );
  }
}
