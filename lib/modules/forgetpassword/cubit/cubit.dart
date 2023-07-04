import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../end_points.dart';
import '../../../models/forget_password.dart';
import '../../../models/server_response_model.dart';
import '../../../shared/network/remote.dart';
import 'states.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> 
{
  ForgetPasswordCubit() : super(ForgetPasswordInitialState());

  //late LoginModel loginModel;
  static ForgetPasswordCubit get(context) => BlocProvider.of(context);

  

  sendUserIdentity({required String nationalId, required String phone}) 
  {
    emit(ForgetPasswordLoadingState());
    DioHelper.postData(
      url: FORGETPASSWORD, 
      data: {
        "NationalId": nationalId,
        "phone": phone,
      }
    )
    .then((res) {
      
      if(res.data["key"] == 0){
        emit(ForgetPasswordErrorState(  res.data["msg"] ));
        return;
      }
      ActivationCode activationCode = ActivationCode.fromJson(res.data["data"]);
      
      emit(ForgetPasswordSuccessState(activationCode));
    })
    .catchError((error) {
      emit(ForgetPasswordErrorState(error.toString()));
    });
  }

  //changepassword
  late ServerResponse res;

  changePasswordByCode({
    required String userId,
    required String newPassword, 
    required String confirmPassword,
    required int code}) 
  {
    log("changing password for: " + userId);
    emit(ChangePasswordByCodeLoadingState());
    DioHelper.postData(
      url: CHANGEPASSWORDBYCODE, 
      data: {
      "userId": userId,
      "code": code,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    })
    .then((value) 
    {
      // log(value.toString());

      if (value.data['key'] == 3) {
        emit(ChangePasswordByCodeSuccessState(3));
      } else {
        emit(ChangePasswordByCodeErrorState(value.data['msg']));
      }
    })
    .catchError((error) {
      log(error.toString());
      emit(ChangePasswordByCodeErrorState(error.toString()));
    });
  }
}
