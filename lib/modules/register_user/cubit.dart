
import 'dart:developer';
// import 'dart:js_interop';

import 'package:astarar/layout/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:astarar/models/server_response_model.dart';
import 'package:astarar/modules/register_user/states.dart';
import 'package:astarar/shared/network/end_points.dart';
import 'package:astarar/shared/network/remote.dart';



class RegisterClientCubit extends Cubit<RegisterClientStates> 
{
  RegisterClientCubit() : super(RegisterClientInitialState());

  //late LoginModel loginModel;
  static RegisterClientCubit get(context) => BlocProvider.of(context);
  

  List<String> specifications = [];
  List<String> specificationsNames = [
    "الاسم يبنتهي ب ",
    "لون الشعر",
    "نوع الشعر",
    "لون البشرة",
    "من عرق",
    "المؤهل العلمي",
    'الوظيفة',
    'الحالة الصحية',
    'الحالة الاجتماعية',
    'هل لديك اطفال',
    'نبذة عن مظهرك',
    'الوضع المالي',
    'نوع الزواج'
  ];

  List<Map> specificationsMap = [];

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


  void RegisterClient({
    required bool specialNeeds,
    required String name,
    required String email,
    required String age,
    required String nationality,
    required String natonalityId,
    required String city,
    required String password,
    required String phone,
    required String height,
    required String width,
    required String dowry,
    required String terms,
    required String gender,
    int? childrensNumber,
    required String tribe,
    required String nameOfJob,
    required String kindOfSick,
    String? delegateId }) 
  {
    emit(RegisterClientLoadingState());

    var newUser = {
      "userName": name,
      "email": email,
      "Age":age,
      "Gender":gender,
      "NationalID": natonalityId,
      "Nationality":nationality,
      "City":city,
      "password": password,
      "phone": phone,
      "Height":height,
      "Weight":width,
      "SpecialNeeds":specialNeeds,
      "Dowry":dowry,
      "Terms":terms,
      // "DelegateId":delegateId,
      // "IsFakeUser":delegateId!=null? true: false,
      
      "ChildrensNumber":childrensNumber!.toInt(),
      "Tribe":tribe,
      "NameOfJob":nameOfJob,
      "KindOfSick":kindOfSick,
      "UserSpecifications":specificationsMap, //can't SAVE
    };
    print(newUser);

    DioHelper.postData(
      url: REGISTERCLIENT, 
      data: newUser
    )
    .then((value) {
      print('********************************');
      print(value.toString());
      // late ServerResponse registerClientModel;
      //TODO: remove this emit
      // emit(RegisterClientSuccessState(response));
      
    }).catchError((error) {
      print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
      print(error.toString());

      // emit(RegisterClientErrorState(error.toString()));
      
      print('--------------------------------------------');
    });
  }

}//end class
