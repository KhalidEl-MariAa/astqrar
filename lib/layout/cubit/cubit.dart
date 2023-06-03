import 'dart:developer';

import 'package:astarar/layout/cubit/states.dart';
import 'package:astarar/models/get_specifications_model.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/network/end_points.dart';
import '../../shared/network/remote.dart';

class AppCubit extends Cubit<AppStates> 
{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);  
  static  Map<String, int> specificationId = {};

  Future loadSpecificationId() async
  {
    GetSpecificationsModel getSpecificationsModel;
    await DioHelper.getDataWithBearerToken(
        url: SUBSPECIFICATIONS,
        token: token.toString(),)
    .then((value) {
        //  print(value.toString());
        getSpecificationsModel = GetSpecificationsModel.fromJson(value.data);
        getSpecificationsModel.data.forEach( (e) {
          specificationId.addAll({e.nameAr!: e.id!});
        });
        emit(GetSpecificationsSuccessState());
    }).catchError((error) {
        // log(error.toString());
        emit(GetSpecificationsErrorState(error.toString()));
    });
  }
  
  Future<Map<String, int>> getSpecifications() async
  {
    emit(GetSpecificationsLoadingState());

    if( specificationId.isEmpty ){
      await loadSpecificationId();
    }
    return specificationId;
    
  }

  void getPhone()
  {
    DioHelper.postData(url: GetPhoneNumber, data: {})
    .then((value) {
      log(value.toString());
      mobilePhone=value.data['mobilePhone'];
      log("phonee"+mobilePhone.toString());
      emit(GetPhoneSuccessState());    
    }).catchError((error){
      log(error.toString());
      emit(GetPhoneErrorState(error.toString()));
    });

  }
}