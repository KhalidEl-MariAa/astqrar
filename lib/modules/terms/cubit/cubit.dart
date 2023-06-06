import 'dart:developer';

import '../../../models/get_terms_conditions_model.dart';
import 'states.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TermsAndConditionsCubit extends Cubit<TermsAndConditionsStates> {
  TermsAndConditionsCubit() : super(TermsAndConditionsInitialState());

  //late LoginModel loginModel;
  static TermsAndConditionsCubit get(context) => BlocProvider.of(context);

  late GetTermsAndConditionsModel termsAndConditionsModel;
  List<String> splitting=[];
  getConditions(){
    emit(TermsAndConditionsLoadingState());
    DioHelper.postData(url:CONDITIONS, data: {})
    .then((value) {
      log(value.toString());
      termsAndConditionsModel=GetTermsAndConditionsModel.fromJson(value.data);
      splitting=termsAndConditionsModel.data!.condtions!.split('\r\n•\t');
      log(termsAndConditionsModel.data!.condtions!.split('\r\n•\t').toString());
      emit(TermsAndConditionsSuccessState());
    }).catchError((error){
      log(error.toString());
      emit(TermsAndConditionsErrorState(error.toString()));
    });
  }
}