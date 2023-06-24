import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/login.dart';
import '../../../shared/components/components.dart';
import '../../../constants.dart';
import '../../../end_points.dart';
import '../../../shared/network/local.dart';
import '../../../shared/network/remote.dart';
import 'states.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates> 
{
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
  Future UserLogin({required String nationalId, required String password}) async 
  {
    emit(ShopLoginLoadingState());
    log(LOGIN);

    await DioHelper.postData(
      url: LOGIN, 
      data: {
        "NationalID": nationalId,
        "password": password,
        "deviceId": DEVICE_TOKEN
      })
      .then((value) async {
        // log(value.toString());
        loginModel = LoginModel.fromJson(value.data);

        if (loginModel.key==0){
          emit(ShopLoginErrorState(loginModel.msg!));
          return;
        }

        CacheHelper.saveData( key: "phone", value: loginModel.data!.phone);
        CacheHelper.saveData( key: "token", value: loginModel.data!.token);
        CacheHelper.saveData( key: "typeUser", value: loginModel.data!.typeUser!);
        CacheHelper.saveData( key: "id", value: loginModel.data!.id);
        CacheHelper.saveData( key: "name", value: loginModel.data!.userName);
        CacheHelper.saveData( key: "age", value: loginModel.data!.age.toString());
        CacheHelper.saveData( key: "email", value: loginModel.data!.email);
        CacheHelper.saveData( key: "gender", value: loginModel.data!.gender);

        if( loginModel.data!.status==true || IS_DEVELOPMENT_MODE) 
        {
          CacheHelper.saveData( key: "isLogin", value: true);
        }else {
          CacheHelper.saveData(key: "isLogin", value: false);
        }
        
        IS_LOGIN = CacheHelper.getData(key: "isLogin");
        PHONE = CacheHelper.getData(key: "phone");
        TOKEN = CacheHelper.getData(key: "token");
        TYPE_OF_USER = CacheHelper.getData(key: "typeUser");
        ID = CacheHelper.getData(key: "id");
        NAME = CacheHelper.getData(key: "name");
        AGE = CacheHelper.getData(key: "age");
        EMAIL = CacheHelper.getData(key: "email");
        GENDER_USER = CacheHelper.getData(key: "gender");

        emit(ShopLoginSuccessState(loginModel));

    }).catchError((error) {
      log(error.toString());
      showToast(msg: "حصلت مشكلة ", state: ToastStates.ERROR);
      emit(ShopLoginErrorState(error.toString()));
    });
  }
}
