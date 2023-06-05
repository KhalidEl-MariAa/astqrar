import 'dart:developer';
import 'dart:io';

import 'package:astarar/models/add_to_favourite.dart';
import 'package:astarar/models/delegate/check_client_pay.dart';
import 'package:astarar/models/delegate/get_price_model.dart';
import 'package:astarar/models/delegate/update_price_model.dart';
import 'package:astarar/modules/conversation/more_for_delegate/cubit/states.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:astarar/shared/network/end_points.dart';
import 'package:astarar/shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentDelegateCubit extends Cubit<PaymentStates> {
  PaymentDelegateCubit() : super(PaymentInitialState());

  //late LoginModel loginModel;
  static PaymentDelegateCubit get(context) => BlocProvider.of(context);


//payment confirmation
  late UpdatePriceModel paymentConfirmationModel;

  paymentConfirmation({delegateId}){
    emit(PaymentConfirmationLoadingState());
    DioHelper.postData(url: PAYMENTCONFIRMATION, data: {
      "ClientId":id,
      "DelegateId":delegateId
    }).then((value) {
      log(value.toString());
      paymentConfirmationModel=UpdatePriceModel.fromJson(value.data);
      emit(PaymentConfirmationSuccessState(paymentConfirmationModel));
      if(paymentConfirmationModel.item1!){
        sendNotification(userid: delegateId, type: 3, body:"تم تاكيد الدفع الك من قبل $name", title: "");
      }
    }).catchError((error){
      log(error.toString());
      emit(PaymentConfirmationErrorState(error.toString()));

    });
  }

  //check client pay

  late CheckClientPayModel checkClientPayModel;
  bool checkPayDone=false;
  checkClientPay({required String delegateId}){
    checkPayDone=false;
    emit(CheckClientPayLoadingState());
    DioHelper.postData(url: CHECKCLIENTPAY, data: {
      "ClientId":id,
      "DelegateId":delegateId
    })
    .then((value) {
      log(value.toString());
      checkClientPayModel=CheckClientPayModel.fromJson(value.data);
      checkPayDone=true;
      emit(CheckClientPaySuucessState());
    }).catchError((error){
      log(error.toString());
      emit(CheckClientPayErrorState(error.toString()));
    });
  }


  //get price deleget
  late GetPriceModel getPriceModel;
  String price="0";
  getPrice({required String delegateId}) {
    emit(GetPriceLoadingState());
    DioHelper.postData(url: GETPRICE, data: {"DelegateId": delegateId}).then((value) {
      log(value.toString());
      getPriceModel = GetPriceModel.fromJson(value.data);
      price = getPriceModel.price!;
      emit(GetPriceSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetPriceErrorState(error.toString()));
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

//add rate
late AddToFavouriteModel addRateModel;

addRate({required String delegateId,required int rate}){
    emit(AddRateLoadingState());
    DioHelper.postDataWithBearearToken(url: ADDRATE, data: {
      "delegetId":delegateId,
      "rate":rate
    },token: token.toString())
    .then((value) {
      log(value.toString());
      addRateModel=AddToFavouriteModel.fromJson(value.data);
      removeUser(delgateId: delegateId);
      emit(AddRateSuucessState(addRateModel));
    }).catchError((error){
      log(error.toString());
      emit(AddRateErrorState(error.toString()));
    });
}
  //remove client

  late UpdatePriceModel removeClientModel;
  removeUser({required String delgateId}){

    emit(RemoveUserLoadingState());
    DioHelper.postData(url: DELETECLIENT, data: {
      "DelegateId":delgateId,
      "ClientId":id!
    })
        .then((value) {
      log(value.toString());
      removeClientModel=UpdatePriceModel.fromJson(value.data);

      emit(RemoveUserSuuccessState());
    }).catchError((error){
      log(error.toString());
      emit(RemoveUserErrorState(error.toString()));
    });

  }
}