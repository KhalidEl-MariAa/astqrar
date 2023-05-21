import 'dart:developer';
import 'dart:io';

import 'package:astarar/models/add_request.dart';
import 'package:astarar/models/add_to_favourite.dart';
import 'package:astarar/models/get_information_user.dart';
import 'package:astarar/modules/details_user/cubit/states.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:astarar/shared/network/end_points.dart';
import 'package:astarar/shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetInformationCubit extends Cubit<GetInformationStates> {
  GetInformationCubit() : super(GetInformationInitialState());

  static GetInformationCubit get(context) => BlocProvider.of(context);

  //get information users
  late GetInformationUserModel getInformationUserModel;
  bool getInformationDone = false;

 userOrVisitorToGetInformation({required String userId}){
    if(isLogin){
      getInformationUser(userId: userId);
    }
    else{
      getInformationUserByVisitor(userId: userId);
    }
  }

  getInformationUser({required String userId}) {
    log(userId);
    log(token.toString());
    getInformationDone = false;
    emit(GetInformationLoadingState());
    DioHelper.getDataWithQuery(
            url: GETINFORMATIONUSER,
            query: {"userid": userId},
            token: token.toString())
        .then((value) {
      log(value.toString());
      getInformationUserModel = GetInformationUserModel.fromJson(value.data);
      log(getInformationUserModel.userSubSpecification!.userSubSpecificationDto![12].specificationValue.toString());
      getInformationDone = true;
      emit(GetInformationSuccessState());
      sendNotification(userid: userId, type: 3, body:"تمت زيارة صفحتك من قبل $name",
          title: "");
    }).catchError((error) {
      log(error.toString());
      emit(GetInformationErrorState(error.toString()));
    });
  }

  getInformationUserByVisitor({required String userId}) {
    log(userId);

    getInformationDone = false;
    emit(GetInformationLoadingState());
    DioHelper.getDataWithQuery(
        url: GETINFORMATIONUSERBYVISITOR,
        query: {"userid": userId})
        .then((value) {
      log(value.toString());
      getInformationUserModel = GetInformationUserModel.fromJson(value.data);
      getInformationDone = true;
      emit(GetInformationSuccessState());

    }).catchError((error) {
      print(error.toString());
      emit(GetInformationErrorState(error.toString()));
    });
  }


  //add to favourite
  late AddToFavouriteModel addToFavouriteModel;

  addToFavourite({required String userId}) {
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

  deleteFromFavourite({required String userId}) {
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
      log(value.toString());
      deleteFromFavouriteModel = AddToFavouriteModel.fromJson(value.data);
      emit(AddToFavouriteSuccessState());
    }).catchError((error) {
      getInformationUserModel.isFavorate = !getInformationUserModel.isFavorate!;
      log(error.toString());
      emit(AddToFavouriteErrorState(error.toString()));
    });
  }

//add request
  late AddRequestModel addRequestModel;

  addRequest({required String userId}) {
    emit(AddRequestLoadingState());
    DioHelper.postDataWithBearearToken(
            url: ADDREQUEST, data: {
              "userId":userId
    }, token: token.toString())
        .then((value) {
      log(value.toString());
      addRequestModel = AddRequestModel.fromJson(value.data);
      log(value.statusCode.toString());
      emit(AddRequestSuccessState(value.statusCode!));
      sendNotification(userid: userId, type: 0, body: "تم ارسال طلب محادثة من قبل $name", title: "طلب محادثة");
    }).catchError((error) {
      log(error.toString());
      emit(AddRequestErrorState(error.toString()));
    });
  }

  //send notification
sendNotification({required String userid,required int type,required String body,required String title}){
    emit(SendNotificationLoadingState());
DioHelper.postDataWithBearearToken(token: token.toString(),url: SENDNOTIFICATION, data: {
    "userId":userid,
    "projectName":"استقرار",
    "deviceType":Platform.isIOS?"ios":"android",
    "notificationType":type,
    "body":body,
    "title":title
    })
    .then((value) {
      log(value.toString());
      emit(SendNotificationSuccessState());
}).catchError((error){
      log(error.toString());
      emit(SendNotificationErrorState(error.toString()));
});
}


}
