import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';
import '../../../../end_points.dart';
import '../../../../models/user_ads.dart';
import '../../../../shared/network/remote.dart';
import 'states.dart';

class HomeCubit extends Cubit<HomeStates> 
{
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  //ads
  late GetAllAdsWithUsersModel getAllAdsWithUsersModel;

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
      getAllAdsWithUsersModel = GetAllAdsWithUsersModel.fromJson(value.data);

      emit(GetUserAdsSuccessState());

    }).catchError((error) 
    {
      log(error.toString());
      emit(GetUserAdsErrorState(error.toString()));
    });
  }
}
