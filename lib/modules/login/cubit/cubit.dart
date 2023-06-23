import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/login.dart';
import '../../../shared/components/components.dart';
import '../../../shared/contants/constants.dart';
import '../../../shared/network/end_points.dart';
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
        "deviceId": deviceToken
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
        
        isLogin = CacheHelper.getData(key: "isLogin");
        phone = CacheHelper.getData(key: "phone");
        token = CacheHelper.getData(key: "token");
        typeOfUser = CacheHelper.getData(key: "typeUser");
        id = CacheHelper.getData(key: "id");
        name = CacheHelper.getData(key: "name");
        age = CacheHelper.getData(key: "age");
        email = CacheHelper.getData(key: "email");
        genderUser = CacheHelper.getData(key: "gender");

        emit(ShopLoginSuccessState(loginModel));

    }).catchError((error) {
      log(error.toString());
      showToast(msg: "حصلت مشكلة ", state: ToastStates.ERROR);
      emit(ShopLoginErrorState(error.toString()));
    });
  }
}
