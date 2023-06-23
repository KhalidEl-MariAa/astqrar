import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants.dart';
import '../../../../../models/server_response_model.dart';
import '../../../../../shared/network/end_points.dart';
import '../../../../../shared/network/remote.dart';
import 'states.dart';

class ContactUsCubit extends Cubit<ContactUsStates> 
{
  ContactUsCubit() : super(ContactUsInitialState());

  static ContactUsCubit get(context) => BlocProvider.of(context);
  late ServerResponse contactUsModel;

  sendContact({required String message,required String userName,
  required String phone}){
    emit(ContactUsLoadingState());
    DioHelper.postDataWithBearearToken(
      url: CONTACTUS, 
      data: {
        "userName":userName,
        "phone":phone,
        "msg":message
      },
      token: token.toString()
    )
    .then((value) {
      log(value.toString());
      contactUsModel=ServerResponse.fromJson(value.data);
      emit(ContactUsSuccessState(contactUsModel));
    }).catchError((error){
      log(error.toString());
      emit(ContactUsErrorState(error.toString()));
    });
  }
}