import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/login.dart';
import '../../../models/user.dart';
import '../../../constants.dart';
import '../../../end_points.dart';
import '../../../shared/network/local.dart';
import '../../../shared/network/remote.dart';
import 'states.dart';

class UserProfileCubit extends Cubit<UserProfileStates> 
{
  UserProfileCubit() : super(UserProfileInitialState());

  static UserProfileCubit get(context) => BlocProvider.of(context);

  //get user data
  late User user;

  getUserData() 
  {
    emit(GetUserDataLoadingState());

    DioHelper.postDataWithBearearToken(
            url: GETPROFILEDATA, 
            data: {}, 
            token: TOKEN.toString()
    ).then((value) {

      user = User.fromJson(value.data["data"]);

      GENDER_USER = user.gender!;
      print("-----------9-9-9-9-9-9-9-9-9-9-9-9-9-9-");

      emit(GetUserDataSucccessState(user));
      
    }).catchError((error) {
      log(error.toString());
      emit(GetUserDataErrorState(error.toString()));
    });
  }

   //update user data
  late LoginModel updateUserDataModel;

  void updateUserData(User current_user) 
  {
    emit(UpdateUserDataLoadingState());

    //Creates readable "multipart/form-data" streams.
    FormData formData = FormData.fromMap({
      "userName": current_user.userName,
      "email": current_user.email,
      "Age": current_user.age,
      "Nationality": current_user.nationality,
      "City": current_user.city,
      "Tribe": current_user.tribe,
      // "phone": current_user.phone,
      "Height": current_user.height,
      "Weight": current_user.weight,

      "nameOfJob": current_user.nameOfJob,
      "illnessType": current_user.illnessType,
      "numberOfKids": current_user.numberOfKids,
      
      "Dowry": current_user.dowry,
      "Terms": current_user.terms,
      "UserSpecifications": current_user
                              .subSpecifications
                              .map( (e) => e.toMap(UserId: current_user.id) )
                              .toList(),
      //"type":"image/png"
    });

    DioHelper.postDataWithImage(
      url: UPDATEUSERDATA,
      data: formData,
      token: TOKEN.toString(),
      length: 0      
    )
    .then((value) {
      // log(value.toString());

      updateUserDataModel = LoginModel.fromJson(value.data);
      
      NAME = CacheHelper.getData(key: "name");
      AGE = CacheHelper.getData(key: "age");
      EMAIL = CacheHelper.getData(key: "email");

      CacheHelper.saveData(key: "name", value: updateUserDataModel.data!.userName);
      CacheHelper.saveData(key: "age", value: updateUserDataModel.data!.age.toString());
      CacheHelper.saveData(key: "email", value: updateUserDataModel.data!.email);

      emit(UpdateUserDataSucccessState(updateUserDataModel));
    }).catchError((error) {
      log(error.toString());
      emit(UpdateUserDataErrorState(error.toString()));
    });
  }
}
