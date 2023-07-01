

import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:upgrader/upgrader.dart';

Widget MyUpgrader({
  required BuildContext context, 
  required Widget child})
{
    return Directionality(
      textDirection: TextDirection.rtl, 
      child:     
      UpgradeAlert
      (
          upgrader: 
            Upgrader(
              messages: UpgraderMessages(code: 'ar'),
              languageCode:"ar",
              minAppVersion: "2.1.1",
              canDismissDialog: true,
              durationUntilAlertAgain: const Duration(days: 7),
              dialogStyle:  Platform.isIOS? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material
            ),
          child: child,
      )

    );
}
