import 'dart:developer';

import '../../../../models/get_favourites_model.dart';
import '../../../../models/server_response_model.dart';
import 'state.dart';
import '../../../../constants.dart';
import '../../../../end_points.dart';
import '../../../../shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetFavouritesCubit extends Cubit<GetFavouritesStates> {
  GetFavouritesCubit() : super(GetFavouritesInitialState());

  static GetFavouritesCubit get(context) => BlocProvider.of(context);

  late GetFavouritesModel getFavouritesModel;
  Map<String, bool> FavouriteMap = {};
  List<DataOfUsersInFavouritesModel> favouriteList = [];

  getFavourites() {
    emit(GetFavouritesLoadingState());
    DioHelper.postDataWithBearearToken(
            url: GETFAVOURITES,
            data: {"CurrentUserId": ID},
            token: TOKEN.toString())
        .then((value) {
      log(value.toString());
      getFavouritesModel = GetFavouritesModel.fromJson(value.data);
      getFavouritesModel.data.forEach((element) {
        FavouriteMap.addAll({element.id!: element.isFavourite!});
      });
      for (int i = 0; i < getFavouritesModel.data.length; i++) {
        favouriteList.add(getFavouritesModel.data[i]);
      }
      emit(GetFavouritesSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetFavouritesErrorState(error.toString()));
    });
  }

  //delete from favourite
  
  deleteFromFavourite({required String userId}) 
  {
    ServerResponse res;
    FavouriteMap[userId] = false;
    favouriteList = [];
    for (int i = 0; i < getFavouritesModel.data.length; i++) {
      if (FavouriteMap[getFavouritesModel.data[i].id!]!) {
        favouriteList.add(getFavouritesModel.data[i]);
      }
    }
    emit(RemoveFromFavouriteLoadingState());

    DioHelper.postDataWithBearearToken(
            url: DELETEFROMFAVOURITE,
            data: {"CurrentUserId": ID, "FavUserId": userId, "IsDeleted": true},
            token: TOKEN.toString())
        .then((value) {
      log(value.toString());
      res = ServerResponse.fromJson(value.data);
      if(res.key == 0){
        emit(RemoveFromFavouriteErrorState(res.msg!));
      }


      emit(RemoveFromFavouriteSuccessState());
    }).catchError((error) {
      FavouriteMap[userId] = true;
      log(error.toString());
      emit(RemoveFromFavouriteErrorState(error.toString()));
      
    });
  }
}
