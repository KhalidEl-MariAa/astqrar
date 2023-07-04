import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../end_points.dart';
import '../../../models/server_response_model.dart';
import '../../../shared/network/remote.dart';
import 'states.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  ChangePasswordCubit() : super(ChangePasswordInitialState());

  static ChangePasswordCubit get(context) => BlocProvider.of(context);
  late ServerResponse res;

  void changePassword({required String oldPassword, required String newPassword}) 
  {
    emit(ChangePasswordLoadingState());
    DioHelper.postDataWithBearearToken(
        url: CHANGEPASSWORD, 
        data: {
          "id": ID,
          "oldPassword": oldPassword,
          "newPassword": newPassword
        }, 
        token: TOKEN.toString()
    )
    .then((value) {
        
        // log(value.data.toString());
        res = ServerResponse.fromJson(value.data);
        if(res.key == 0){
          emit(ChangePasswordErrorState( res.msg.toString() ));
          return;
        }
        emit(ChangePasswordSuccessState(res));
    })
    .catchError((error){
        log(error.toString());
        emit(ChangePasswordErrorState(error.toString()));
    });
  }
}
