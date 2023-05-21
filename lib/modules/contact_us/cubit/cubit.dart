import 'dart:developer';

import 'package:astarar/models/register_delegate_model.dart';
import 'package:astarar/modules/contact_us/cubit/states.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:astarar/shared/network/end_points.dart';
import 'package:astarar/shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactUsCubit extends Cubit<ContactUsStates> {
  ContactUsCubit() : super(ContactUsInitialState());

  static ContactUsCubit get(context) => BlocProvider.of(context);
  late RegisterDelegateModel contactUsModel;

  sendContact({required String message,required String userName,
  required String phone}){
    emit(ContactUsLoadingState());
    DioHelper.postDataWithBearearToken(url: CONTACTUS, data: {
      "userName":userName,
      "phone":phone,
      "msg":message
    },token: token.toString()).then((value) {
      log(value.toString());
      contactUsModel=RegisterDelegateModel.fromJson(value.data);
      emit(ContactUsSuccessState(contactUsModel));
    }).catchError((error){
      log(error.toString());
      emit(ContactUsErrorState(error.toString()));
    });
  }
}