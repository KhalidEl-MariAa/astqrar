import 'dart:developer';

import 'package:astarar/models/server_response_model.dart';
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

      ServerResponse res = ServerResponse.fromJson(value.data);

      for (var m in res.data['messages']) 
      {
        Message msg = Message.fromJson(m);
        // print(res.data[i].senderId);
        ConversationScreenState.messages.add(msg.message!);
        ConversationScreenState.senderIdList.add(msg.senderId.toString());
        ConversationScreenState.dateMessages.add(
            DateFormat('mm : HH  dd / MM/ yyyy', 'ar_SA').format(DateTime.parse(msg.date!))
        );
        
        log(ConversationScreenState.senderIdList.toString());
        if (ID == msg.senderId) {
          msg.isMine = true;
          ConversationScreenState.messagesMine.add(true);
        } else {
          ConversationScreenState.messagesMine.add(false);
          msg.isMine = false;
        }
      }

 
      emit(GetMessagesSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetMessagesErrorState(error.toString()));
    });
  }

  void send() 
  {
    
    ConversationScreenState.messages
        .add(ConversationScreenState.  messagecontroller.text);
    ConversationScreenState.messagesMine.add(true);
    ConversationScreenState.senderIdList.add(ID!);
    ConversationScreenState.dateMessages
        .add(DateFormat('HH : mm', 'ar_SA').format(DateTime.now()));

    ConversationScreenState.messagecontroller.clear();
    emit(SendMessageSuccessState());
  }
  


}
