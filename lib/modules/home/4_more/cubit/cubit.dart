
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';
import '../../../../end_points.dart';
import '../../../../shared/network/local.dart';
import '../../../../shared/network/remote.dart';
import 'states.dart';

class MoreTabCubit extends Cubit<MoreTabStates> 
{
  MoreTabCubit() : super(SettingsInitialState());

  //late LoginModel loginModel;
  static MoreTabCubit get(context) => BlocProvider.of(context);

  void removeAccount()
  {
    emit(RemoveAccountLoadingState());

    DioHelper.postDataWithBearearToken(
      url: REMOVEACCOUNT, 
      data: {},token: 
      TOKEN.toString()
    )
    .then((value) 
    {
      if(value.statusCode==200){
        CacheHelper.saveData(key: "isLogin", value: false);
        IS_LOGIN = CacheHelper.getData(key: "isLogin");
      }
      emit(RemoveAccountSuccessState(value.statusCode!));

    }).catchError((error){
      log(error.toString());
      emit(RemoveAccountErrorState(error.toString()));
    });
  }

void logOut(){
  emit(LogoutLoadingState());
  DioHelper.postDataWithBearearToken(
    url: LOGOUT, 
    data: {
    "deviceToken":DEVICE_TOKEN
    },
    token: TOKEN.toString()
  )
  .then((value) {
    CacheHelper.sharedpreferneces.remove("gender");
    CacheHelper.sharedpreferneces.remove("email");
    CacheHelper.sharedpreferneces.remove("age");
    CacheHelper.sharedpreferneces.remove("name");
    CacheHelper.sharedpreferneces.remove("id");
    CacheHelper.sharedpreferneces.remove("token");
    CacheHelper.sharedpreferneces.remove("imgProfile");
    CacheHelper.sharedpreferneces.remove("isActive");

    CacheHelper.saveData(
        key: "isLogin", value: false);
    IS_LOGIN = CacheHelper.getData(key: "isLogin");
    emit(LogoutSuccessState());
  })
  .catchError((error){
    log(error.toString());
    emit(LogoutErrorState(error.toString()));
  });
}
}