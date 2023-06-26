import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../models/get-messages-model.dart';
import '../../../end_points.dart';
import '../../../shared/network/remote.dart';
import '../chatt.dart';
import 'states.dart';

class ConversationCubit extends Cubit<ConversationStates> 
{
  ConversationCubit() : super(ConversationInitialState());

  static ConversationCubit get(context) => BlocProvider.of(context);
  late GetMessagesModel getMessagesModel;


  getMessages({required String userId,  required bool typeUserChat}) 
  {
    emit(GetMessagesLoadingState());
    
    initializeDateFormatting('ar_SA', null);
    ConversationScreenState.messages = [
      typeUserChat?
      "                              نظام مكافحة جريمة التحرش \n\n                                              المادة الاولى: \n\n يقصد بجريمة التحرش, لغرض تطبيق احكام هذا النظام كل قول او فعل او اشارة ذات مدلول جنسي تصدر من شخص تجاه اي شخص اخر , تمس جسده او عرضه , او تخدش حياءه , بأي وسيلة كانت ,بما فما ذلك وسائل التقنية الحديثة."
   :"لا يحق طلب استرجاع المبلغ المدفوع في الحالات التالية :\n\n-الغاء الخطابة . \n\n-الانسحاب من التطبيق. \n\n-حذف العضوية بسبب مخالفة شروط و احكام التطبيق. \n\n-تواصل العميل مع الخطابة او دفع مبلغ السعي للخطابة خارج التطبيق. \n\n-في حال عدم الرد العميل لمدة تتجاوز الشهر ." ];
    ConversationScreenState.senderIdList = [ID!];
    ConversationScreenState.messagesMine = [true];
    ConversationScreenState.dateMessages = ["1/1/2002"];

    DioHelper.postData(url: GETMESSAGES, data: {
      "SenderId": ID,
      "ReceiverId": userId,
      "OrderId": 0,
      "Type": 1,
      "Duration": 1
    }).then((value) {
      log(value.toString());
      getMessagesModel = GetMessagesModel.fromJson(value.data);
      for (int i = 0; i < getMessagesModel.data.length; i++) {
        print(getMessagesModel.data[i].senderId);
        ConversationScreenState.messages
            .add(getMessagesModel.data[i].message!);
        ConversationScreenState.senderIdList
            .add(getMessagesModel.data[i].senderId.toString());
        ConversationScreenState.dateMessages.add(
            DateFormat('mm : HH  dd / MM/ yyyy', 'ar_SA')
                .format(DateTime.parse(getMessagesModel.data[i].date!)));
        log(ConversationScreenState.senderIdList.toString());
        if (ID == getMessagesModel.data[i].senderId) {
          getMessagesModel.data[i].isMine = true;
          ConversationScreenState.messagesMine.add(true);
        } else {
          ConversationScreenState.messagesMine.add(false);
          getMessagesModel.data[i].isMine = false;
        }
      }
      emit(GetMessagesSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetMessagesErrorState(error.toString()));
    });
  }

  /*
late ChatModel chat;
  connect()async {
    await UserConversationScreenState.hubConnection.start()?.then((value) => print('connected'));
    UserConversationScreenState.hubConnection.invoke('Connect',
        args: [id!]).then((value) => print("connected user success"));
    UserConversationScreenState.hubConnection.on('receiveMessage', (arguments) {
      print(arguments);
      dynamic ss = {};

      ss = jsonEncode(arguments![0]);
      jsonDecode(ss);
      chat = ChatModel.fromJson(jsonDecode(ss));
      receiveMessage();
    });

}
  receiveMessage(){

    UserConversationScreenState.messages.add(chat.text.toString());
    UserConversationScreenState.messagesMine.add(false);
    UserConversationScreenState.senderIdList.add(chat.senderId.toString());
    print(DateTime.tryParse(chat.date!));
    print(DateFormat('yyyy-MM-dd hh:mm:ss').parse(chat.date!).toString());

    emit(ReceiveMessageSuccessState());
  }*/

  void send() {
    log(DateTime.now().toString());
    log(DateFormat('HH:mm', 'ar_SA').format(DateTime.now()));
    ConversationScreenState.messages
        .add(ConversationScreenState.messagecontroller.text);
    ConversationScreenState.messagesMine.add(true);
    ConversationScreenState.senderIdList.add(ID!);
    ConversationScreenState.dateMessages
        .add(DateFormat('HH : mm', 'ar_SA').format(DateTime.now()));

    ConversationScreenState.messagecontroller.clear();
    emit(SendMessageSuccessState());
  }
  
/*sendMessage({required String userId})async {
  if (UserConversationScreenState().hubConnection.state == HubConnectionState.Connected) {
    await UserConversationScreenState().hubConnection.invoke('SendMessagee', args: [
      id!,
      userId,
      UserConversationScreenState.messagecontroller.text,
      0,
      1,
      1
    ]).then((value) {

      print(DateFormat('HH:mm','ar_SA').format(DateTime.now()));
      UserConversationScreenState.messages.add(UserConversationScreenState.messagecontroller.text);
      UserConversationScreenState.messagesMine.add(true);
      UserConversationScreenState.senderIdList.add(id!);
      UserConversationScreenState.dateMessages.add(DateFormat('HH : mm','ar_SA').format(DateTime.now()));

UserConversationScreenState.messagecontroller.clear();
    }).catchError((err) {
      print(err);
    });
  }

  emit(SendMessageSuccessState());
}*/

}
