import 'dart:developer';

import '../../../models/get_all_ads_with_users_model.dart';
import '../../../models/get_all_users.dart';
import 'states.dart';
import '../../../shared/contants/contants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> 
{
  HomeCubit() : super(HomeInitialState());

  //late LoginModel loginModel;
  static HomeCubit get(context) => BlocProvider.of(context);

  // late GetAllUsers getHomeModel;
  // List<UsersHomeData> menSection = [];
  // List<UsersHomeData> womenSection = [];
  // Map<int,int> subSpecification={};
  
  /*getHomeData() {
    emit(HomeLoadingState());
    DioHelper.postData(url: GETHOME, data: {}).then((value) {
      print(value.toString());
      getHomeModel = GetAllUsers.fromJson(value.data);

      emit(HomeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorState(error.toString()));
    });
  }

*/

  //ads
  late GetAllAdsWithUsersModel getAllAdsWithUsersModel;
  bool getUserAdsDone=false;

  getUserAds() {
    getUserAdsDone=false;
    emit(GetUserAdsLoadingState());
    DioHelper.postDataWithBearearToken(
            url: GETUSERADS, data: {}, token: token.toString())
        .then((value) {
      log(value.toString());
      getAllAdsWithUsersModel = GetAllAdsWithUsersModel.fromJson(value.data);
      getUserAdsDone=true;
      emit(GetUserAdsSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetUserAdsErrorState(error.toString()));
    });
  }
}
