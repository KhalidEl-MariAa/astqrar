import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../end_points.dart';
import '../../../models/server_response_model.dart';
import '../../../models/user.dart';
import '../../../shared/network/remote.dart';
import 'states.dart';
import 'dart:io' as io;

class ChangeProfileImageCubit extends Cubit<ChangeProfileImgStates> 
{
  ChangeProfileImageCubit() : super(ChangeProfileImageInitialState());

  static ChangeProfileImageCubit get(context) => BlocProvider.of(context);
  late ServerResponse res;
  late User updatedUser;

  void changeProfileImageFromGallery(String imgPath) async
  {

    if (!await io.File(imgPath).exists()){
      return;
    }
    emit(ChangeProfileImageLoadingState());

    //Creates readable "multipart/form-data" streams.n
    FormData formData = FormData.fromMap({

      "ImgProfile": await MultipartFile.fromFile(imgPath), 

    });

    DioHelper.postDataWithImage(
      length: 0,
      token: TOKEN.toString(),
      url: UPDATEPROFILEIMAGE,
      data: formData,
    ).then((value) {
      // log(value.toString());

      ServerResponse res = ServerResponse.fromJson(value.data);

      if (res.key == 0) {
        emit(ChangeProfileImageErrorState(res.msg ?? "حدث خطأ ما"));
        return;
      }

      updatedUser = User.fromJson(res.data);

      log(updatedUser.imgProfile??"imgXXXX");

      emit(ChangeProfileImageSuccessState(updatedUser));

    }).catchError((error) {
      log(error.toString());
      emit(ChangeProfileImageErrorState(error.toString()));
    });

  }


  void switchHidingImgProfile(bool hideImg) async
  {

    emit(SwitchHidingImgLodingState());


    DioHelper.postDataWithBearearToken(
      token: TOKEN.toString(),
      url: SWITCH_HIDE_IMG_PROFILE,
      data: { "hideImg" : hideImg },
    ).then((value) {
      // log(value.toString());

      ServerResponse res = ServerResponse.fromJson(value.data);

      if (res.key == 0) {
        emit(SwitchHidingImgErrorState(res.msg ?? "حدث خطأ ما"));
        return;
      }

      emit(SwitchHidingImgSuccessState(res.data['hideImg']));

    }).catchError((error) {
      log(error.toString());
      emit(SwitchHidingImgErrorState(error.toString()));
    });

  }


}



