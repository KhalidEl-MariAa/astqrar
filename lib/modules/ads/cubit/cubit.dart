import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../end_points.dart';
import '../../../models/ad.dart';
import '../../../models/server_response_model.dart';
import '../../../shared/network/remote.dart';
import 'states.dart';

class AdsCubit extends Cubit<AdsStates> 
{
  AdsCubit() : super(AdsInitialState());

  static AdsCubit get(context) => BlocProvider.of(context);

  // late GetAdsModel getAdsModel;
  List<Ad> ads = [];

  void getAds() {
    emit(GetAdsLoadingState());
    DioHelper.postData(url: GETALLADS, data: {})
  .then((value) 
  {
      log(value.toString());

      emit(GetAdsLoadingState());      
      ads = [];

      // getAdsModel = GetAdsModel.fromJson(value.data);
      ServerResponse res = ServerResponse.fromJson(value.data);

      if (res.key == 0) {
        emit(GetAdsErrorState(res.msg?? "حدث خطأ ما"));
        return;
      }

      res.data.forEach((adItem) {
        ads.add(Ad.fromJson(adItem));
      });

      emit(GetAdsSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetAdsErrorState(error.toString()));
    });
  }

  //add ads
  late ServerResponse res;

  addAds({required int adId}) 
  {
    emit(AddAdsLoadingState());
    DioHelper.postDataWithBearearToken(
            url: ADDADS,
            data: {
              "AdId": adId,
            },
            token: TOKEN.toString())
    .then((value) {
      log(value.toString());
      res = ServerResponse.fromJson(value.data);
      emit(AddAdsSuccessState(value.statusCode!));
      //    sendNotificationToAll(body: "تمت اضافة اعلان جديد من قبل $name");
    }).catchError((error) {
      log(error.toString());
      emit(AddAdsErrorState(error.toString()));
    });
  }

  // TODO: اصلاح المشكلة
  sendNotificationToAll({String title=" ", required String body}) 
  {
    emit(SendNotificationToAllLoadingState());
    DioHelper.postDataWithBearearToken(
        url: SENDNOTIFICATIONTOALL,
        data:{
          "projectName": APP_NAME,
          "deviceType":"android",
          "notificationType":3,
          "body": body,
          "title": title,
        },
        token: TOKEN )
    .then((value) {
          print(value.toString());
          emit(SendNotificationToAllSuccessState());
    }).catchError((error){
          print(error.toString());
          emit(SendNotificationToAllErrorState(error.toString()));
    });
  }
}
