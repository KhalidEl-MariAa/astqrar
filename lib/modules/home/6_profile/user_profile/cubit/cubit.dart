import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants.dart';
import '../../../../../end_points.dart';
import '../../../../../models/server_response_model.dart';
import '../../../../../models/user.dart';
import '../../../../../shared/network/local.dart';
import '../../../../../shared/network/remote.dart';
import 'states.dart';

class UserProfileCubit extends Cubit<UserProfileStates> 
{
  UserProfileCubit() : super(UserProfileInitialState());

  static UserProfileCubit get(context) => BlocProvider.of(context);

  //get user data
  late User user;

  void getUserData() {
    emit(GetUserDataLoadingState());

    DioHelper.postDataWithBearearToken(
            url: GETUSERDATA, data: {}, 
            token: TOKEN.toString())
    .then((value) 
    {
      user = User.fromJson(value.data["data"]);
      emit(GetUserDataSucccessState(user));

    }).catchError((error) {
      log(error.toString());
      emit(GetUserDataErrorState(error.toString()));
    });
  }

  //update user data
  late User updatedUser;

  void updateUserData(User current_user) 
  {
    emit(UpdateUserDataLoadingState());

    log(current_user.subSpecifications.toString());

    //Creates readable "multipart/form-data" streams.
    FormData formData = FormData.fromMap(
    {
      //"type":"image/png"
      "gender": current_user.gender,
      "user_Name": current_user.user_Name,
      "email": current_user.email,
      "Age": current_user.age,
      "countryId": current_user.countryId,
      // "Nationality": current_user.nationality,
      "City": current_user.city,
      "phone": current_user.phone,
      "Height": current_user.height,
      "Weight": current_user.weight,

      "Tribe": current_user.tribe,
      "nameOfJob": current_user.nameOfJob,
      "illnessType": current_user.illnessType,
      "numberOfKids": current_user.numberOfKids,

      "Dowry": current_user.dowry,
      "Terms": current_user.terms,
      "UserSpecifications": current_user.subSpecifications
          .map((e) => e.toMap(UserId: current_user.id))
          .toList(),

      "profileIsCompleted": true,
      
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

      CacheHelper.saveData(key: "name", value: updatedUser.user_Name);
      CacheHelper.saveData(key: "age", value: updatedUser.age.toString());
      CacheHelper.saveData(key: "email", value: updatedUser.email);
      CacheHelper.saveData(key: "profileIsCompleted", value: updatedUser.ProfileIsCompleted);
      CacheHelper.saveData(key: "gender", value: updatedUser.gender);
      CacheHelper.saveData(key: "phone", value: updatedUser.phone);
      CacheHelper.saveData(key: "imgProfile", value: updatedUser.imgProfile);

      NAME = CacheHelper.getData(key: "name");
      AGE = CacheHelper.getData(key: "age");
      EMAIL = CacheHelper.getData(key: "email");
      PROFILE_IS_COMPLETED = CacheHelper.getData(key: "profileIsCompleted");
      GENDER_USER = CacheHelper.getData(key: "gender");
      PHONE = CacheHelper.getData(key: "phone");
      IMG_PROFILE = CacheHelper.getData(key: "imgProfile");

      emit(UpdateUserDataSucccessState(updatedUser));
    }).catchError((error) {
      log(error.toString());
      emit(UpdateUserDataErrorState(error.toString()));
    });
  }

  bool? isDuplicatedUserName;
  void checkDuplicatedUserName(String user_Name) 
  {
    emit(CheckUserNameLoadingState());
    
    DioHelper.postDataWithBearearToken(
      token: TOKEN.toString(),
      url: "api/v1/CheckDuplicatedUserName",
      data: {
        "user_Name" : user_Name,
      },
    ).then((value) {

      ServerResponse res = ServerResponse.fromJson(value.data);

      if (res.key == 0) {
        emit(CheckUserNameErrorState(res.msg ?? "حدث خطأ ما"));
        return;
      }

      this.isDuplicatedUserName = res.data;
      emit(CheckUserNameSuccessState());

    }).catchError((error) {
      log(error.toString());
      emit(CheckUserNameErrorState(error.toString()));
    });

  }
  
} //end class
