import 'dart:developer';
import '../../../models/add_to_favourite.dart';
import '../../../models/get_ads_model.dart';
import 'states.dart';
import '../../../shared/contants/contants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdsCubit extends Cubit<AdsStates> {
  AdsCubit() : super(AdsInitialState());

  //late LoginModel loginModel;
  static AdsCubit get(context) => BlocProvider.of(context);

  late GetAdsModel getAdsModel;
  bool getAdsDone = false;

  getAds() {
    emit(GetAdsLoadingState());
    DioHelper.postData(url: GETALLADS, data: {}).then((value) {
      log(value.toString());
      getAdsModel = GetAdsModel.fromJson(value.data);
      getAdsDone = true;
      emit(GetAdsSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetAdsErrorState(error.toString()));
    });
  }

  //add ads
  late AddToFavouriteModel addAdsModel;

  addAds({required int adId}) {
    emit(AddAdsLoadingState());
    DioHelper.postDataWithBearearToken(
            url: ADDADS,
            data: {
              "AdId": adId,
            },
            token: token.toString())
        .then((value) {
      log(value.toString());
      addAdsModel = AddToFavouriteModel.fromJson(value.data);
      emit(AddAdsSuccessState(value.statusCode!));
      //    sendNotificationToAll(body: "تمت اضافة اعلان جديد من قبل $name");
    }).catchError((error) {
      log(error.toString());
      emit(AddAdsErrorState(error.toString()));
    });
  }

  /*
  sendNotificationToAll({required String body}){
    emit(SendNotificationToAllLoadingState());
    DioHelper.postDataWithBearearToken(url: SENDNOTIFICATIONTOALL,
        data:{
        "projectName":"استقرار",
        "deviceType":"android",
        "notificationType":3,
        "body":body,
        "title":" "
        },token: token.toString())..then((value) {
          print(value.toString());
          emit(SendNotificationToAllSuccessState());
    }).catchError((error){
          print(error.toString());
          emit(SendNotificationToAllErrorState(error.toString()));
    });
  }*/
}
