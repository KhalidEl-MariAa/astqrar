import 'dart:developer';

import 'package:astarar/models/delegate/profile_delegate_model.dart';
import 'package:astarar/models/delegate/update_price_model.dart';
import 'package:astarar/modules/specific_delegate_screen/cubit/states.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:astarar/shared/network/end_points.dart';
import 'package:astarar/shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileDeleagateCubit extends Cubit<ProfileDeleagateStates> {
  ProfileDeleagateCubit() : super(ProfileDelegateInitialState());

  static ProfileDeleagateCubit get(context) => BlocProvider.of(context);

  late ProfileDelegateModel profileDelegateModel;
  bool getProfile = false;
  List<ClientsDataModel> rates = [];
  Map<String, bool> clients = {};
  List<ClientsDataModel> clientsDelegate = [];

  getProfileDelegate({required String delegateId}) {
    rates = [];
    getProfile = false;
    emit(GetProfileDelegateLoadingState());
    DioHelper.getDataWithQuery(
        url: GETPROFILEDELEGATE,
        query: {"DelegateId": delegateId}).then((value) {
      profileDelegateModel = ProfileDelegateModel.fromJson(value.data);
      for (int i = 0; i < profileDelegateModel.clients.length; i++) {
        if (profileDelegateModel.clients[i].isClientDelegate == true) {
          clientsDelegate.add(profileDelegateModel.clients[i]);
        }
        if (profileDelegateModel.clients[i].isClientDelegate == false &&
            profileDelegateModel.clients[i].rate! > 0) {
          rates.add(profileDelegateModel.clients[i]);
        }
      }
      getProfile = true;
      log(value.toString());
      emit(GetProfileDelegateSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetProfileDelegateErrorState(error.toString()));
    });
  }

  //remove client

  late UpdatePriceModel removeClientModel;

  removeUser({required String userId}) {
    clientsDelegate = [];
    for (int i = 0; i < profileDelegateModel.clients.length; i++) {
      if (profileDelegateModel.clients[i].client!.id == userId) {
        profileDelegateModel.clients[i].isDeleted = true;
      }
      if (profileDelegateModel.clients[i].isDeleted == false&&profileDelegateModel.clients[i].rate==0) {
        clientsDelegate.add(profileDelegateModel.clients[i]);
      }
    }
    emit(RemoveUserLoadingState());
    DioHelper.postData(
        url: DELETECLIENT,
        data: {"DelegateId": id!, "ClientId": userId}).then((value) {
      log(value.toString());
      removeClientModel = UpdatePriceModel.fromJson(value.data);

      emit(RemoveUserSuuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(RemoveUserErrorState(error.toString()));
    });
  }
}
