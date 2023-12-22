import 'dart:developer';
import 'dart:io';

import 'package:astarar/utils.dart';

import '../../../../../models/server_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants.dart';
import '../../../../../end_points.dart';
import '../../../../../models/user.dart';
import '../../../../../shared/network/remote.dart';
import 'states.dart';
import 'package:device_info_plus/device_info_plus.dart';

class AccountCubit extends Cubit<AccountStates> 
{
  AccountCubit() : super(AccountInitialState());

  static AccountCubit get(context) => BlocProvider.of(context);


  //get user data
  late User user;
  String deviceName = "Unkown";

  void getUserData() async
  {   
    emit(AccountLoading());

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid){
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      log('Running on ${androidInfo.model}');  // e.g. "Moto G (4)"
      deviceName = androidInfo.manufacturer.capitalize() + " " +  androidInfo.model;
    }

    if(Platform.isIOS){
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      log('Running on ${iosInfo.utsname.machine}');  // e.g. "iPod7,1"   
      deviceName = iosInfo.utsname.machine;
    }

    
    //var allInfo = deviceInfo.data;    
   
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
