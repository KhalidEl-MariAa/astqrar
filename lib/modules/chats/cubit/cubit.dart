import 'dart:developer';

import '../../../models/get_my_contacts_model.dart';
import 'states.dart';
import '../../../shared/contants/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

class ContactsCubit extends Cubit<ContactsStates> 
{
  ContactsCubit() : super(ContactsInitialState());

  //late LoginModel loginModel;
  static ContactsCubit get(context) => BlocProvider.of(context);

  late MyContactsModel myContactsModel;
  List<DataOfMyContactDetails> contacts=[];

  void getContacts() {
    initializeDateFormatting('ar_SA', null);
    emit(GetContactsLoadingState());
    DioHelper.getDataWithBearerToken(url: GETCONTACTS, token: token.toString())
        .then((value) {
      log(value.toString());
      myContactsModel = MyContactsModel.fromJson(value.data);
      for(int i=0;i<myContactsModel.data.length;i++){
        contacts.add(myContactsModel.data[i]);
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
              "SenderId":id,
              "receiverId":userId,
            }, 
            token: token.toString()
      ).then((value) {
      log(value.toString());
      
      //TODO: اضافة كود الخاص بحذف مستخدم من قائمة الشات
      //contacts=[];
      // for(int i=0;i<myContactsModel.data.length;i++){
      //   if(userId==myContactsModel.data[i].userInformation!.id){
      //     myContactsModel.data[i].isInMyContacts=false;
      //   }
      //   if(myContactsModel.data[i].isInMyContacts==true){
      //     contacts.add(myContactsModel.data[i]);
      //   }
      // }
      emit(RemoveChatSuccessState(value.statusCode!));
    }).catchError((error) {
      log(error.toString());
      emit(RemoveChateErrorState(error));
    });
  }
}
