import 'dart:developer';
import 'dart:io';

import '../../../models/server_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../end_points.dart';
import '../../../models/user.dart';
import '../../../shared/network/local.dart';
import '../../../shared/network/remote.dart';
import 'states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  //late LoginModel loginModel;
  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility;
  bool isPassword = true;
  late User loggedinUser;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(LoginChangePasswordVisibility());
  }

  //to login user
  Future UserLogin(
      {required String phoneNumber, required String password}) async 
  {
    
    emit(LoginLoadingState());

    await DioHelper.postData(
      url: LOGIN, 
      data: {
      "phoneNumber": phoneNumber,
      "password": password,
      "deviceToken": DEVICE_TOKEN,
      "deviceType" : Platform.isIOS?"ios":"android",
      "projectName" : APP_NAME,
    }).then((value) async {
      // log(value.toString());

      ServerResponse res = ServerResponse.fromJson(value.data);

      if (res.key == 0) {
        emit(LoginErrorState(res.msg!));
        return;
      }

      loggedinUser = User.fromJson(res.data);

      CacheHelper.saveData(key: "id", value: loggedinUser.id);
      CacheHelper.saveData(key: "name", value: loggedinUser.user_Name);
      CacheHelper.saveData(key: "phone", value: loggedinUser.phone);
      CacheHelper.saveData(key: "token", value: loggedinUser.Token);
      CacheHelper.saveData(key: "age", value: loggedinUser.age.toString());
      CacheHelper.saveData(key: "email", value: loggedinUser.email);
      CacheHelper.saveData(key: "gender", value: loggedinUser.gender);
      CacheHelper.saveData(key: "imgProfile", value: loggedinUser.imgProfile);
      CacheHelper.saveData(key: "isActive", value: loggedinUser.IsActive);
      CacheHelper.saveData(key: "profileIsCompleted", value: loggedinUser.ProfileIsCompleted);
      

      PHONE = CacheHelper.getData(key: "phone");
      TOKEN = CacheHelper.getData(key: "token");
      ID = CacheHelper.getData(key: "id");
      NAME = CacheHelper.getData(key: "name");
      AGE = CacheHelper.getData(key: "age");
      EMAIL = CacheHelper.getData(key: "email");
      GENDER_USER = CacheHelper.getData(key: "gender");
      IMG_PROFILE = CacheHelper.getData(key: "imgProfile");
      IS_ACTIVE = CacheHelper.getData(key: "isActive");
      PROFILE_IS_COMPLETED = CacheHelper.getData(key: "profileIsCompleted");

      if (loggedinUser.status == true && !PROFILE_IS_COMPLETED)
      {
        CacheHelper.saveData(key: "isLogin", value: true);
        emit( LoginSuccessButProfileIsNotCompleted() );        
      }
      else if (loggedinUser.status == true) //|| IS_DEVELOPMENT_MODE
      {
        CacheHelper.saveData(key: "isLogin", value: true);
        emit( LoginSuccessAndActiveState() );
      } else {
        CacheHelper.saveData(key: "isLogin", value: false);
        emit( LoginSuccessButInActiveState() );
      }

      IS_LOGIN = CacheHelper.getData(key: "isLogin");
    }).catchError((error) {
      log(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }
}
