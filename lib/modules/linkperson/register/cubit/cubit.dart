import 'dart:developer';

import 'package:astarar/models/register_delegate_model.dart';
import 'package:astarar/modules/linkperson/register/cubit/states.dart';
import 'package:astarar/shared/network/end_points.dart';
import 'package:astarar/shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterLinkPersonCubit extends Cubit<RegisterLinkPersonStates> {
  RegisterLinkPersonCubit() : super(RegisterLinkPersonInitialState());

  //late LoginModel loginModel;
  static RegisterLinkPersonCubit get(context) => BlocProvider.of(context);

  late RegisterDelegateModel registerDelegateModel;

  registerDelegate(
      {required String name,
      required String phone,
      required String age,
      required String nationalityId,
      required String password,
      required String nationality,
      required String reson,
      required String moneydowry,
      required String city,required String experience}) {
    log(name);
    emit(RegisterLinkPersonLoadingState());
    DioHelper.postData(url: REGISTERDELEGATE, data: {
      "userName": name,
      "phone": phone,
      "Age": age,
      "Gender": "2",
      "NationalID": nationalityId,
      "password": password,
      "Nationality": nationality,
      "Answer": reson,
      "Experience": experience,
      "Price": moneydowry,
      "City": city,

    }).then((value) {
      log(value.toString());
      registerDelegateModel = RegisterDelegateModel.fromJson(value.data);
      emit(RegisterLinkPersonSuccessState(registerDelegateModel));
    }).catchError((error) {
     log(error.toString());
      emit(RegisterLinkPersonErrorState(error.toString()));
    });
  }
}
