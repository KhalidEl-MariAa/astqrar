import 'dart:developer';

import '../../../models/server_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/pakage.dart';
import '../../../end_points.dart';
import '../../../shared/network/remote.dart';
import 'states.dart';

class GetPackagesCubit extends Cubit<GetPackagesStates> 
{
  GetPackagesCubit() : super(GetPackagesInitialState());

  //late LoginModel loginModel;
  static GetPackagesCubit get(context) => BlocProvider.of(context);

  List<Package> pakages = [];

  void getPackages() 
  {
    emit(GetPackagesLoadingState());

    DioHelper.postData(url: GETPACKAGES, data: {})
    .then((value) 
    {
      log(value.toString());
      
      ServerResponse res = ServerResponse.fromJson(value.data);
      pakages = [];

      if (res.key == 0) {
        emit(GetPackagesErrorState(res.msg?? "حدث خطأ ما"));
        return;
      }

      res.data.forEach((adItem) {
        pakages.add(Package.fromJson(adItem));
      });

      emit(GetPackagesSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetPackagesErrorState(error.toString()));
    });
  }

  //add package
  // addPackage({required String packageId}) {
  //   ServerResponse res;
  //   emit(AddPackageLoadingState());
  //   DioHelper.postDataWithBearearToken(
  //           url: ADDPACKAGE,
  //           data: {
  //             "PakageId": packageId, 
  //             "UserId": ID},
  //           token: TOKEN.toString())
  //   .then((value) 
  //   {
  //     log(value.toString());
  //     res = ServerResponse.fromJson(value.data);
  //     if (res.key == 0) {
  //       emit(AddPackageErrorState(res.msg!));
  //       return;
  //     }
  //     emit(AddPackageSuccessState(value.statusCode!));
  //   }).catchError((error) {
  //     log(error.toString());
  //     emit(AddPackageErrorState(error.toString()));
  //   });
  // }
  
}
