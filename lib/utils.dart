import 'package:astarar/constants.dart';
import 'package:astarar/end_points.dart';
import 'package:astarar/shared/components/components.dart';
import 'package:astarar/shared/network/remote.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

String formatTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inMinutes < 1) {
    return 'حالياً';
  } else if (difference.inMinutes < 60) {
    final minutes = difference.inMinutes;
    return "منذ" +
        " $minutes ${minutes >= 3 && minutes <= 10 ? 'دقائق' : 'دقيقة'} ";
  } else if (difference.inHours < 24) {
    final hours = difference.inHours;
    return "منذ" + " $hours ${hours >= 3 && hours <= 10 ? 'ساعات' : 'ساعة'} ";
  } else if (difference.inDays < 30) {
    final days = difference.inDays;
    return "منذ" + " $days ${days >= 3 && days <= 10 ? 'أيام' : 'يوم'} ";
  } else {
    final formatter = DateFormat('dd-MMM-yyyy');
    return formatter.format(dateTime);
  }
}

bool ifThereAreMoreWidgets(BuildContext context) {
  final route = ModalRoute.of(context);
  return route?.canPop ?? false;
}

//send notification
  void  sendNotificationAsync (
      {required String userid,
      required int type,
      required String body,
      required String title,
      bool save = false}) async 
  {

    DioHelper.postDataWithBearearToken(
        token: TOKEN.toString(),
        url: SENDNOTIFICATION,
        data: {
          "userId": userid,
          "notificationType": type,
          // "projectName": APP_NAME,
          // "deviceType": Platform.isIOS ? "ios" : "android",          
          "title": title,
          "body": body,
          "save": save,
        })
    .then((value) {
      // log(value.toString());
    }).catchError((error) {
      // log(error.toString());
      showToast( msg: error.toString(), state: ToastStates.ERROR );
    });
  }
