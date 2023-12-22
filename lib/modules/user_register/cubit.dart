import 'dart:developer';
import 'dart:io';

import 'package:astarar/utils.dart';
import 'package:device_info_plus/device_info_plus.dart';
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

  void RegisterClient(User newUser, var formkey) async
  {
    emit(RegisterState_Loading());

    if (!formkey.currentState!.validate()) {
      emit(RegisterState_Error("بعض المدخلات غير صحيحة!!"));
      return;
    }

    String deviceName = "Unkown";
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid){
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceName = androidInfo.manufacturer.capitalize() + " " +  androidInfo.model;
    }
    if(Platform.isIOS){
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.utsname.machine;
    }

    newUser.countryId = 3; //default to SA
    Map registeration_data = newUser.toMap();
    registeration_data['deviceToken'] = DEVICE_TOKEN;
    registeration_data['deviceType'] = Platform.isIOS ? "ios" : "android";
    registeration_data['deviceName'] = deviceName;

    DioHelper.postData(
      url: REGISTERCLIENT, 
      data: registeration_data)
    .then((value) 
    {
      ServerResponse response = ServerResponse.fromJson(value.data);
      if (response.key == 0) {
        emit(RegisterState_Error(response.msg.toString()));
        return;
      }

      emit(RegisterState_Success(response));
      emit(LoginAfterRegisterState());
    }).catchError((error) {
      log(error.toString());
      emit(RegisterState_Error(error.toString()));
    });
  }
}//end class
