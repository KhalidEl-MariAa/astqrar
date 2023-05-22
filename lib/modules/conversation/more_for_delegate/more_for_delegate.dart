import 'package:astarar/layout/layout.dart';
import 'package:astarar/modules/conversation/more_for_delegate/cubit/cubit.dart';
import 'package:astarar/modules/conversation/more_for_delegate/cubit/states.dart';
import 'package:astarar/modules/conversation/more_for_delegate/rate_delegate.dart';
import 'package:astarar/modules/more/widgets/default_raw.dart';
import 'package:astarar/modules/payment/payment_screen.dart';
import 'package:astarar/modules/specific_delegate_screen/specific_Delegate_screen.dart';
import 'package:astarar/shared/components/components.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class MoreForDelegateScreen extends StatefulWidget {
  final String delegateName;
  final String delegateId;

  const MoreForDelegateScreen(
      {Key? key, required this.delegateName, required this.delegateId})
      : super(key: key);

  @override
  State<MoreForDelegateScreen> createState() => _MoreForDelegateScreenState();
}

class _MoreForDelegateScreenState extends State<MoreForDelegateScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PaymentDelegateCubit.get(context)
        .checkClientPay(delegateId: widget.delegateId);
    PaymentDelegateCubit.get(context).getPrice(delegateId: widget.delegateId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentDelegateCubit, PaymentStates>(
      listener: (context, state) {
        if (state is PaymentConfirmationSuccessState) {
          if (state.paymentConfirmationModel.item1!) {
            showToast(
                msg: "تم تاكيد الدفع للخطابة", state: ToastStates.SUCCESS);
          } else {
            showToast(
                msg: "حدث خطا ما , اعد المحاولة", state: ToastStates.ERROR);
          }
        }
        if (state is AddRateSuucessState) {
          if (state.rateDelegateModel.key == 1) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false);
          }
        }
      },
      builder: (context, state) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(19.h),
              child: Container(
                height: 15.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/appbarimage.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: AppBar(
                  toolbarHeight: 15.h,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        widget.delegateName,
                        style: TextStyle(color: white, fontSize: 11.sp),
                      ),
                      Text(" ")
                    ],
                  ),
                  //   titleSpacing: -10,
                  leadingWidth: 13.w,
                  centerTitle: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: Padding(
                      padding:
                          EdgeInsetsDirectional.only(top: 2.h, start: 2.5.w),
                      child: Container(
                        height: 2.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(femaleImage))),
                      )),
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Material(
                    elevation: 10,
                    shadowColor: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 35.h,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          top: 2.h,
                          start: 8.w,
                          end: 3.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (isLogin)
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SpeceficDelegateScreen(
                                                  name: widget.delegateName,
                                                  id: widget.delegateId,
                                                )));
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsetsDirectional.only(top: 4.h),
                                    child: DefaultRaw(
                                        image: "assets/man-user.png",
                                        text: "الملف الشخصي"),
                                  )),
                            const Spacer(),
                            ConditionalBuilder(
                              condition: PaymentDelegateCubit.get(context)
                                  .checkPayDone,
                              fallback: (context) => Center(
                                child: CircularProgressIndicator(),
                              ),
                              builder: (context) => Padding(
                                padding:
                                    EdgeInsetsDirectional.only(bottom: 4.h),
                                child: doubleInfinityMaterialButton(
                                    text: PaymentDelegateCubit.get(context)
                                            .checkClientPayModel
                                            .result!
                                        ? "انهاء عملية الدفع"
                                        : "تأكيد الدفع للخطابة",
                                    onPressed: () {
                                      PaymentDelegateCubit.get(context)
                                              .checkClientPayModel
                                              .result!
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RateDelegate(
                                                        delegateId:
                                                            widget.delegateId,
                                                      )))
                                          : navigateTo(
                                              context: context,
                                              widget: PaymentScreen(
                                                  price: double.parse(
                                                      PaymentDelegateCubit.get(
                                                              context)
                                                          .getPriceModel
                                                          .price!
                                                          .toString()),
                                                  serviceType: "Delegate",
                                                  idService:
                                                      widget.delegateId));
                                      // : showDialog(
                                      //     context: context,
                                      //     builder: (context) => CustomDialog(
                                      //         text:
                                      //             "اسم العميل :$name \n\n اسم الخطابة :${widget.delegateName}\n\n اود تاكيد الدفع لها",
                                      //         price:
                                      //             PaymentDelegateCubit.get(context)
                                      //                 .getPriceModel
                                      //                 .price!),
                                      //   );
                                    }),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
