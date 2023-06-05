
import 'dart:developer';
// import 'dart:js_interop';

import 'package:astarar/layout/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:astarar/models/server_response_model.dart';
import 'package:astarar/modules/register_user/states.dart';
import 'package:astarar/shared/network/end_points.dart';
import 'package:astarar/shared/network/remote.dart';

import '../../models/user.dart';



class RegisterCubit extends Cubit<RegisterState> 
{
  RegisterCubit() : super(RegisterState_Initial());

  //late LoginModel loginModel;
  static RegisterCubit get(context) => BlocProvider.of(context);
  

  // List<String> specifications = [];
  // List<String> specificationsNames = [
  //   "الاسم يبنتهي ب ",
  //   "لون الشعر",
  //   "نوع الشعر",
  //   "لون البشرة",
  //   "من عرق",
  //   "المؤهل العلمي",
  //   'الوظيفة',
  //   'الحالة الصحية',
  //   'الحالة الاجتماعية',
  //   'هل لديك اطفال',
  //   'نبذة عن مظهرك',
  //   'الوضع المالي',
  //   'نوع الزواج'
  // ];
  // List<Map> specificationsMap = [];

  // convert() 
  // {
  //   //TODO: just for test
  //   AppCubit()..getSpecifications();
  //   AppCubit.specificationId;
  //   specificationsMap.clear();
  //   for (int i = 0; i < specifications.length; i++) {
  //     specificationsMap.add({
  //       "SpecificationId": AppCubit.specificationId[ specifications[i] ], // specifications[i]=اسود
  //       "SpecificationName": specificationsNames[i]
  //     });
  //   }
  //   log('-*-*-*-*-*-*-*-*-*-*-*-*-*-*');
  //   log(specificationsMap.toString());
  // }


  void RegisterClient(User newUser, var formkey) 
  {
    emit(RegisterState_Loading());

    if( !formkey.currentState!.validate() )
    {      
      emit( RegisterState_Error("بعض المدخلات غير صحيحة!!") );
      return;
    }

    DioHelper.postData(
      url: REGISTERCLIENT, 
      data: newUser.toMap()
    )
    .then((value) {
      print('************* ^^^^^^^^^^ *******************');
      ServerResponse response = ServerResponse.fromJson(value.data);
      emit(RegisterState_Success(response));
      
    }).catchError((error) {
      print('xxxxxxxxxxxxx vvvvvvvvvvvv   xxxxxxxxxx');
      emit(RegisterState_Error(error.toString()));
    });
  }

}//end class
