import 'dart:developer';

import 'package:astarar/models/add_to_favourite.dart';
import 'package:astarar/models/get_packages_model.dart';
import 'package:astarar/modules/packages/cubit/states.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:astarar/shared/network/end_points.dart';
import 'package:astarar/shared/network/remote.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetPackagesCubit extends Cubit<GetPackagesStates> {
  GetPackagesCubit() : super(GetPackagesInitialState());

  //late LoginModel loginModel;
  static GetPackagesCubit get(context) => BlocProvider.of(context);

  late GetPackgesModel getPackgesModel;
 bool getPackagesDone=false;

  getPackages(){
    getPackagesDone=false;
    emit(GetPackagesLoadingState());
    DioHelper.postData(url: GETPACKAGES, data: {})
    .then((value) {
      log(value.toString());
      getPackgesModel=GetPackgesModel.fromJson(value.data);
      getPackagesDone=true;
      emit(GetPackagesSuccessState());

    }).catchError((error){
      log(error.toString());
      emit(GetPackagesErrorState(error.toString()));
    });
  }


  //add package
late AddToFavouriteModel addPackageModel;

addPackage({required String packageId}){
    emit(AddPackageLoadingState());
    DioHelper.postDataWithBearearToken(url: ADDPACKAGE, data: {
      "PakageId":packageId,
      "UserId":id
    },token: token.toString())
    .then((value) {
      log(value.toString());
      addPackageModel=AddToFavouriteModel.fromJson(value.data);
      emit(AddPackageSuccessState(value.statusCode!));
    }).catchError((error){
      log(error.toString());
      emit(AddPackageErrorState(error.toString()));
    });
}
}