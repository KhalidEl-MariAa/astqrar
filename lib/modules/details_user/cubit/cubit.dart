import 'dart:developer';
import 'dart:io';

import 'package:astarar/models/server_response_model.dart';

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
      getInformationUser(userId: userId);
    }else{
      getInformationUserByVisitor(userId: userId);
    }
  }

  void getInformationUser({required String userId}) 
  {
      // log(userId);
      // log(token.toString());
      emit(GetInformationLoadingState());
      DioHelper.getDataWithQuery(
              url: GETINFORMATIONUSER,
              query: {"userid": userId},
              token: token.toString())
    .then((value) 
    {
      getInformationUserModel = GetInformationUserModel.fromJson(value.data);
      // log(getInformationUserModel.userSubSpecification!.userSubSpecificationDto![11].value.toString());
      emit(GetInformationSuccessState());
      sendNotification(userid: userId, type: 3, body:"تمت زيارة صفحتك من قبل $name", title: "");
    }).catchError((error) {
      // log(error.toString());
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
            token: token.toString())
        .then((value) {
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

  void addChattRequest({required String userId}) 
  {
    emit(AddChattRequestLoadingState());
    DioHelper.postDataWithBearearToken(
      url: ADDREQUEST, 
      data: { "userId":userId }, 
      token: token.toString())
    .then((value) {
      // log(value.toString());
      res = ServerResponse.fromJson(value.data);
      if( res.key == 0){
        emit(AddChattRequestErrorState( res.msg.toString() ));
        return;
      }
    
      emit(AddChattRequestSuccessState(value.statusCode!));
      sendNotification(userid: userId, type: 0, body: "تم ارسال طلب محادثة من قبل $name", title: "طلب محادثة");
    }).catchError((error) {
      // log(error.toString());
      emit(AddChattRequestErrorState(error.toString()));
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
