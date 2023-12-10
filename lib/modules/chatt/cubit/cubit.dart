import 'dart:convert';
import 'dart:developer';

import 'package:signalr_netcore/signalr_client.dart';

import '../../../models/server_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../constants.dart';
import '../../../models/message.dart';
import '../../../end_points.dart';
import '../../../models/user_other.dart';
import '../../../shared/network/remote.dart';
import '../chatt.dart';
import 'states.dart';

class ConversationCubit extends Cubit<ConversationStates> 
{
  ConversationCubit() : super(ConversationInitialState());

  static ConversationCubit get(context) => BlocProvider.of(context);
  late OtherUser otherUser;

  void getMessages({required String userId}) async 
  {
    emit(GetMessagesLoadingState());

    initializeDateFormatting('ar_SA', null);
    ConversationScreenState.messages = [
      "                              نظام مكافحة جريمة التحرش \n\n                                              المادة الاولى: \n\n يقصد بجريمة التحرش, لغرض تطبيق احكام هذا النظام كل قول او فعل او اشارة ذات مدلول جنسي تصدر من شخص تجاه اي شخص اخر , تمس جسده او عرضه , او تخدش حياءه , بأي وسيلة كانت ,بما فما ذلك وسائل التقنية الحديثة."
    ];
    ConversationScreenState.senderIdList = [ID!];
    ConversationScreenState.messagesMine = [true];
    ConversationScreenState.dateMessages = ["1/1/2002"];

    await DioHelper.getDataWithQuery(
            url: GETINFORMATIONUSER,
            query: {"otherId": userId},
            token: TOKEN.toString())
    .then((value) {
      this.otherUser = OtherUser.fromJson(value.data["otherUser"]);
      emit(GetOtherUserSuccess(otherUser));
    }).catchError((error) {
      emit(GetMessagesErrorState(error.toString()));
    });

    DioHelper.postData(
      url: GETMESSAGES, 
      data: {
        "SenderId": ID,
        "ReceiverId": userId,
        "OrderId": 0,
        "Type": 1,
        "Duration": 1
    }).then((value) {
      log(value.toString());

      ServerResponse res = ServerResponse.fromJson(value.data);
      emit(GetMessagesSuccessState(res.data['messages']));

    }).catchError((error) {
      log(error.toString());
      emit(GetMessagesErrorState(error.toString()));
    });
  }


  void send_a_message(HubConnection hub, String receiverId, String msgText)
  {
    emit(SendMessageLoadingState());

    hub.invoke('SendMessagee', args: [ID!, receiverId, msgText, 0, 1, 1])
    .then( (value) 
    {
      log(value.toString());

      if (value==null){
          emit(SendMessageErrorState("حصلت مشكلة اثناء الارسال"));  
          return;
      }

      String str = jsonEncode( value );
      dynamic msg = jsonDecode(str);
      
      emit(SendMessageSuccessState( Message.fromJson(msg) ));

    }).catchError((e) {
      log('Failed to send ....... ❌❌ ');
      log(e.toString());
      emit(SendMessageErrorState("غير متصل بمحرك المحادثات، الرجاء المحاولة لاحقاً"));
    });
  }


}
