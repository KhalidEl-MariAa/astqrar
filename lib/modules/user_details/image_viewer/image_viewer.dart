
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../shared/components/loading_gif.dart';
import '../../../../shared/styles/colors.dart';
import '../../../shared/components/logo/normal_logo.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget 
{
  final ImageProvider theImage; //=  AssetImage("assets/bride_groom.jpeg");  
  ImageViewer({required this.theImage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) 
  {
    return BlocProvider(
      create: (BuildContext context) => ImageViewerCubit()..showImage(),
      child: BlocConsumer<ImageViewerCubit, AboutUsStates>(
        listener: (context, state) {},
        builder: (context, state) => Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(11.h),
                child: NormalLogo(
                  appbarTitle: "استعراض",
                  isBack: true,
                )),
            backgroundColor: WHITE,
            body: 
              ConditionalBuilder(
                condition: state is ImageViewerLoadingState,
                builder: (context)=> const LoadingGif(),
                fallback:(context)=> 
                  Container(
                    // child: PhotoView( imageProvider: AssetImage("assets/bride_groom.jpeg") )
                    child: PhotoView( imageProvider: theImage )
                  ),
              )
            ),
        ),
        
      ),
    );
  }
}
