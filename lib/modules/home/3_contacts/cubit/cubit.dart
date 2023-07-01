import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../../constants.dart';
import '../../../../models/contacts.dart';
import '../../../../end_points.dart';
import '../../../../shared/network/remote.dart';
import 'states.dart';

class ContactsCubit extends Cubit<ContactsStates> 
{
  ContactsCubit() : super(ContactsInitialState());

  static ContactsCubit get(context) => BlocProvider.of(context);

  List<ContactDetails> contacts=[];

  void getContacts() 
  {
    initializeDateFormatting('ar_SA', null);
    emit(GetContactsLoadingState());
    DioHelper.getDataWithBearerToken(
      url: GETCONTACTS, 
      token: TOKEN.toString()
    )
    .then((value) 
    {
      log(value.toString());

      for (var item in value.data["data"]) 
      {
        ContactDetails cont  = new ContactDetails.fromJson(item);
        contacts.add( cont );
      }

      emit(GetContactsSuccessState( contacts ));
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
