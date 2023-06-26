import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';
import '../../../../models/get_specifications_model.dart';
import '../../../../end_points.dart';
import '../../../../shared/network/remote.dart';
import 'states.dart';

class AppCubit extends Cubit<AppStates> 
{
  static AppCubit get(context) => BlocProvider.of(context);  
  static Map<String, int> specifications = {};

  static Map Specifications = {};

  AppCubit() : super(AppInitialState())
  {
    _loadSpecificationId();
  }

  Future _loadSpecificationId() async
  {
    GetSpecificationsModel getSpecificationsModel;

    await DioHelper.getDataWithBearerToken(
        url: SUBSPECIFICATIONS,
        token: TOKEN.toString(),)
    .then((value) {
        //  print(value.toString());
        getSpecificationsModel = GetSpecificationsModel.fromJson(value.data);
        getSpecificationsModel.data.forEach( (e) {
          specifications.addAll({e.nameAr!: e.id!});
        });
        emit(GetSpecificationsSuccessState());
    }).catchError((error) {
        // log(error.toString());
        emit(GetSpecificationsErrorState(error.toString()));
    });

    await DioHelper.getData(
        url: "api/v2/Specifications/all")
    .then((res) {

        // fill AppCubit.Specifications object
        AppCubit.Specifications= {};
        res.data['specs'].forEach( (spec) {
          int key = spec['id'];
          AppCubit.Specifications[ key ] = spec;
          Map subspecs = {};

          // log(spec['subSpecifications'].toString());
          spec['subSpecifications']
            .where((subspec) => subspec["isActive"] == true )
            .forEach( (subspec) { 
              int key = subspec['id'];
              subspecs[ key ] = subspec;  
            });
            spec['subSpecifications'] = subspecs;
        });

    }).catchError((error) {
        log(error.toString());
        emit(GetSpecificationsErrorState(error.toString()));
    });

    
  }
  
  Map<String, int> loadSpecificationsFromBackend() 
  {
    emit(GetSpecificationsLoadingState());

    if( specifications.isEmpty ){
      _loadSpecificationId();
    }
    return specifications;    
  }

  void getPhone()
  {
    DioHelper.postData(
      url: GET_PHONE_NUMBER, 
      data: {})
    .then((value) {
      // log(value.toString());
      MOBILE_PHONE=value.data['mobilePhone'];
      log("phonee" + MOBILE_PHONE.toString());
      emit(GetPhoneSuccessState());    
    }).catchError((error){
      // log(error.toString());
      emit(GetPhoneErrorState(error.toString()));
    });

  }
}

