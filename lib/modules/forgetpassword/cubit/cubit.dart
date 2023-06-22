import 'dart:developer';

import '../../../models/forget_password.dart';
import '../../../models/server_response_model.dart';
import 'states.dart';
import '../../../shared/contants/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> 
{
  ForgetPasswordCubit() : super(ForgetPasswordInitialState());

  //late LoginModel loginModel;
  static ForgetPasswordCubit get(context) => BlocProvider.of(context);

  late ForgetPassword forgetPasswordModel;

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

      forgetPasswordModel = ForgetPassword.fromJson(res.data);
      forgetPasswordId = forgetPasswordModel.data!.userId!;
      emit(ForgetPasswordSuccessState(forgetPasswordModel));
    })
    .catchError((error) {
      emit(ForgetPasswordErrorState(error.toString()));
    });
  }

  //changepassword
  late ServerResponse changePasswordByCodeModel;

  changePasswordByCode({
    required String newPassword, 
    required String confirmPassword,
    required String code}) 
  {
    log("changing password for: " + forgetPasswordId!);
    emit(ChangePasswordByCodeLoadingState());
    DioHelper.postData(
      url: CHANGEPASSWORDBYCODE, 
      data: {
      "userId": forgetPasswordId,
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
