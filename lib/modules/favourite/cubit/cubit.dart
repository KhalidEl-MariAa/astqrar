import 'dart:developer';

import '../../../models/add_to_favourite.dart';
import '../../../models/get_favourites_model.dart';
import 'state.dart';
import '../../../shared/contants/contants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetFavouritesCubit extends Cubit<GetFavouritesStates> {
  GetFavouritesCubit() : super(GetFavouritesInitialState());

  static GetFavouritesCubit get(context) => BlocProvider.of(context);

  late GetFavouritesModel getFavouritesModel;
  bool getFavouritesDone = false;
  Map<String, bool> FavouriteMap = {};
  List<DataOfUsersInFavouritesModel> favouriteList = [];

  getFavourites() {
    getFavouritesDone = false;
    emit(GetFavouritesLoadingState());
    DioHelper.postDataWithBearearToken(
            url: GETFAVOURITES,
            data: {"CurrentUserId": id},
            token: token.toString())
        .then((value) {
      log(value.toString());
      getFavouritesModel = GetFavouritesModel.fromJson(value.data);
      getFavouritesModel.data.forEach((element) {
        FavouriteMap.addAll({element.id!: element.isFavourite!});
      });
      for (int i = 0; i < getFavouritesModel.data.length; i++) {
        favouriteList.add(getFavouritesModel.data[i]);
      }
      getFavouritesDone = true;
      emit(GetFavouritesSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetFavouritesErrorState(error.toString()));
    });
  }

  //delete from favourite
  late AddToFavouriteModel deleteFromFavouriteModel;

  deleteFromFavourite({required String userId}) {
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
            data: {"CurrentUserId": id, "FavUserId": userId, "IsDeleted": true},
            token: token.toString())
        .then((value) {
      log(value.toString());
      deleteFromFavouriteModel = AddToFavouriteModel.fromJson(value.data);

      emit(RemoveFromFavouriteSuccessState());
    }).catchError((error) {
      FavouriteMap[userId] = true;
      log(error.toString());
      emit(RemoveFromFavouriteErrorState(error.toString()));
      
    });
  }
}
