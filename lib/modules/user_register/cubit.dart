
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../../models/server_response_model.dart';
import '../../models/user.dart';
import '../../shared/network/end_points.dart';
import '../../shared/network/remote.dart';
import 'states.dart';



class RegisterCubit extends Cubit<RegisterState> 
{
  RegisterCubit() : super(RegisterState_Initial());

  //late LoginModel loginModel;
  static RegisterCubit get(context) => BlocProvider.of(context);
  

  void RegisterClient(User newUser, var formkey) 
  {
    emit(RegisterState_Loading());

    if( !formkey.currentState!.validate() )
    {      
      emit( RegisterState_Error("بعض المدخلات غير صحيحة!!") );
      return;
    }
 
    Map registeration_data = newUser.toMap();
    registeration_data['deviceIdReg']= token;
    registeration_data['deviceType']= token;
    registeration_data['projectName']= token;

    DioHelper.postData(
      url: REGISTERCLIENT, 
      data: registeration_data
    )
    .then((value) {
      print('************* ^^^^^^^^^^ *******************');
      ServerResponse response = ServerResponse.fromJson(value.data);
      if(response.key == 0){
        emit(RegisterState_Error( response.msg.toString() ));  
      }
      
      emit(RegisterState_Success(response));
      
    }).catchError((error) {
      print('xxxxxxxxxxxxx  xxxxxxxxxx');
      emit(RegisterState_Error(error.toString()));
    });
  }

}//end class
