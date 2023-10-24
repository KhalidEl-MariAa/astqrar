import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../end_points.dart';
import '../../../models/server_response_model.dart';
import '../../../models/user.dart';
import '../../../shared/network/remote.dart';
import 'states.dart';

class ChangeProfileImageCubit extends Cubit<ChangeProfileImgStates> 
{
  ChangeProfileImageCubit() : super(ChangeProfileImageInitialState());

  static ChangeProfileImageCubit get(context) => BlocProvider.of(context);
  late ServerResponse res;
  late User updatedUser;

  void changeProfileImageFromGallery(String imgPath) async
  {

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

} //end class


