import 'dart:developer';

import 'package:astarar/layout/cubit/cubit.dart';
import 'package:astarar/models/user.dart';
import 'package:astarar/models/login.dart';
import 'package:astarar/modules/user_profile_screen/cubit/states.dart';
import 'package:astarar/modules/user_profile_screen/user_profile_screen.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:astarar/shared/network/end_points.dart';
import 'package:astarar/shared/network/local.dart';
import 'package:astarar/shared/network/remote.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileCubit extends Cubit<UserProfileStates> {
  UserProfileCubit() : super(UserProfileInitialState());

  //late LoginModel loginModel;
  static UserProfileCubit get(context) => BlocProvider.of(context);

  //get user data
  late User user;
  bool getUserDataDone = false;

  getUserData() 
  {
    getUserDataDone = false;
    emit(GetUserDataLoadingState());

    DioHelper.postDataWithBearearToken(
            url: GETPROFILEDATA, 
            data: {}, 
            token: token.toString()
    ).then((value) {

      // log(value.toString());

      user = User.fromJson(value.data["data"]);

      genderUser = user.gender!;
      print("-----------9-9-9-9-9-9-9-9-9-9-9-9-9-9-");

      // listlist();
      getUserDataDone = true;
      emit(GetUserDataSucccessState(user));
      
    }).catchError((error) {
      log(error.toString());
      emit(GetUserDataErrorState(error.toString()));
    });
  }

   //update user data
  late LoginModel updateUserDataModel;

  void updateUserData(User current_user) {
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
            token: token.toString(),
            length: 0)
    .then((value) {
      // log(value.toString());

      updateUserDataModel = LoginModel.fromJson(value.data);
      
      name = CacheHelper.getData(key: "name");
      age = CacheHelper.getData(key: "age");
      email = CacheHelper.getData(key: "email");

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
