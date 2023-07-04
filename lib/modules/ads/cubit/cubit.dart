import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../end_points.dart';
import '../../../models/get_ads_model.dart';
import '../../../models/server_response_model.dart';
import '../../../shared/network/remote.dart';
import 'states.dart';

class AdsCubit extends Cubit<AdsStates> 
{
  AdsCubit() : super(AdsInitialState());

  static AdsCubit get(context) => BlocProvider.of(context);

  late GetAdsModel getAdsModel;

  getAds() {
    emit(GetAdsLoadingState());
    DioHelper.postData(url: GETALLADS, data: {})
    .then((value) {
      emit(GetAdsLoadingState());
      log(value.toString());
      getAdsModel = GetAdsModel.fromJson(value.data);

      emit(GetAdsSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetAdsErrorState(error.toString()));
    });
  }

  //add ads
  late ServerResponse addAdsModel;

  addAds({required int adId}) {
    emit(AddAdsLoadingState());
    DioHelper.postDataWithBearearToken(
            url: ADDADS,
            data: {
              "AdId": adId,
            },
            token: TOKEN.toString())
        .then((value) {
      log(value.toString());
      addAdsModel = ServerResponse.fromJson(value.data);
      emit(AddAdsSuccessState(value.statusCode!));
      //    sendNotificationToAll(body: "تمت اضافة اعلان جديد من قبل $name");
    }).catchError((error) {
      log(error.toString());
      emit(AddAdsErrorState(error.toString()));
    });
  }

  // sendNotificationToAll({required String body}){
  //   emit(SendNotificationToAllLoadingState());
  //   DioHelper.postDataWithBearearToken(url: SENDNOTIFICATIONTOALL,
  //       data:{
  //       "projectName":"استقرار",
  //       "deviceType":"android",
  //       "notificationType":3,
  //       "body":body,
  //       "title":" "
  //       },token: token.toString())..then((value) {
  //         print(value.toString());
  //         emit(SendNotificationToAllSuccessState());
  //   }).catchError((error){
  //         print(error.toString());
  //         emit(SendNotificationToAllErrorState(error.toString()));
  //   });
  // }
}
