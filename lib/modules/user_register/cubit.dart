import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../../end_points.dart';
import '../../models/server_response_model.dart';
import '../../models/user.dart';
import '../../shared/network/remote.dart';
import 'states.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterState_Initial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void RegisterClient(User newUser, var formkey) {
    emit(RegisterState_Loading());

    if (!formkey.currentState!.validate()) {
      emit(RegisterState_Error("بعض المدخلات غير صحيحة!!"));
      return;
    }

    newUser.countryId = 3; //default to SA
    Map registeration_data = newUser.toMap();
    registeration_data['deviceIdReg'] = TOKEN;
    registeration_data['deviceType'] = TOKEN;
    registeration_data['projectName'] = TOKEN;

    DioHelper.postData(url: REGISTERCLIENT, data: registeration_data)
        .then((value) {
      ServerResponse response = ServerResponse.fromJson(value.data);
      if (response.key == 0) {
        emit(RegisterState_Error(response.msg.toString()));
        return;
      }

      emit(RegisterState_Success(response));
      emit(LoginAfterRegisterState());
    }).catchError((error) {
      emit(RegisterState_Error(error.toString()));
    });
  }
}//end class
