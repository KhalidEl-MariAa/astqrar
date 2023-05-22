import 'dart:developer';

import 'package:astarar/models/register_delegate_model.dart';
import 'package:astarar/modules/change_password/cubit/states.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:astarar/shared/network/end_points.dart';
import 'package:astarar/shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  ChangePasswordCubit() : super(ChangePasswordInitialState());

  static ChangePasswordCubit get(context) => BlocProvider.of(context);
  late RegisterDelegateModel changePasswordModel;

  changePassword({required String oldPassword, required String newPassword}) {
    emit(ChangePasswordLoadingState());
    DioHelper.postDataWithBearearToken(
            url: CHANGEPASSWORD, data: {
              "id":id,
      "oldPassword":oldPassword,
      "newPassword":newPassword
    }, token: token.toString())
        .then((value) {
          log(value.data);
          changePasswordModel=RegisterDelegateModel.fromJson(value.data);
          emit(ChangePasswordSuccessState(changePasswordModel));
    })
        .catchError((error) {
          log(error.toString());
          emit(ChangePasswordErrorState(error.toString()));
    });
  }
}
