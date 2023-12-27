import 'dart:developer';

import 'package:astarar/models/server_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';
import '../../../../end_points.dart';
import '../../../../models/get_notifications.dart';
import '../../../../shared/network/remote.dart';
import 'states.dart';

class NotificationCubit extends Cubit<NotificationStates> 
{
  NotificationCubit() : super(NotificationInitialState());

  static NotificationCubit get(context) => BlocProvider.of(context);
  
  late GetNotificationsModel getNotificationsModel;
  
  void getNotifications()
  {
    emit(GetNotificationLoadingState());

    DioHelper.getDataWithBearerToken(
      url: GETNOTIFICATIONS,
      token: TOKEN.toString()
    ).then((value) {

      log(value.toString());
      getNotificationsModel = GetNotificationsModel.fromJson(value.data);
      emit(GetNotificationSuccessState());

    }).catchError((error)
    {
      log(error.toString());
      emit(GetNotificationErrorState(error.toString()));
    });
  }


  void removeNotification({required int index})
  {
    emit(RemoveNotificationLoadingState(index));
    
    DioHelper.postDataWithBearearToken(
      token: TOKEN.toString(),
      url: REMOVENOTIFICATION, 
      // noteId, required int notificationType
      data: { 
        "noteId": this.getNotificationsModel.data[index].notification?.id??0,
        "notificationType": this.getNotificationsModel.data[index].notification?.notificationType??0
      }
    )
    .then((value) {
      
      ServerResponse res = ServerResponse.fromJson(value.data);
      if( res.key == 0){
        RemoveNotificationErrorState(res.msg??"خطأ غير معروف");
      }

      this.getNotificationsModel.data.removeAt(index);      
      emit(RemoveNotificationSuccessState());

    }).catchError((error){
      log(error.toString());
      emit(RemoveNotificationErrorState(error.toString()));
    });
  }

  //send notification


  // void acceptChattRequest({required String userId})
  // {
  //   //accept request
  //   late ServerResponse res;
  //   emit(AcceptChattRequestLoadingState());
  //   DioHelper.postDataWithBearearToken(
  //     url: ACCEPTREQUEST, 
  //     data: {
  //       "userId":userId,
  //   },
  //   token: TOKEN.toString()
  //   ).then((value) {
  //     log(value.toString());
  //     res = ServerResponse.fromJson(value.data);
  //     log(res.key.toString());
  //     getNotifications();
  //     emit(AcceptChattRequestSuccessState());
  //     sendNotification(
  //       userid: userId, 
  //       type: 1,
  //       body: "تم قبول طلب المحادثة من قبل $NAME", 
  //       title: ""
  //     );
  //   }).catchError((error){
  //     log(error.toString());
  //     emit(AcceptChattRequestErrorState(error.toString()));
  //   });
  // }

  // void ignoreRequest({required String userId})
  // {
  //   //ignore request
  //   late ServerResponse res;
  //   emit(IgnoreChattRequestLoadingState());
  //   DioHelper.postDataWithBearearToken(
  //     url: IGNOREREQUEST, 
  //     data: {
  //       "userId":userId,
  //     },
  //     token: TOKEN.toString()
  //   ).then((value) {
  //     log(value.toString());
  //     res = ServerResponse.fromJson(value.data);
  //     log(res.key.toString());
  //     getNotifications();
  //     emit(IgnoreChattRequestSuccessState());
  //     sendNotification(
  //       userid: userId, 
  //       type: 2,
  //       body: "تم رفض طلب المحادثة من قبل $NAME", 
  //       title: "");
  //   }).catchError((error){
  //     log(error.toString());
  //     emit(IgnoreChattRequestErrorState(error.toString()));
  //   });
  // }

}