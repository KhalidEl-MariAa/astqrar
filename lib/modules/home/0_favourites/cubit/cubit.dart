import 'dart:developer';

import 'package:astarar/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';
import '../../../../end_points.dart';
import '../../../../models/get_favourites_model.dart';
import '../../../../models/server_response_model.dart';
import '../../../../shared/network/remote.dart';
import 'state.dart';

class FavouritesCubit extends Cubit<FavouritesStates> 
{
  FavouritesCubit() : super(GetFavouritesInitialState());

  static FavouritesCubit get(context) => BlocProvider.of(context);

  List<Favorite> favouriteList = [];

  void getFavourites() {
    emit(GetFavouritesLoadingState());
    DioHelper.postDataWithBearearToken(
            url: GETFAVOURITES,
            data: {"CurrentUserId": ID},
            token: TOKEN.toString())
    .then((value) 
    {
      log(value.toString());

      ServerResponse res = ServerResponse.fromJson(value.data);

      if (res.key == 0) {
        emit(RemoveFromFavouriteErrorState(res.msg!));
        return;
      }      

      res.data.forEach((e) {
        favouriteList.add( Favorite.fromJson(e) );
      });
      
      emit(GetFavouritesSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetFavouritesErrorState(error.toString()));
    });
  }

  //delete from favourite
  void deleteFromFavourite({required String userId}) 
  {
    ServerResponse res;
    emit(RemoveFromFavouriteLoadingState(userId));

    DioHelper.postDataWithBearearToken(
        url: DELETEFROMFAVOURITE,
        data: {"CurrentUserId": ID, "FavUserId": userId, "IsDeleted": true},
        token: TOKEN.toString())
    .then((value) 
    {
      log(value.toString());
      res = ServerResponse.fromJson(value.data);
      if (res.key == 0) {
        emit(RemoveFromFavouriteErrorState(res.msg!));
        return;
      }

      favouriteList
          .where((u) => u.id == userId)
          .first
          .isFavourite = false;

      favouriteList
          .removeWhere((u) => u.id == userId);

      showToast(msg: res.msg??"OK", state: ToastStates.SUCCESS);
      emit(RemoveFromFavouriteSuccessState());
    }).catchError((error) {
      // FavouriteMap[userId] = true;
      log(error.toString());
      emit(RemoveFromFavouriteErrorState(error.toString()));
    });
  }
}
