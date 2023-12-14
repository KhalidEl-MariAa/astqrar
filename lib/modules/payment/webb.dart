import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../constants.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'payment_screen.dart';

class Web extends StatelessWidget 
{
  final double? price;
  final dynamic idService;
  final String serviceType;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  Web({Key? key, this.price, required this.serviceType, required this.idService}) : super(key: key);

  final InAppWebViewGroupOptions inAppWebViewOptions = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        disableHorizontalScroll: false,
        disableVerticalScroll: false,
        supportZoom: false,
        verticalScrollBarEnabled: false,
      ),

      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),

      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      )
  );


  @override
  Widget build(BuildContext context) 
  {
    return BlocConsumer<PaymentCubit, PaymentStates>(
      listener: (context, state) {},
      builder: (context, state) => 
        Scaffold(
          key: scaffoldKey,
          body: 
            InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(PaymentCubit.get(context).url!)),

              initialOptions: inAppWebViewOptions,

              onWebViewCreated: (InAppWebViewController _controler) {
                PaymentCubit.get(context).setControler(_controler);
              },

              // https://payment.paylink.sa/pay/info/1702385038535
              onLoadStart: (InAppWebViewController _controler, Uri? _uri) 
              {
                PaymentCubit.get(context).setUrl(_uri!);
                log(_uri.toString());
              },

              // بعد تحميل الصفحة
              onLoadStop: (InAppWebViewController _controler, Uri? _uri) async 
              {
                bool is_correct_callback_uri = 
                    _uri.toString().endsWith(PaymentCubit.get(context).transactionNo!) 
                    &&
                    _uri.toString().startsWith("https://www.example.com") ;
                
                if(IS_DEVELOPMENT_MODE) is_correct_callback_uri=true;

                if (is_correct_callback_uri) 
                {
                  Navigator.pushAndRemoveUntil(
                      scaffoldKey.currentContext!,
                      MaterialPageRoute(
                        builder: (context) {
                          return PaymentScreen(price: price,
                          idService: idService,serviceType: serviceType,);
                        }
                      ),
                      (route) => false,);

                  PaymentCubit.get(context).getInvoiceStatus(
                    serviceId: idService!,
                    type: serviceType,
                  );

                }else{
                  PaymentCubit.get(context).setUrl(_uri!);
                }
              },

              onProgressChanged: (InAppWebViewController _controler, int _progress) 
              {
                PaymentCubit.get(context).setProgress(_progress);
              },

            ),
        )
    );
  }
} //end class
