import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/server_response_model.dart';
import '../../../shared/contants/contants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote.dart';
import 'states.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  ChangePasswordCubit() : super(ChangePasswordInitialState());

  static ChangePasswordCubit get(context) => BlocProvider.of(context);
  late ServerResponse changePasswordModel;

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
          changePasswordModel = ServerResponse.fromJson(value.data);
          emit(ChangePasswordSuccessState(changePasswordModel));
    })
        .catchError((error) {
          log(error.toString());
          emit(ChangePasswordErrorState(error.toString()));
    });
  }
}
