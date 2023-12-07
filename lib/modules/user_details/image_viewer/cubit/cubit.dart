import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../end_points.dart';
import '../../../../../models/about_us_model.dart';
import '../../../../../shared/network/remote.dart';
import 'states.dart';

class ImageViewerCubit extends Cubit<AboutUsStates> {
  ImageViewerCubit() : super(AboutUsInitialState());

  static ImageViewerCubit get(context) => BlocProvider.of(context);
  late AboutUsModel aboutUsModel;
  List splittingAboutUs = [];

  showImage() 
  {
    emit(ImageViewerLoadingState());
    DioHelper.postData(
      url: ABOUTUS, 
      data: {}
    )
    .then((value) 
    {
      aboutUsModel = AboutUsModel.fromJson(value.data);
      splittingAboutUs = aboutUsModel.data!.aboutUs!.split("**");

      emit(AboutUsSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(AboutUsErrorState(error.toString()));
    });
  }
}
