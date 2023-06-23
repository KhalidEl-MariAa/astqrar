import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';
import '../../../../models/get_all_ads_with_users_model.dart';
import '../../../../shared/network/end_points.dart';
import '../../../../shared/network/remote.dart';
import 'states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  // late GetAllUsers getHomeModel;
  // List<UsersHomeData> menSection = [];
  // List<UsersHomeData> womenSection = [];
  // Map<int,int> subSpecification={};

  //ads
  late GetAllAdsWithUsersModel getAllAdsWithUsersModel;

  getUserAds() {
    emit(GetUserAdsLoadingState());
    DioHelper.postDataWithBearearToken(
          url: GETUSERADS, 
          data: {}, 
          token: token.toString()
    ).then((value) 
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
