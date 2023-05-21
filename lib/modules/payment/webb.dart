import 'package:astarar/modules/payment/cubit/cubit.dart';
import 'package:astarar/modules/payment/cubit/states.dart';
import 'package:astarar/modules/payment/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Web extends StatelessWidget {
  double? price;
dynamic?idService;
String? serviceType;
  Web({Key? key, this.price,required this.serviceType,required this.idService}) : super(key: key);

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
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
      ));
  bool isLoading = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
              key: scaffoldKey,
              body: InAppWebView(
                initialUrlRequest:
                    URLRequest(url: Uri.parse(PaymentCubit.get(context).url!)),
                initialOptions: options,
                onWebViewCreated: (InAppWebViewController _controler) {
                  PaymentCubit.get(context).setControler(_controler);
                },
                onLoadStart: (InAppWebViewController _controler, Uri? _uri) {
                  PaymentCubit.get(context).setUrl(_uri!);
                  print(_uri);
                },
                onLoadStop:
                    (InAppWebViewController _controler, Uri? _uri) async {
                  if (_uri
                          .toString()
                          .endsWith(PaymentCubit.get(context).transactionNo!) &&
                      _uri.toString().startsWith("https://www.example.com")) {
                    PaymentCubit.get(context).getInvoiceStatus(
                      serviceId: idService!,
                      type: serviceType=="package"?1:serviceType=="Ads"?2:3,
                    );
                    Navigator.pushAndRemoveUntil(scaffoldKey.currentContext!,
                        MaterialPageRoute(builder: (context) {
                      return PaymentScreen(price: price,
                      idService: idService,serviceType: serviceType,);
                    }),(route) => false,);
                  } else {
                    PaymentCubit.get(context).setUrl(_uri!);
                  }
                },
                onProgressChanged:
                    (InAppWebViewController _controler, int _progress) {
                  PaymentCubit.get(context).setProgress(_progress);
                },
              ),
            ));
  }
}
