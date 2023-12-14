import '../chatt/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/double_infinity_material_button.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../shared/components/accept_success_dialog.dart';
import '../../shared/components/default_text.dart';
import '../../shared/components/logo/normal_logo.dart';
import '../../shared/styles/colors.dart';
import '../home/2_home_tab/cubit/cubit.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'webb.dart';

class PaymentScreen extends StatelessWidget 
{
  final double? price;
  final String serviceType;
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
        if (state is AddInvoiceSuccessState) 
        {
          navigateTo(
            context: context, 
            widget: Web(
                    price: this.price, 
                    idService: idService, 
                    serviceType: serviceType,)
          );
          showToast(msg: "تم إنشاء فاتورة بمبلغ " + this.price.toString() + " ريال", state: ToastStates.SUCCESS);
        }

        if (state is GetInvoiceStatusSuccessState) 
        {
          showToast(msg: "تم التحقق من عملية الدفع ", state: ToastStates.SUCCESS);
            // showDialog(
            //     context: context,
            //     builder: (context) => SuccessDialog(
            //           successText: "تم الدفع بنجاح",
            //           subTitle: "يمكنك الان التصفح و المحادثة",
            //           actionText: "الرجوع للرئيسية",
            //         ));
        }


        if(state is ActivateSuccessState)
        {
          if(state.status && state.type==2){
            HomeCubit.get(context).getUserAds();
          }

          // if(state.status) {
          //     showDialog(
          //       context: context,
          //       builder: (context) => SuccessDialog(
          //             successText: "تم الدفع بنجاح",
          //             subTitle: "يمكنك الان التصفح و المحادثة",
          //           ));
          // }
          showToast(msg: "تم ", state: ToastStates.SUCCESS);

        }

      },
      builder: (context, state) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: WHITE,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(10.h),
            child: NormalLogo(appbarTitle: "طرق الدفع",isBack: false),
          ),
          body: 
            Column(
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
                    color: BLACK,
                    size: 19,
                    text: "${this.price}   ريال",
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
                            color: BLACK,
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

                    // اختيار الدفع عن طريق باي لنك
                    Checkbox(
                      value: PaymentCubit.get(context).isPayment,
                      activeColor: PRIMARY,
                      // fillColor:MaterialStateColor.resolveWith((states) => Colors.grey) ,
                      onChanged: (value) {
                        PaymentCubit.get(context).setIsPayment(value: value);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ],
                ),
                
                const Spacer(),

                Padding(
                  padding: EdgeInsetsDirectional.only(bottom: 4.h),
                  child: 
                    ConditionalBuilder(
                      condition: 
                        state is AddInvoiceLoadingState || 
                        state is GetInvoiceStatusLoadingState || 
                        state is ActivateLoadingState ||
                        state is SendMessageLoadingState ,
                      builder: (context) => 
                        Center(  child: CircularProgressIndicator() ),
                      fallback: (context) => 
                        doubleInfinityMaterialButton(
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
    );
  }
}
