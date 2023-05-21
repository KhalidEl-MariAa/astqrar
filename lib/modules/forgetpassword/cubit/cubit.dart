import 'dart:developer';

import 'package:astarar/models/forget_password.dart';
import 'package:astarar/models/register_delegate_model.dart';
import 'package:astarar/modules/forgetpassword/cubit/states.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:astarar/shared/network/end_points.dart';
import 'package:astarar/shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  ForgetPasswordCubit() : super(ForgetPasswordInitialState());

  //late LoginModel loginModel;
  static ForgetPasswordCubit get(context) => BlocProvider.of(context);

  late ForgetPassword forgetPasswordModel;

  sendCode({required String nationalId}) {
    emit(ForgetPasswordLoadingState());
    DioHelper.postData(url: FORGETPASSWORD, data: {"NationalId": nationalId})
        .then((value) {
      log(value.toString());
      forgetPasswordModel = ForgetPassword.fromJson(value.data);
     log("code" + forgetPasswordModel.data!.code.toString());
      forgetPasswordId = forgetPasswordModel.data!.userId!;
      emit(ForgetPasswordSuccessState(forgetPasswordModel));
    }).catchError((error) {
     log(error.toString());
      emit(ForgetPasswordErrorState(error.toString()));
    });
  }



  //changepassword

  late RegisterDelegateModel changePasswordByCodeModel;

  changePasswordByCode({required String newPassword,required String code}) {
    emit(ChangePasswordByCodeLoadingState());
    DioHelper.postData(url: CHANGEPASSWORDBYCODE, data: {
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
