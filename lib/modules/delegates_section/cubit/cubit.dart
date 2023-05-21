import 'dart:developer';

import 'package:astarar/models/delegate/get_all_delegates_model.dart';
import 'package:astarar/modules/delegates_section/cubit/states.dart';
import 'package:astarar/shared/network/end_points.dart';
import 'package:astarar/shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DelegatesCubit extends Cubit<DelegateSectionStates> {
  DelegatesCubit() : super(DelegateSectionInitialState());

  static DelegatesCubit get(context) => BlocProvider.of(context);

  late GetAllDelegatesModel getAllDelegatesModel;
  bool getDelegatesDone=false;
  getDelegates(){
    emit(GetDelegateLoadingState());
    DioHelper.getData(url: GETALLDELEGATE)
    .then((value) {
      log(value.toString());
      getAllDelegatesModel=GetAllDelegatesModel.fromJson(value.data);
      getDelegatesDone=true;
      emit(GetDelegateSuucessState());
    }).catchError((error){
      log(error.toString());
      emit(GetDelegateErrorState(error.toString()));
    });

  }
}