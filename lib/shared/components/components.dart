import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';
import '../../models/user.dart';
import '../styles/colors.dart';

void navigateTo({required BuildContext context, required widget}) 
{
  Navigator.push(
    context, 
    MaterialPageRoute(
      builder: (context) => widget)
    );
}
    

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

ImageProvider getUserImageByPath({String? imgProfilePath="", int? gender=1})
{
  //log(imgProfilePath);
  imgProfilePath = imgProfilePath??"";
  gender = gender??1;
  
  if(imgProfilePath.isNotEmpty)
  {
    return NetworkImage(imgProfilePath);
  }else{
    return AssetImage(gender == 1? maleImage : femaleImage); 
  }
}



ImageProvider getUserImage(User? usr, {bool larg=false} )
{
  if (usr == null)
    return AssetImage(DEFAULT_IMAGE);

  if( usr.imgProfile != "" && !(usr.hideImg??false) )
  {
    // log(usr.imgProfile??"XXXXXX img");
    usr.imgProfile = larg ? usr.larg_imgProfile : usr.imgProfile;
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
