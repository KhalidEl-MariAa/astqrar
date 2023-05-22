

import 'package:astarar/modules/linkperson/update_price/cubit/cubit.dart';
import 'package:astarar/modules/linkperson/update_price/cubit/states.dart';
import 'package:astarar/shared/components/components.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class UpdatePrice extends StatelessWidget {

  const UpdatePrice({Key? key}) : super(key: key);
  static var priceController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context)=>PriceCubit()..getPrice(),
      child: BlocConsumer<PriceCubit,PriceStates>(
        listener: (context,state){
          if(state is UpdatePriceSuccessState){
            Navigator.pop(context);
          }
        },
        builder:(context,state){
          priceController.text=PriceCubit.get(context).price;
          return Directionality
        (
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: Container(
              height: 30.h,
              child: Column(
                children: [
                  Material(
                    elevation: 5.0,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0)),
                    child: Container(
                      height: 60.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: primary,
                          borderRadius:const  BorderRadius.only(
                              bottomLeft: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0))),
                      child: Center(
                        child: Text(
                          "حددي السعر",
                          style: TextStyle(color: white, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                      padding:
                      const EdgeInsetsDirectional.only(start: 15.0, end: 15.0),
                      child: defaultTextFormField(
                          context: context,
                          controller: priceController,
                          container: Colors.grey[100],
                          styleText: Colors.black,
                          borderColor: primary,

                          type: TextInputType.number,
                          validate: (value) { return null;},
                          label: "حدد السعر",
                          labelText: "حدد السعر",
                          prefixIcon: Icons.money)),

                  const Spacer(),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        bottom: 20.0, start: 30, end: 30),
                    child: doubleInfinityMaterialButton(
                        text: "تعديل",
                        onPressed: () {
                          PriceCubit.get(context).updatePrice(newprice: double.parse(UpdatePrice.priceController.text));
                        }),
                  ),
                ],
              ),
            ),
          ),
        );}
      ),
    );
  }
}
