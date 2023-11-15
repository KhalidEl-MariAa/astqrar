import 'dart:developer';

import 'package:astarar/models/server_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';
import '../../../../end_points.dart';
import '../../../../models/user_ad.dart';
import '../../../../shared/network/remote.dart';
import 'states.dart';

class HomeCubit extends Cubit<HomeStates> 
{
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  //ads
  // late ServerResponse res;
  List<UserAd> userAds = [] ;

  void getUserAds() 
  {
    emit(GetUserAdsLoadingState());

    DioHelper.postDataWithBearearToken(
        url: GETUSERADS, 
        data: {}, 
        token: TOKEN.toString()
    ).then( (value) 
    {
      log(value.toString());

      userAds = [] ;
      ServerResponse res = ServerResponse.fromJson(value.data);
      if (res.key == 0) {
        emit(GetUserAdsErrorState(res.msg!));
        return;
      }

      res.data.forEach((e) {
        userAds.add( UserAd.fromJson(e) );
      });
      emit(GetUserAdsSuccessState());

    }).catchError((error) 
    {
      log(error.toString());
      emit(GetUserAdsErrorState(error.toString()));
    });
  }
}
