import 'dart:developer';

import '../../../../../models/server_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants.dart';
import '../../../../../end_points.dart';
import '../../../../../models/user.dart';
import '../../../../../shared/network/remote.dart';
import 'states.dart';

class AccountCubit extends Cubit<AccountStates> 
{
  AccountCubit() : super(AccountInitialState());

  static AccountCubit get(context) => BlocProvider.of(context);


  //get user data
  late User user;

  getUserData() 
  {
    emit(AccountLoading());

    DioHelper.postDataWithBearearToken(
            url: GETUSERDATA, 
            data: {}, 
            token: TOKEN.toString())
    .then((value) 
    {
      ServerResponse res = ServerResponse.fromJson(value.data);
      user = User.fromJson(res.data);

      emit(AccountSuccess(user));
    }).catchError((error) {
      log(error.toString());
      emit(AccountError(error.toString()));
    });
  }

}
