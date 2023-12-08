import 'dart:developer';
import 'dart:io';

import 'package:astarar/models/server_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../end_points.dart';
import '../../../models/user.dart';
import '../../../shared/network/local.dart';
import '../../../shared/network/remote.dart';
import 'states.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  //late LoginModel loginModel;
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility;
  bool isPassword = true;
  late User loggedinUser;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ShopLoginChangePasswordVisibility());
  }

  //to login user
  Future UserLogin(
      {required String phoneNumber, required String password}) async 
  {
    
    emit(ShopLoginLoadingState());

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
        emit(ShopLoginErrorState(res.msg!));
        return;
      }

      loggedinUser = User.fromJson(res.data);

      CacheHelper.saveData(key: "phone", value: loggedinUser.phone);
      CacheHelper.saveData(key: "token", value: loggedinUser.Token);
      CacheHelper.saveData(key: "typeUser", value: loggedinUser.typeUser);
      CacheHelper.saveData(key: "id", value: loggedinUser.id);
      CacheHelper.saveData(key: "name", value: loggedinUser.user_Name);
      CacheHelper.saveData(key: "age", value: loggedinUser.age.toString());
      CacheHelper.saveData(key: "email", value: loggedinUser.email);
      CacheHelper.saveData(key: "gender", value: loggedinUser.gender);
      CacheHelper.saveData(key: "imgProfile", value: loggedinUser.imgProfile);
      CacheHelper.saveData(key: "isActive", value: loggedinUser.IsActive);

      PHONE = CacheHelper.getData(key: "phone");
      TOKEN = CacheHelper.getData(key: "token");
      TYPE_OF_USER = CacheHelper.getData(key: "typeUser");
      ID = CacheHelper.getData(key: "id");
      NAME = CacheHelper.getData(key: "name");
      AGE = CacheHelper.getData(key: "age");
      EMAIL = CacheHelper.getData(key: "email");
      GENDER_USER = CacheHelper.getData(key: "gender");
      IMG_PROFILE = CacheHelper.getData(key: "imgProfile");
      IS_ACTIVE = CacheHelper.getData(key: "isActive");

      if (loggedinUser.status == true) //|| IS_DEVELOPMENT_MODE
      {
        CacheHelper.saveData(key: "isLogin", value: true);
        emit(ShopLoginSuccessAndActiveState());
      } else {
        CacheHelper.saveData(key: "isLogin", value: false);
        emit(ShopLoginSuccessButInActiveState());
      }

      IS_LOGIN = CacheHelper.getData(key: "isLogin");
    }).catchError((error) {
      log(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }
}
