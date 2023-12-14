
import 'dart:developer';

import 'package:astarar/end_points.dart';
import 'package:astarar/models/about_us_model.dart';
import 'package:astarar/shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

class AboutVersionCubit extends Cubit<AboutVersionStates> 
{
  AboutVersionCubit() : super(AboutVersionInitialState());

  static AboutVersionCubit get(context) => BlocProvider.of(context);
  List splittingAboutUs = [];
  
  aboutUs() 
  {
    emit(AboutUsLoadingState());
    DioHelper.postData(
      url: ABOUTUS, 
      data: {}
    )
    .then((value) 
    {
      AboutUsModel aboutUsModel = AboutUsModel.fromJson(value.data);
      splittingAboutUs = aboutUsModel.data!.aboutUs!.split("**");

      emit(AboutUsSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(AboutUsErrorState(error.toString()));
    });
  }

}