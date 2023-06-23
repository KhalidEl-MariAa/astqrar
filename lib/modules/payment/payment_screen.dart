import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../shared/components/accept_success_dialog.dart';
import '../../shared/components/components.dart';
import '../../shared/components/logo/normal_logo.dart';
import '../../shared/components/text/default_text.dart';
import '../../shared/styles/colors.dart';
import '../home/2_home_tab/cubit/cubit.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'webb.dart';

class PaymentScreen extends StatelessWidget 
{
  final double? price;
  final String? serviceType;
  final dynamic idService;

  PaymentScreen({
    Key? key,
    required this.price,
    required this.idService,
    required this.serviceType
  }): super(key: key);

  @override
  Widget build(BuildContext context) 
  {
    return BlocConsumer<PaymentCubit, PaymentStates>(
      listener: (context, state) async 
      {
        if (state is AddInvoiceSuccessState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Web(
                      price: price, idService: idService, serviceType: serviceType,
                    )
              ));
        }

        // if (state is GetInvoiceStatusSuccessState) {
        //   if (state.orderStatus == "Paid") {
        //     showDialog(
        //         context: context,
        //         builder: (context) => SuccessDialog(
        //               successText: "تم الدفع بنجاح",
        //               subTitle: "يمكنك الان التصفح و المحادثة",
        //               actionText: "الرجوع للرئيسية",
        //             ));
        //   }
        // }


        if(state is ActivateSuccessState)
        {
          if(state.status && state.type==2){
            HomeCubit.get(context).getUserAds();
          }

          if(state.status){
              showDialog(
                context: context,
                builder: (context) => SuccessDialog(
                      successText: "تم الدفع بنجاح",
                      subTitle: "يمكنك الان التصفح و المحادثة",
                      actionText: "الرجوع للرئيسية",
                    ));
          }
        }

        // if (state is GetInvoiceStatusLoadingState) {
        //   showDialog(
        //       context: context,
        //       builder: (context) => Container(
        //         decoration: BoxDecoration(color: Colors.transparent),
        //         height: 5.h,
        //         width: 20.w,
        //         child: AlertDialog(
        //               backgroundColor: Colors.transparent,
        //               content: Center(
        //                 child: CircularProgressIndicator(),
        //               ),
        //             ),
        //       ));
        // }
      },
      builder: (context, state) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(10.h),
            child: NormalLogo(appbarTitle: "طرق الدفع",isBack: false),
          ),
          body: ConditionalBuilder(
            condition: state is! GetInvoiceStatusLoadingState,
            fallback: (context)=>Center(child: CircularProgressIndicator(),),
            builder:(context)=> Column(
              children: [
                SizedBox( height: 3.h, ),
                Center(
                  child: Image.asset( "assets/wallet.png",
                    width: 50.w,
                    height: 17.h,
                  ),
                ),
                SizedBox( height: 3.h, ),
                Text( "المبلغ الاجمالي",
                  style: GoogleFonts.almarai(
                      fontSize: 16.sp, fontWeight: FontWeight.w300),
                ),
                SizedBox( height: 4.h, ),
                DefaultText(
                    color: black,
                    size: 19,
                    text: "${price}   ريال",
                    fontWeight: FontWeight.w500),
                SizedBox( height: 10.h, ),
                Row(
                  children: [
                    Image.asset( "assets/master.png",
                      width: 20.w,
                      height: 4.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                            color: black,
                            size: 11,
                            text: "PayLink",
                            fontWeight: FontWeight.w500),
                        SizedBox( height: 2.h, ),
                        DefaultText(
                            color: Colors.grey[500],
                            size: 9,
                            text: "ادفع باستخدام PayLink",
                            fontWeight: FontWeight.w500)
                      ],
                    ),
                    const Spacer(),
                    Checkbox(
                      value: PaymentCubit.get(context).isPayment,
                      activeColor: primary,
                      // fillColor:MaterialStateColor.resolveWith((states) => Colors.grey) ,
                      onChanged: (value) {
                        PaymentCubit.get(context).changePayment(value: value);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ],
                ),
                const Spacer(),
                ConditionalBuilder(
                  condition: state is! AddInvoiceLoadingState,
                  fallback: (context) => Padding(
                    padding: EdgeInsetsDirectional.only(bottom: 4.h),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  builder: (context) => Padding(
                    padding: EdgeInsetsDirectional.only(bottom: 4.h),
                    child: doubleInfinityMaterialButton(
                        text: "الدفع",
                        onPressed: () async {
                          PaymentCubit.get(context).addInvoice(price: price!);
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
