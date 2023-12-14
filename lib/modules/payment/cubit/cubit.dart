import 'dart:developer';

import '../../../models/get_notifications.dart';
import '../../../shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../constants.dart';
import '../../../end_points.dart';
import '../../../models/activate_model.dart';
import '../../../shared/network/local.dart';
import '../../../shared/network/remote.dart';
import 'states.dart';

class PaymentCubit extends Cubit<PaymentStates> 
{
  PaymentCubit() : super(PaymentInitialState());

  //late LoginModel loginModel;
  static PaymentCubit get(context) => BlocProvider.of(context);

  bool isPayment = false;
  setIsPayment({required value}) {
    isPayment = value;
    emit( SetIsPaymentState() );
  }

  late InAppWebViewController controller;
  setControler(InAppWebViewController _controler){
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

  
  String? url;  //  like this --> https://payment.paylink.sa/pay/info/1702385038535
  String? transactionNo;

  void addInvoice({required double price}) 
  {
    emit(AddInvoiceLoadingState());
    DioHelper.postDataWithBearearToken (
      url: ADDINVOICE, //"api/v1/AddInvoice"
      data: {
        "amount": price,
        "clientEmail": EMAIL,
        "clientMobile": PHONE,
        "clientName": NAME,
        "note": "This invoice is for VIP client."
      },
      token: TOKEN.toString()

    ).then((value) {
      log(value.toString());
      this.url = value.data['data']['url'];      
      this.transactionNo = value.data['data']['transactionNo'];
      
      emit(AddInvoiceSuccessState());

    }).catchError((error) {
      log(error.toString());
      emit(AddInvoiceErrorState(error.toString()));
    });
  }

  String? orderSatus;

  void getInvoiceStatus({required dynamic  serviceId, required String type}) 
  {
    emit(GetInvoiceStatusLoadingState());

    DioHelper.postDataWithBearearToken(
            url: "api/v1/GetInvoice?transactionNo=$transactionNo",
            data: {},
            token: TOKEN.toString()
    )
    .then((value) 
    {
      log(value.toString());
      orderSatus = value.data['orderStatus'];

      if(IS_DEVELOPMENT_MODE) orderSatus="Paid";

      if(orderSatus=="Paid")
      {
        if(type=="package"){
          CacheHelper.saveData(key: "isLogin", value: true);
          IS_LOGIN = CacheHelper.getData(key: "isLogin");
        }

        // add Ad for user in DB
        activate(serviceId: serviceId, type: type);
      }else{
        showToast(msg: "عملية دفع فاشلة", state: ToastStates.ERROR);
      }

      emit(GetInvoiceStatusSuccessState(orderSatus));
    }).catchError((error) {
      log(error.toString());
      emit(GetInvoiceStatusErrorState(error.toString()));
    });
  }

  late ActivateModel activateModel;

  void activate({required dynamic serviceId, required String type}) 
  {
    print(serviceId);
    emit(ActivateLoadingState());
    DioHelper.postDataWithBearearToken(
      url: ACTIVATE, 
      data: {
        "type": type=="package" ? 1 : type=="Ads"? 2 : 3 ,
        "id": serviceId
      }, 
      token: TOKEN.toString())
    .then((value) 
    {
      log(value.toString());
      activateModel = ActivateModel.fromJson(value.data);

      emit(ActivateSuccessState(type: type, status: activateModel.status! ));

      if( type == "Ads" && activateModel.status! ){
          this.sendNotificationToAll(body: "تمت اضافة اعلان من قبل $NAME");
      }
      log( " ACTIVATE, Ad is Saved in DB ------------------");

    }).catchError((error) {
      log(error.toString());
      emit(ActivateErrorState(error.toString()));
    });
  }

  void sendNotificationToAll({String title=" ", required String body}) async
  {
    emit(SendNotificationToAllLoadingState());

    DioHelper.postDataWithBearearToken(
        url: "api/v2/send-notifications-to-all",
        data:{
          // "projectName": APP_NAME,
          // "deviceType":"android",
          "title": title,
          "body": body,
          "notificationType": NotificationTypes.AdIsPublished,
        },
        token: TOKEN )
    .then((value) 
    {
      log(value.toString() + "------------------");
      emit(SendNotificationToAllSuccessState());
    }).catchError((error){
      log(error.toString());
      emit( SendNotificationToAllErrorState(error.toString())  );
    });
  }


} //end class
