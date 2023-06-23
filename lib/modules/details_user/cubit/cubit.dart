import 'dart:developer';
import 'dart:io';

import '../../../models/server_response_model.dart';

import '../../../models/add_to_favourite.dart';
import '../../../models/get_information_user.dart';
import 'states.dart';
import '../../../shared/contants/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetInformationCubit extends Cubit<GetInformationStates> 
{
  GetInformationCubit() : super(GetInformationInitialState());

  static GetInformationCubit get(context) => BlocProvider.of(context);

  //get information users
  late GetInformationUserModel getInformationUserModel;

  userOrVisitorToGetInformation({required String userId})
  {
    if(isLogin){
      getInformationUser(otherId: userId);
    }else{
      getInformationUserByVisitor(userId: userId);
    }
  }

  void getInformationUser({required String otherId}) 
  {
      // log(token.toString());
      emit(GetInformationLoadingState());
      DioHelper.getDataWithQuery(
              url: GETINFORMATIONUSER,
              query: {"otherId": otherId},
              token: token.toString())
    .then((value) 
    {
      getInformationUserModel = GetInformationUserModel.fromJson(value.data);
      emit(GetInformationSuccessState());
      sendNotification(userid: otherId, type: 3, body:"تمت زيارة صفحتك من قبل $name", title: "");
    }).catchError((error) 
    {
      emit(GetInformationErrorState(error.toString()));
    });
  }

  void getInformationUserByVisitor({required String userId}) 
  {
    log(userId);

    emit(GetInformationLoadingState());
    DioHelper.getDataWithQuery(
        url: GETINFORMATIONUSERBYVISITOR,
        query: {"userid": userId})
        .then((value) {
      getInformationUserModel = GetInformationUserModel.fromJson(value.data);
      emit(GetInformationSuccessState());

    }).catchError((error) {
      emit(GetInformationErrorState(error.toString()));
    });
  }


  //add to favourite
  late AddToFavouriteModel addToFavouriteModel;

  void addToFavourite({required String userId}) 
  {
    getInformationUserModel.isFavorate = !getInformationUserModel.isFavorate!;
    emit(AddToFavouriteLoadingState());

    DioHelper.postDataWithBearearToken(
      url: ADDTOFAVOURITE,
      data: {
        "CurrentUserId": id,
        "FavUserId": userId,
      },
      token: token.toString()
    ).then((value) 
    {
      log(value.toString());
      addToFavouriteModel = AddToFavouriteModel.fromJson(value.data);
      emit(AddToFavouriteSuccessState());
    }).catchError((error) {
      getInformationUserModel.isFavorate = !getInformationUserModel.isFavorate!;
      log(error.toString());
      emit(AddToFavouriteErrorState(error.toString()));
    });
  }

  //delete from favourite
  late AddToFavouriteModel deleteFromFavouriteModel;

  void deleteFromFavourite({required String userId}) 
  {
    getInformationUserModel.isFavorate = !getInformationUserModel.isFavorate!;
    emit(AddToFavouriteLoadingState());
    DioHelper.postDataWithBearearToken(
        url: DELETEFROMFAVOURITE,
        data: {
          "CurrentUserId": id,
          "FavUserId": userId,
          "IsDeleted":true
        },
        token: token.toString())
        .then((value) {
      // log(value.toString());
      deleteFromFavouriteModel = AddToFavouriteModel.fromJson(value.data);
      emit(AddToFavouriteSuccessState());
    }).catchError((error) {
      getInformationUserModel.isFavorate = !getInformationUserModel.isFavorate!;
      // log(error.toString());
      emit(AddToFavouriteErrorState(error.toString()));
    });
  }

  //add request
  late ServerResponse res;

  // void addChattRequest({required String userId}) 
  // {
  //   emit(AddChattRequestLoadingState());
  //   DioHelper.postDataWithBearearToken(
  //     url: ADDREQUEST, 
  //     data: { "userId":userId }, 
  //     token: token.toString())
  //   .then((value) {
  //     res = ServerResponse.fromJson(value.data);
  //     if( res.key == 0){
  //       emit(AddChattRequestErrorState( res.msg.toString() ));
  //       return;
  //     }
  //     emit(AddChattRequestSuccessState(value.statusCode!));
  //     sendNotification(userid: userId, type: 0, body: "تم ارسال طلب محادثة من قبل $name", title: "طلب محادثة");
  //   }).catchError((error) {
  //     emit(AddChattRequestErrorState(error.toString()));
  //   });
  // }

  void addHimToMyContacts({required String userId}) 
  {
    emit(AddHimToMyContactsLoading());
    DioHelper.postDataWithBearearToken(
      url: ADD_HIM_TO_MY_CONTACTS, 
      data: { "userId":userId }, 
      token: token.toString())
    .then((value) {
      res = ServerResponse.fromJson(value.data);
      if( res.key == 0){
        emit(AddHimToMyContactsLoadingError( res.msg! ));
        return;
      }

      //تم اضافته مسبقا لقائمة المحادثات
      if( res.key == 2){ 
        emit(AddHimToMyContactsLoadingSuccess( res.msg! ));
        return; 
      }

      sendNotification(
        userid: userId, 
        type: 0, 
        body:  "قام " + name! + " بإضافتك الى قائمته وبإمكانك بدء المحادثه معه ", 
        title: "طلب محادثة");

      emit(AddHimToMyContactsLoadingSuccess( res.msg! ));

    }).catchError((error) {
      emit(AddHimToMyContactsLoadingError(error.toString()));
    });    
  }

  //send notification
  void sendNotification({required String userid,required int type,required String body,required String title})
  {
      emit(SendNotificationLoadingState());

      DioHelper.postDataWithBearearToken(
        token: token.toString(),
        url: SENDNOTIFICATION, 
        data: {
          "userId":userid,
          "projectName":"استقرار",
          "deviceType":Platform.isIOS?"ios":"android",
          "notificationType":type,
          "body":body,
          "title":title
        }
      ).then((value) {
          // log(value.toString());
          emit(SendNotificationSuccessState());
      }).catchError((error){
          // log(error.toString());
          emit(SendNotificationErrorState(error.toString()));
      });
  }

  

}//end class
