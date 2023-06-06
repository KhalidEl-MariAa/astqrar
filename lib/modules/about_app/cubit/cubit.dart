import 'dart:developer';

import '../../../models/about_us_model.dart';
import 'states.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutUsCubit extends Cubit<AboutUsStates> {
  AboutUsCubit() : super(AboutUsInitialState());

  //late LoginModel loginModel;
  static AboutUsCubit get(context) => BlocProvider.of(context);
  late AboutUsModel aboutUsModel;
  List splittingAboutUs = [];
bool getAboutUsDone=false;
  aboutUs() {
    getAboutUsDone=false;
    emit(AboutUsLoadingState());
    DioHelper.postData(url: ABOUTUS, data: {}).then((value) {
      aboutUsModel = AboutUsModel.fromJson(value.data);
      splittingAboutUs = aboutUsModel.data!.aboutUs!.split("**");
      log(splittingAboutUs[2]);
      getAboutUsDone=true;
      emit(AboutUsSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(AboutUsErrorState(error.toString()));
    });
  }
}
