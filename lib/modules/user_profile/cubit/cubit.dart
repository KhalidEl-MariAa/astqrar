import 'dart:developer';

import 'package:astarar/models/server_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../end_points.dart';
import '../../../models/user.dart';
import '../../../shared/network/local.dart';
import '../../../shared/network/remote.dart';
import 'states.dart';

class UserProfileCubit extends Cubit<UserProfileStates> {
  UserProfileCubit() : super(UserProfileInitialState());

  static UserProfileCubit get(context) => BlocProvider.of(context);

  //get user data
  late User user;

  getUserData() {
    emit(GetUserDataLoadingState());

    DioHelper.postDataWithBearearToken(
            url: GETPROFILEDATA, data: {}, token: TOKEN.toString())
        .then((value) {
      user = User.fromJson(value.data["data"]);

      GENDER_USER = user.gender!;

      emit(GetUserDataSucccessState(user));
    }).catchError((error) {
      log(error.toString());
      emit(GetUserDataErrorState(error.toString()));
    });
  }

  //update user data
  late User updatedUser;

  void updateUserData(User current_user) {
    emit(UpdateUserDataLoadingState());

    log(current_user.subSpecifications.toString());

    //Creates readable "multipart/form-data" streams.
    FormData formData = FormData.fromMap({
      "userName": current_user.user_Name,
      "email": current_user.email,
      "Age": current_user.age,
      // "Nationality": current_user.nationality,
      "City": current_user.city,
      "Tribe": current_user.tribe,
      "phone": current_user.phone,
      "Height": current_user.height,
      "Weight": current_user.weight,

      "nameOfJob": current_user.nameOfJob,
      "illnessType": current_user.illnessType,
      "numberOfKids": current_user.numberOfKids,

      "Dowry": current_user.dowry,
      "Terms": current_user.terms,
      "UserSpecifications": current_user.subSpecifications
          .map((e) => e.toMap(UserId: current_user.id))
          .toList(),

      //"type":"image/png"
    });

    DioHelper.postDataWithImage(
      length: 0,
      token: TOKEN.toString(),
      url: UPDATEUSERDATA,
      data: formData,
    ).then((value) {
      // log(value.toString());

      ServerResponse res = ServerResponse.fromJson(value.data);

      if (res.key == 0) {
        emit(UpdateUserDataErrorState(res.msg ?? "حدث خطأ ما"));
        return;
      }

      updatedUser = User.fromJson(res.data);

      NAME = CacheHelper.getData(key: "name");
      AGE = CacheHelper.getData(key: "age");
      EMAIL = CacheHelper.getData(key: "email");

      CacheHelper.saveData(key: "name", value: updatedUser.user_Name);
      CacheHelper.saveData(
          key: "age", value: updatedUser.age.toString());
      CacheHelper.saveData(key: "email", value: updatedUser.email);

      emit(UpdateUserDataSucccessState(updatedUser));
    }).catchError((error) {
      log(error.toString());
      emit(UpdateUserDataErrorState(error.toString()));
    });
  }
}
