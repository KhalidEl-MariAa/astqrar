import 'dart:developer';

import 'package:astarar/models/server_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../models/get_packages_model.dart';
import '../../../end_points.dart';
import '../../../shared/network/remote.dart';
import 'states.dart';

class GetPackagesCubit extends Cubit<GetPackagesStates> 
{
  GetPackagesCubit() : super(GetPackagesInitialState());

  //late LoginModel loginModel;
  static GetPackagesCubit get(context) => BlocProvider.of(context);

  late GetPackgesModel getPackgesModel;
  

  void getPackages() 
  {
    log('GETPACKAGES ^^^^^^^^^^^^^^');
    emit(GetPackagesLoadingState());
    DioHelper.postData(url: GETPACKAGES, data: {}).then((value) {
      log(value.toString());
      getPackgesModel = GetPackgesModel.fromJson(value.data);

      emit(GetPackagesSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetPackagesErrorState(error.toString()));
    });
  }

  //add package
  

  addPackage({required String packageId}) 
  {
    ServerResponse res;
    emit(AddPackageLoadingState());
    DioHelper.postDataWithBearearToken(
            url: ADDPACKAGE,
            data: {"PakageId": packageId, "UserId": ID},
            token: TOKEN.toString())
        .then((value) {
      log(value.toString());
      res = ServerResponse.fromJson(value.data);
      if(res.key == 0){
        emit(AddPackageErrorState(res.msg!));
      }

      emit(AddPackageSuccessState(value.statusCode!));
    }).catchError((error) {
      log(error.toString());
      emit(AddPackageErrorState(error.toString()));
    });
  }
}
