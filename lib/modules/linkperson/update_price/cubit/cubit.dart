import 'dart:developer';

import 'package:astarar/models/delegate/get_price_model.dart';
import 'package:astarar/models/delegate/update_price_model.dart';
import 'package:astarar/modules/linkperson/update_price/cubit/states.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:astarar/shared/network/end_points.dart';
import 'package:astarar/shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriceCubit extends Cubit<PriceStates> {
  PriceCubit() : super(PriceInitialState());

  static PriceCubit get(context) => BlocProvider.of(context);

  late GetPriceModel getPriceModel;
  String price = "0";

  getPrice() {
    emit(GetPriceLoadingState());
    DioHelper.postData(url: GETPRICE, data: {"DelegateId": id}).then((value) {
      log(value.toString());
      getPriceModel = GetPriceModel.fromJson(value.data);
      price = getPriceModel.price!;
      emit(GetPriceSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetPriceErrorState(error.toString()));
    });
  }

  //updatePrice

  late UpdatePriceModel updatePriceModel;
  updatePrice({required double newprice}) {
    emit(UpdatePriceLoadingState());
    DioHelper.postData(url: UPDATEPRICE, data: {
      "DelegateId":id,
      "newPrice":newprice
    })
        .then((value) {
          print(value.toString());
          updatePriceModel=UpdatePriceModel.fromJson(value.data);
          if(updatePriceModel.item1!){
            price=newprice.toString();
          }
          emit(UpdatePriceSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(UpdatePriceErrorState(error.toString()));
    });
  }
}
