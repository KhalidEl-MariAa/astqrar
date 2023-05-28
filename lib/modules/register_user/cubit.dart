
import 'dart:developer';

import 'package:astarar/layout/cubit/cubit.dart';
import 'package:astarar/models/register_delegate_model.dart';
import 'package:astarar/modules/register_user/states.dart';
import 'package:astarar/shared/network/end_points.dart';
import 'package:astarar/shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:astarar/shared/components/components.dart';


class RegisterClientCubit extends Cubit<RegisterClientStates> 
{
  RegisterClientCubit() : super(RegisterClientInitialState());

  //late LoginModel loginModel;
  static RegisterClientCubit get(context) => BlocProvider.of(context);
  late RegisterDelegateModel registerClientModel;

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

  convert() 
  {

    //TODO: just for test
    AppCubit()..getSpecifications();
    AppCubit.specificationId;

    specificationsMap.clear();
    for (int i = 0; i < specifications.length; i++) {
      specificationsMap.add({
        "SpecificationId": AppCubit.specificationId[specifications[i]],
        "SpecificationName": specificationsNames[i]
      });
    }
    log('-*-*-*-*-*-*-*-*-*-*-*-*-*-*');
    log(specificationsMap.toString());
  }

  RegisterClient({
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
      "email": delegateId == null ? email : "nabil12@gmail.com",
      "Age":age,
      "Gender":gender,
      "NationalID": delegateId == null ? natonalityId : "71717171",
      "Nationality":nationality,
      "City":city,
      "password": delegateId == null ? password : "0000000",
      "phone":delegateId==null?phone:"+9665874521",
      "Height":height,
      "Weight":width,
      "SpecialNeeds":specialNeeds,
      "Dowry":dowry,
      "Terms":terms,
      "DelegateId":delegateId,
      "IsFakeUser":delegateId!=null? true: false,
      
      "ChildrensNumber":childrensNumber!.toInt(),
      "Tribe":tribe,
      "NameOfJob":nameOfJob,
      "KindOfSick":kindOfSick,
      "UserSpecifications":specificationsMap, //can't SAVE
    };
    print(newUser);



    DioHelper.postData(url: REGISTERCLIENT, data: newUser).then((value) {
      print('********************************');
      print(value.toString());
      registerClientModel = RegisterDelegateModel.fromJson(value.data);
      emit(RegisterClientSuccessState(registerClientModel));
      
    }).catchError((error) {
      print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
      print(error.toString());
      emit(RegisterClientErrorState(error.toString()));
      showToast(msg: "حصلت مشكلة من السيرفر أثناء ارسال بيانات التسجيل", state: ToastStates.ERROR);
      print('--------------------------------------------');
    });
  }
}
