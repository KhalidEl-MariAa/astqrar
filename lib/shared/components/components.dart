import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';
import '../../models/user.dart';
import '../styles/colors.dart';

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
  Color styleText = Colors.white,
  Function? prefixPressed,
  IconData? suffix,
  Function? suffixPressed,
  bool isImage = false,
  bool isImagePrefix = false,
  String? prefixImage,
  Color borderColor = Colors.white,
  // Function? ontap,
  // bool ?autofocus,
}) {
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
      fillColor: container == null ? BG_DARK_COLOR : container,
      labelText: labelText != null ? labelText : null,
      labelStyle: GoogleFonts.almarai(
          color: labelTextcolor == null ? PRIMARY : labelTextcolor,
          fontSize: 9.sp,
          fontWeight: FontWeight.w400),
      hintText: label,
      hintStyle: GoogleFonts.almarai( color: GREY, fontSize: 10.sp),
      hintMaxLines: isLocation ? 3 : 1,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: PRIMARY),
        borderRadius: BorderRadius.circular(12.0),
      ),

      suffixIcon: isImage
          ? Padding(
              padding: EdgeInsetsDirectional.only(end: 3.w),
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
      prefixIconColor: GREY,
      focusColor: BG_DARK_COLOR,
      iconColor: GREY,

      prefixIcon: (prefixIcon == null && prefixImage == null)
          ? null
          : isImagePrefix
              ? Padding(
                  padding: EdgeInsetsDirectional.only(end: 3.w),
                  child: Image(
                    image: AssetImage(prefixImage!),
                    height: 10,
                    width: 10,
                  ),
                )
              : IconButton(
                  icon: Icon(prefixIcon),
                  onPressed: () {
                    prefixPressed!();
                  }),

      isDense: true,
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: PRIMARY),
        borderRadius: BorderRadius.circular(12.0),
      ),
      // Added this
      contentPadding: const EdgeInsets.all(5),
    ),
  );
}

//material button used in register screen and update personal data screen
Widget doubleInfinityMaterialButton({
  String? text,
  Widget? child,
  required Function onPressed,
}) {
  return Padding(
    padding: EdgeInsetsDirectional.only(start: 3.w, end: 3.w),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          color: PRIMARY),
      child: MaterialButton(
        child: (text != null)
            ? Text(
                text,
                style: GoogleFonts.almarai(color: WHITE, fontSize: 14.sp, fontWeight: FontWeight.bold),
              )
            : child,
        onPressed: () {
          onPressed();
        },
      ),
    ),
  );
}

navigateTo({required BuildContext context, required widget}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

enum ToastStates { SUCCESS, ERROR, WARNING }

showToast({required String msg, required ToastStates state}) =>
    Fluttertoast.showToast(
      msg: chooseToastIcon(state) + msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.white,
      textColor: chooseToastColor(state), //Colors.white,
      fontSize: 12.sp,
    );

String chooseToastIcon(ToastStates state) {
  switch (state) {
    case ToastStates.SUCCESS:
      return "✅ ";
    case ToastStates.WARNING:
      return "⚠️ ";
    case ToastStates.ERROR:
      return "❌ ";
    default:
      break;
  }
  return " ";
}

Color chooseToastColor(ToastStates state) 
{
  late Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = BG_DARK_COLOR;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

ImageProvider getUserImageByPath({String imgProfilePath="", int gender=1})
{
  log(imgProfilePath);
  
  if(imgProfilePath != "")
  {
    return NetworkImage(imgProfilePath);
  }else{
    return AssetImage(gender == 1? maleImage : femaleImage); 
  }
}



ImageProvider getUserImage(User? usr)
{
  if (usr == null){
    return AssetImage(DEFAULT_IMAGE);
  }else if( usr.imgProfile != "" && !(usr.hideImg??false) )
  {
    // log(usr.imgProfile??"XXXXXX img");
    return NetworkImage(usr.imgProfile??"");
  }else{
    return AssetImage(usr.gender == 1? maleImage : femaleImage); 
  }
}

// Image getUserImage(User? usr)
// {
//     return Image.network(
//       usr?.imgProfile??"",
//       fit: BoxFit.cover,
//         loadingBuilder:(
//           context, 
//           child,
//           ImageChunkEvent loadingProgress) {
//             if (loadingProgress == null) return child;
//               return Center(
//                 child: CircularProgressIndicator(
//                 value: loadingProgress.expectedTotalBytes != null ? 
//                       loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
//                       : null,
//                 ),
//               );
//         },
//     );
// }
