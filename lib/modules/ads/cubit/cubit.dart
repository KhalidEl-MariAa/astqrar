import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

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


}
