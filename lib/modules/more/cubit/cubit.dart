
import 'dart:developer';

import 'package:astarar/modules/more/cubit/states.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:astarar/shared/network/end_points.dart';
import 'package:astarar/shared/network/local.dart';
import 'package:astarar/shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(SettingsInitialState());

  //late LoginModel loginModel;
  static SettingsCubit get(context) => BlocProvider.of(context);

  removeAccount(){
    emit(RemoveAccountLoadingState());
    DioHelper.postDataWithBearearToken(url: REMOVEACCOUNT, data: {},token: token.toString())
    .then((value) {
      if(value.statusCode==200){
        CacheHelper.saveData(
            key: "isLogin", value: false);
        isLogin = CacheHelper.getData(key: "isLogin");
      }
    emit(RemoveAccountSuccessState(value.statusCode!));

    }).catchError((error){
      log(error.toString());
      emit(RemoveAccountErrorState(error.toString()));
    });
  }

logOut(){
  emit(LogoutLoadingState());
  DioHelper.postDataWithBearearToken(url: LOGOUT, data: {
    "deviceId":deviceToken
  },token: token.toString()).then((value) {
    CacheHelper.sharedpreferneces.remove("gender");
    CacheHelper.sharedpreferneces.remove("email");
    CacheHelper.sharedpreferneces.remove("age");
    CacheHelper.sharedpreferneces.remove("name");
    CacheHelper.sharedpreferneces.remove("id");
    CacheHelper.sharedpreferneces.remove("token");
    CacheHelper.saveData(
        key: "isLogin", value: false);
    isLogin = CacheHelper.getData(key: "isLogin");
    emit(LogoutSuccessState());
  })
      .catchError((error){
    log(error.toString());
    emit(LogoutErrorState(error.toString()));
  });
}
}