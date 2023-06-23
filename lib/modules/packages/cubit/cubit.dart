import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../models/add_to_favourite.dart';
import '../../../models/get_packages_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote.dart';
import 'states.dart';

class GetPackagesCubit extends Cubit<GetPackagesStates> {
  GetPackagesCubit() : super(GetPackagesInitialState());

  //late LoginModel loginModel;
  static GetPackagesCubit get(context) => BlocProvider.of(context);

  late GetPackgesModel getPackgesModel;
  

  void getPackages() 
  {
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
  late AddToFavouriteModel addPackageModel;

  addPackage({required String packageId}) {
    emit(AddPackageLoadingState());
    DioHelper.postDataWithBearearToken(
            url: ADDPACKAGE,
            data: {"PakageId": packageId, "UserId": id},
            token: token.toString())
        .then((value) {
      log(value.toString());
      addPackageModel = AddToFavouriteModel.fromJson(value.data);
      emit(AddPackageSuccessState(value.statusCode!));
    }).catchError((error) {
      log(error.toString());
      emit(AddPackageErrorState(error.toString()));
    });
  }
}
