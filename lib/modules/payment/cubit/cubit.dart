import 'package:astarar/models/activate_model.dart';
import 'package:astarar/modules/payment/cubit/states.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:astarar/shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../shared/network/end_points.dart';
import '../../../shared/network/local.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  PaymentCubit() : super(PaymentInitialState());

  //late LoginModel loginModel;
  static PaymentCubit get(context) => BlocProvider.of(context);

  bool isPayment = false;
  String? url;
  String? transactionNo;

  changePayment({required value}) {
    isPayment = value;
    emit(ChangePaymentState());
  }

  addInvoice({required double price}) {
    emit(AddInvoiceLoadingState());
    DioHelper.postDataWithBearearToken(
            url: ADDINVOICE,
            data: {
              "amount": price,
              "clientEmail": email,
              "clientMobile": phone,
              "clientName": name,
              "note": "This invoice is for VIP client."
            },
            token: token.toString())
        .then((value) {
      print(value.toString());
      url = value.data['data']['url'];
      print(value.data['data']['url']);
      transactionNo = value.data['data']['transactionNo'];
      print(value.data['data']['transactionNo']);
      emit(AddInvoiceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AddInvoiceErrorState(error.toString()));
    });
  }

  late InAppWebViewController controller;

  setControler(InAppWebViewController _controler) {
    controller = _controler;
    emit(SetControllerState());
  }

  Uri? uri;

  setUrl(Uri _uri) {
    uri = _uri;
    emit(SetUrlState());
  }

  int progress = 0;

  setProgress(int _Progress) {
    progress = _Progress;
    emit(SetProgressState());
  }

  String? orderSatus;

  getInvoiceStatus({required dynamic  serviceId,required int type}) {
    emit(GetInvoiceStatusLoadingState());
    DioHelper.postDataWithBearearToken(
            url: "api/v1/GetInvoice?transactionNo=$transactionNo",
            data: {},
            token: token.toString())
        .then((value) {
      print(value.toString());
      orderSatus = value.data['orderStatus'];
      if(orderSatus=="Paid"){
        activate(serviceId: serviceId, type: type);
        if(type==1){
          CacheHelper.saveData(
              key: "isLogin", value: true);
          isLogin = CacheHelper.getData(key: "isLogin");
        }
      }

      emit(GetInvoiceStatusSuccessState(orderSatus));
    }).catchError((error) {
      print(error.toString());
      emit(GetInvoiceStatusErrorState(error.toString()));
    });
  }

  late ActivateModel activateModel;

  activate({required dynamic serviceId,required int type}) {
    print(serviceId);
    emit(ActivateLoadingState());
    DioHelper.postDataWithBearearToken(
            url: ACTIVATE, data: {
"type":type,
      "id":serviceId
    }, token: token.toString())
        .then((value) {
      print(value.toString());
      activateModel = ActivateModel.fromJson(value.data);
    /*  if(type==2&&activateModel.status!){
        sendNotificationToAll(body: "تمت اضافة اعلان من قبل $name");
      }*/
      emit(ActivateSuccessState(
        type: type,
        status: activateModel.status!
      ));
    }).catchError((error) {
      print(error.toString());
      emit(ActivateErrorState(error.toString()));
    });
  }


  sendNotificationToAll({required String body}){
    emit(SendNotificationToAllLoadingState());
    DioHelper.postDataWithBearearToken(url: SENDNOTIFICATIONTOALL,
        data:{
        "projectName":"استقرار",
        "deviceType":"android",
        "notificationType":3,
        "body":body,
        "title":" "
        },token: token.toString())..then((value) {
          print(value.toString());
          emit(SendNotificationToAllSuccessState());
    }).catchError((error){
          print(error.toString());
          emit(SendNotificationToAllErrorState(error.toString()));
    });
  }
}
