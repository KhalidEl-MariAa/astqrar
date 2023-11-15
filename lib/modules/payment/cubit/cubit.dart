import 'dart:developer';

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

  String? url;
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
      url = value.data['data']['url'];      
      transactionNo = value.data['data']['transactionNo'];
      
      emit(AddInvoiceSuccessState());

    }).catchError((error) {
      print(error.toString());
      emit(AddInvoiceErrorState(error.toString()));
    });
  }

  String? orderSatus;

  getInvoiceStatus({required dynamic  serviceId, required String type}) 
  {
    emit(GetInvoiceStatusLoadingState());
    DioHelper.postDataWithBearearToken(
            url: "api/v1/GetInvoice?transactionNo=$transactionNo",
            data: {},
            token: TOKEN.toString()
    )
    .then((value) {
      print(value.toString());
      orderSatus = value.data['orderStatus'];
      if(orderSatus=="Paid"){
        activate(serviceId: serviceId, type: type);
        if(type=="package"){
          CacheHelper.saveData(key: "isLogin", value: true);
          IS_LOGIN = CacheHelper.getData(key: "isLogin");
        }
      }

      emit(GetInvoiceStatusSuccessState(orderSatus));
    }).catchError((error) {
      print(error.toString());
      emit(GetInvoiceStatusErrorState(error.toString()));
    });
  }

  late ActivateModel activateModel;

  activate({required dynamic serviceId, required String type}) 
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
    .then((value) {
      print(value.toString());
      activateModel = ActivateModel.fromJson(value.data);
      // if(type==2&&activateModel.status!){
      //     sendNotificationToAll(body: "تمت اضافة اعلان من قبل $name");
      // }

      emit(ActivateSuccessState(
        type: type,
        status: activateModel.status!
      ));
    }).catchError((error) {
      print(error.toString());
      emit(ActivateErrorState(error.toString()));
    });
  }



}
