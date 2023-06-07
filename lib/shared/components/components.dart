import '../styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

Widget defaultTextFormField({
  required context,
  String? labelText,
  TextEditingController? controller,
  required TextInputType type,
  Color? container,
  Color? labelTextcolor,
  void Function(String? val)? onsubmit,
  void Function(String val)? onchange,
  bool isPassword = false,
  bool isLocation = false,
  Function? onEdition,
  required String? Function(String? val)? validate,
  required String label,
  IconData? prefixIcon,
  Color styleText=Colors.white,
  Function? prefixPressed,
  IconData? suffix,
  Function? suffixPressed,
  bool isImage = false,
  bool isImagePrefix = false,
  String?prefixImage,
  Color borderColor=Colors.white,
  // Function? ontap,
  // bool ?autofocus,
}) 
{
  return TextFormField(
    style: TextStyle(color: styleText),
    controller: controller,
    obscureText: isPassword,
    //textAlign: TextAlign.end,
    keyboardType: type,
    onFieldSubmitted: onsubmit,
    onChanged: onchange,
    //onEditingComplete: (){onEdition!();},
    autocorrect: true,
    validator: validate,

    autovalidateMode: AutovalidateMode.onUserInteraction,
    readOnly: isLocation ? true : false,
    decoration: InputDecoration(

      filled: true,
      fillColor: container==null?backGround:container,
      labelText: labelText != null ? labelText : null,
      labelStyle: GoogleFonts.almarai(color:  labelTextcolor==null?primary:labelTextcolor,fontSize: 9.sp,fontWeight: FontWeight.w400),
      hintText: label,
      hintStyle: TextStyle(
        color: grey,
        fontSize: 11.sp,
      ),
      hintMaxLines: isLocation ? 3 : 1,
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: borderColor),borderRadius: BorderRadius.circular(12)),
      // borderSide: const BorderSide(color: Colors.white54),
      // borderRadius: BorderRadius.circular(50.0)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
         borderRadius: BorderRadius.circular(12.0),
      ),

      suffixIcon: isImage
          ? Padding(
              padding:  EdgeInsetsDirectional.only(end: 3.w),
              child: const Image(
                image: AssetImage("images/phoneIcon.png"),
                height: 10,
                width: 10,
              ),
            )
          : IconButton(
              icon: Icon(suffix),
              onPressed: () {
                suffixPressed!();
              }),
      prefixIconColor: grey,
      focusColor: backGround,
      iconColor: grey,

      prefixIcon: (prefixIcon==null && prefixImage==null)? null :
        isImagePrefix? 
          Padding(
              padding:  EdgeInsetsDirectional.only(end: 3.w),
              child: Image(
                image: AssetImage(prefixImage!),
                height: 10,
                width: 10,
              ),
            )
          : 
          IconButton(
            icon: Icon(prefixIcon),
            onPressed: () { prefixPressed!(); }
          ),

      isDense: true,
      errorBorder:OutlineInputBorder(
        borderSide: BorderSide(color: primary),
        borderRadius: BorderRadius.circular(12.0),
      ) ,
      // Added this
      contentPadding: const EdgeInsets.all(5),
    ),
  );
}

//material button used in register screen and update personal data screen
Widget doubleInfinityMaterialButton({
  required String text,
  required Function onPressed,
}) {
  return Padding(
    padding:  EdgeInsetsDirectional.only(start: 3.w, end: 3.w),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          color: primary
      ),

      child: MaterialButton(
        child: 
        Text( text, style:  TextStyle(color: white),
      ),

      onPressed: () { onPressed(); },
      ),
    ),
  );
}

navigateTo({required BuildContext context,required widget})=>
    Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));

enum ToastStates { SUCCESS, ERROR, WARNING }

showToast({required String msg, required ToastStates state}) =>
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.white,
      textColor: chooseToastColor(state), //Colors.white,
      fontSize: 12.sp,
    );

Color chooseToastColor(ToastStates state) 
{
  late Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green; 
      break;
    case ToastStates.WARNING:
      color = backGround; 
      break;
    case ToastStates.ERROR:
      color = Colors.red; 
      break;
  }
  return color;
}