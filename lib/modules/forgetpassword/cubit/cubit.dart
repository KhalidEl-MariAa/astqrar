import 'dart:developer';

import '../../../models/forget_password.dart';
import '../../../models/server_response_model.dart';
import 'states.dart';
import '../../../shared/contants/contants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> 
{
  ForgetPasswordCubit() : super(ForgetPasswordInitialState());

  //late LoginModel loginModel;
  static ForgetPasswordCubit get(context) => BlocProvider.of(context);

  late ForgetPassword forgetPasswordModel;

  sendCode({required String nationalId, required String phone}) 
  {
    emit(ForgetPasswordLoadingState());
    DioHelper.postData(
      url: FORGETPASSWORD, 
      data: {
        "NationalId": nationalId,
        "phone": phone,
      }
    ).then((res) {
      if(res.data["key"] == 0){
        emit(ForgetPasswordErrorState(  res.data["msg"] ));
      }
      // log(res.toString());
      forgetPasswordModel = ForgetPassword.fromJson(res.data);
      // log("code" + forgetPasswordModel.data!.code.toString());
      forgetPasswordId = forgetPasswordModel.data!.userId!;
      emit(ForgetPasswordSuccessState(forgetPasswordModel));
    }).catchError((error) {
    //  log(error.toString());
      emit(ForgetPasswordErrorState(error.toString()));
    });
  }

  //changepassword
  late ServerResponse changePasswordByCodeModel;

  changePasswordByCode({required String newPassword, required String code}) 
  {
    emit(ChangePasswordByCodeLoadingState());
    DioHelper.postData(
      url: CHANGEPASSWORDBYCODE, 
      data: {
      "userId":forgetPasswordId,
      "code":code,
      "newPassword":newPassword
    })
    .then((value) {
      log(value.toString());
      emit(ChangePasswordByCodeSuccessState(int.parse(value.toString())));

    })
    .catchError((error) {
      log(error.toString());
      emit(ChangePasswordByCodeErrorState(error.toString()));
    });
  }
}
