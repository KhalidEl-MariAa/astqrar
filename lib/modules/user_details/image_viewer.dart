
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../shared/styles/colors.dart';
import '../../shared/components/logo/normal_logo.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget 
{
  final ImageProvider theImage; 
  ImageViewer({required this.theImage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) 
  {
    return 
      Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(11.h),
              child: NormalLogo(
                appbarTitle: "استعراض" ,
                isBack: true,
              )),
          backgroundColor: WHITE,
          body: PhotoView( imageProvider: theImage )
          ),
      );
  }
}
