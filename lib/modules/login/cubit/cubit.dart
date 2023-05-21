import 'dart:developer';

import 'package:astarar/models/login.dart';
import 'package:astarar/modules/login/cubit/states.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:astarar/shared/network/end_points.dart';
import 'package:astarar/shared/network/local.dart';
import 'package:astarar/shared/network/remote.dart';
import 'package:flutter/material.dart';

import "package:bloc/bloc.dart";
import 'package:flutter_bloc/flutter_bloc.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  //late LoginModel loginModel;
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility;
  bool isPassword = true;
  late LoginModel loginModel;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ShopLoginChangePasswordVisibility());
  }

  //to login user
  Future UserLogin({required String nationalId, required String password}) async {
    // log(nationalId);
    // log(password);
    // log(deviceToken.toString());
    // emit(ShopLoginLoadingState());
    // print("token login"+deviceToken.toString());
    log(LOGIN);

    await DioHelper.postData(url: LOGIN, 
      data: {
        "NationalID": nationalId,
        "password": password,
        "deviceId": deviceToken
      })
      .then((value) async {
        // log(value.toString());
        loginModel = LoginModel.fromJson(value.data);

        if(loginModel.key==1&&loginModel.data!.status==true){
          CacheHelper.saveData( key: "token", value: loginModel.data!.token);
          token = CacheHelper.getData(key: "token");
          CacheHelper.saveData( key: "typeUser", value: loginModel.data!.typeUser!);
          typeOfUser = CacheHelper.getData(key: "typeUser");
          CacheHelper.saveData( key: "id", value: loginModel.data!.id);
          id = CacheHelper.getData(key: "id");
          CacheHelper.saveData( key: "name", value: loginModel.data!.userName);
          name = CacheHelper.getData(key: "name");
          CacheHelper.saveData( key: "age", value: loginModel.data!.age.toString());
          age = CacheHelper.getData(key: "age");
          CacheHelper.saveData( key: "email", value: loginModel.data!.email);
          email = CacheHelper.getData(key: "email");
          CacheHelper.saveData( key: "gender", value: loginModel.data!.gender);
          genderUser = CacheHelper.getData(key: "gender");
          CacheHelper.saveData(key: "phone", value: loginModel.data!.phone);
          phone=CacheHelper.getData(key: "phone");
          CacheHelper.saveData(
              key: "isLogin", value: true);
          isLogin = CacheHelper.getData(key: "isLogin");
      }
if(loginModel.key==1&&loginModel.data!.status==false){
  CacheHelper.saveData(
      key: "isLogin", value: false);
  isLogin = CacheHelper.getData(key: "isLogin");
  CacheHelper.saveData(key: "phone", value: loginModel.data!.phone);
  phone=CacheHelper.getData(key: "phone");
  CacheHelper.saveData(
      key: "token", value: loginModel.data!.token);
  token = CacheHelper.getData(key: "token");
  CacheHelper.saveData(
      key: "typeUser", value: loginModel.data!.typeUser!);
      typeOfUser = CacheHelper.getData(key: "typeUser");
      CacheHelper.saveData(
      key: "id", value: loginModel.data!.id);
      id = CacheHelper.getData(key: "id");
      CacheHelper.saveData(
      key: "name", value: loginModel.data!.userName);
      name = CacheHelper.getData(key: "name");
      CacheHelper.saveData(
      key: "age", value: loginModel.data!.age.toString());
      age = CacheHelper.getData(key: "age");
      CacheHelper.saveData(
      key: "email", value: loginModel.data!.email);
      email = CacheHelper.getData(key: "email");
      CacheHelper.saveData(
      key: "gender", value: loginModel.data!.gender);
      genderUser = CacheHelper.getData(key: "gender");
}
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      log(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }
}
