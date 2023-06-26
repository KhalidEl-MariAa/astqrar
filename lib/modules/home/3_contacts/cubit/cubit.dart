import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../../constants.dart';
import '../../../../models/get_my_contacts_model.dart';
import '../../../../end_points.dart';
import '../../../../shared/network/remote.dart';
import 'states.dart';

class ContactsCubit extends Cubit<ContactsStates> 
{
  ContactsCubit() : super(ContactsInitialState());

  static ContactsCubit get(context) => BlocProvider.of(context);

  late MyContactsModel myContactsModel;
  List<DataOfMyContactDetails> contacts=[];

  void getContacts() {
    initializeDateFormatting('ar_SA', null);
    emit(GetContactsLoadingState());
    DioHelper.getDataWithBearerToken(
      url: GETCONTACTS, 
      token: TOKEN.toString())
    .then((value) {
      log(value.toString());
      myContactsModel = MyContactsModel.fromJson(value.data);

      for (var item in myContactsModel.data) {
        contacts.add(item);
      }

      emit(GetContactsSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetContactsErrorState(error.toString()));
    });
  }

   void removeChat({required String userId}) 
   {
      emit(RemoveChatLoadingState());

      DioHelper.postDataWithBearearToken(
            url: REMOVECHAT, 
            data: {
              "SenderId":ID,
              "receiverId":userId,
            }, 
            token: TOKEN.toString()
      ).then((value) 
      {
        log(value.toString());

        contacts.removeWhere( (e) => e.userInformation?.id ==  userId);

        emit(RemoveChatSuccessState(value.statusCode!));
      }).catchError((error) {
        log(error.toString());
        emit(RemoveChateErrorState(error));
      });
  }
}
