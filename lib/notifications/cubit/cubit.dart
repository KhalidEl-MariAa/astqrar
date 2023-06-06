import 'dart:developer';
import 'dart:io';

import '../../models/add_request.dart';
import '../../models/get_notifications.dart';
import 'states.dart';
import '../../shared/contants/contants.dart';
import '../../shared/network/end_points.dart';
import '../../shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCubit extends Cubit<NotificationStates> {
  NotificationCubit() : super(NotificationInitialState());

  //late LoginModel loginModel;
  static NotificationCubit get(context) => BlocProvider.of(context);
  
  late GetNotificationsModel getNotificationsModel;
  bool getNotificationsDone=false;
  getNotifications(){

    emit(GetNotificationLoadingState());
    DioHelper.getDataWithBearerToken(url: GETNOTIFICATIONS,token: token.toString())
    .then((value) {
      log(value.toString());
      getNotificationsModel=GetNotificationsModel.fromJson(value.data);
      getNotificationsDone=true;
      emit(GetNotificationSuccessState());
    }).catchError((error){
      log(error.toString());
      emit(GetNotificationErrorState(error.toString()));
    });
  }

  //accept request
late AddRequestModel acceptRequestModel;

acceptRequest({required String userId}){
    emit(AcceptRequestLoadingState());
    DioHelper.postDataWithBearearToken(url: ACCEPTREQUEST, data: {
      "userId":userId,
    },token: token.toString())
    .then((value) {
      log(value.toString());
      acceptRequestModel=AddRequestModel.fromJson(value.data);
      getNotifications();
      emit(AcceptRequestSuccessState());
      sendNotification(userid: userId, type: 1,
          body: "تم قبول طلب المحادثة من قبل $name", title: "");
    }).catchError((error){
     log(error.toString());
      emit(AcceptRequestErrorState(error.toString()));
    });
}

//ignore request
  late AddRequestModel ignoreRequestModel;
  ignoreRequest({required String userId}){
    emit(IgnoreRequestLoadingState());
    DioHelper.postDataWithBearearToken(url: IGNOREREQUEST, data: {
      "userId":userId,
    },token: token.toString())
        .then((value) {
      log(value.toString());
      ignoreRequestModel=AddRequestModel.fromJson(value.data);
      getNotifications();
      emit(IgnoreRequestSuccessState());
      sendNotification(userid: userId, type: 2,
          body: "تم رفض طلب المحادثة من قبل $name", title: "");
    }).catchError((error){
      log(error.toString());
      emit(IgnoreRequestErrorState(error.toString()));
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