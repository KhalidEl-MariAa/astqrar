import 'dart:convert';
import 'dart:developer';

import 'package:signalr_netcore/signalr_client.dart';

import '../../../models/server_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../models/get-messages-model.dart';
import '../../../end_points.dart';
import '../../../models/get_information_user.dart';
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
      emit(GetMessagesSuccessState(otherUser));
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

      fillAllArrays(res);

      emit(GetMessagesSuccessState(this.otherUser));
    }).catchError((error) {
      log(error.toString());
      emit(GetMessagesErrorState(error.toString()));
    });
  }

  void fillAllArrays(ServerResponse res) 
  {
    for (var m in res.data['messages']) {
      Message msg = Message.fromJson(m);
      // print(res.data[i].senderId);
      ConversationScreenState.messages.add(msg.message!);
      ConversationScreenState.senderIdList.add(msg.senderId.toString());
      ConversationScreenState.dateMessages.add(
          DateFormat('mm : hh a   dd / MM/ yyyy', 'ar_SA')
              .format(msg.date!));

      // log(ConversationScreenState.senderIdList.toString());
      if (ID == msg.senderId) {
        msg.isMine = true;
        ConversationScreenState.messagesMine.add(true);
      } else {
        ConversationScreenState.messagesMine.add(false);
        msg.isMine = false;
      }
    }
  }

  void send_a_message(HubConnection hub, String receiverId, String msgText)
  {
    emit(SendMessageLoadingState());

    hub.invoke('SendMessagee', args: [ID!, receiverId, msgText, 0, 1, 1])
    .then( (value) 
    {
      log(value.toString());
      log("sent ttttttttttt ggggg");

      String str = jsonEncode( value );
      dynamic msg = jsonDecode(str);
      
      emit(SendMessageSuccessState( Message.fromJson(msg) ));

    }).catchError((e) {
      log('Failed to send ....... ❌❌ ');
      log(e.toString());
      emit(SendMessageErrorState());
    });
  }


}
