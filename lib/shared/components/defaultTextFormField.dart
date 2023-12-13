import 'package:astarar/shared/styles/colors.dart';
import 'package:flutter/material.dart';
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
              color: GREY,
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
