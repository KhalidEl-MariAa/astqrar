import 'dart:convert';

import 'package:astarar/models/chatModel.dart';
import 'package:astarar/modules/conversation/cubit/cubit.dart';
import 'package:astarar/modules/conversation/cubit/states.dart';
import 'package:astarar/modules/conversation/more_for_delegate/more_for_delegate.dart';
import 'package:astarar/shared/components/loading_gif.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:sizer/sizer.dart';

class UserConversationScreen extends StatefulWidget {
  final String userId;
  final String userName;
  final int gender;
  final int typeUser;

  const UserConversationScreen(
      {Key? key,
      required this.userId,
      required this.userName,
      required this.gender,
      required this.typeUser})
      : super(key: key);

  @override
  UserConversationScreenState createState() => UserConversationScreenState();
}

class UserConversationScreenState extends State<UserConversationScreen> 
{
  static var messagecontroller = new TextEditingController();
  var hubConnection = HubConnectionBuilder()
      .withUrl("https://estqrar-001-site1.ctempurl.com/chat",)
      .build();
  static List<String> messages = [];
  static List<bool> messagesMine = [];
  static List<String> senderIdList = [];
  static List<String> dateMessages = [];
  static late ChatModel chat;

  @override
  void initState() {
    super.initState();
    connect();
  }

  String status = "غير متصل";

  void connect() async {
    await hubConnection.start()?.then((value) => print('connected'));
    hubConnection.invoke('Connect',
        args: [id!]).then((value) => print("connected user success"));
    hubConnection.on('receiveMessage', (arguments) async {
      dynamic ss = {};
      ss = jsonEncode(arguments![0]);
      jsonDecode(ss);
      print("ss" + jsonDecode(ss).toString());
      chat = ChatModel.fromJson(jsonDecode(ss));
      if (mounted) {
        setState(() {
          print("kkkkkkkkkkkkkkkkkkkkkk");
          UserConversationScreenState.messages.add(chat.text.toString());
          UserConversationScreenState.messagesMine.add(false);
          UserConversationScreenState.senderIdList
              .add(chat.senderId.toString());
          dateMessages.add(chat.date);
        });
      }
    });
    hubConnection.on("connectedUsers", (arguments) {
      dynamic list = [];
      print(arguments!.length);

      print("jj" + jsonEncode(arguments[0]));
      list = jsonEncode(arguments[0]);
      print("list" + list.toString());
      list = jsonDecode(list);
      print("li" + list.toString());
      for (int i = 0; i < list!.length; i++) {
        print(list[0]);
        if (list[i].toString() == widget.userId) {
          setState(() {
            status = " متصل الان";
          });
        } else {
          print("no");
        }
      }
    });
  }

  @override
  void dispose() 
  {
    super.dispose();
    hubConnection.stop().then((value) => print("closed"));
    hubConnection.onclose(({error}) {
      print("hh");
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          ConversationCubit()..getMessages(userId: widget.userId,typeUserChat: widget.typeUser==1?true:false),
      child: BlocConsumer<ConversationCubit, ConversationStates>(
        listener: (context, state) {},
        builder: (context, state) => Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(19.h),
                  child: Container(
                    height: 13.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/Group 66233.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: AppBar(
                      toolbarHeight: 13.h,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            widget.userName,
                            style: TextStyle(color: white,fontSize: 11.5.sp),
                          ),
                          SizedBox(
                            height: 0.2.h,
                          ),
                          Text(
                            status,
                            style: GoogleFonts.almarai(
                                color: customGrey, fontSize: 11.sp),
                          )
                        ],
                      ),
                      //   titleSpacing: -10,
                      leadingWidth: 13.w,
                      centerTitle: false,
                      backgroundColor: Colors.transparent,
                      elevation: 1,
                      leading: Padding(
                          padding: EdgeInsetsDirectional.only(
                              top: 2.h, start: 2.5.w),
                          child: Container(
                            height: 2.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: widget.gender == 1
                                        ? AssetImage(maleImage)
                                        : AssetImage(femaleImage))),
                          )),
                      actions: [
                        if (widget.typeUser == 2) InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MoreForDelegateScreen(
                              delegateName: widget.userName,
                              delegateId: widget.userId,
                            )));
                          },
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(end: 2.w),
                            child: Center(child: Text("سعي للخطابة",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w600),)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                body:
                ConditionalBuilder(
                  condition: ConversationCubit.get(context).getMessagesDone,
                  fallback: (context) =>
                     Shimmer(child: ListView.separated(
                       itemCount: 8,
                       separatorBuilder: (context,index)=>SizedBox(height: 1.h,),
                       itemBuilder:(context,index)=> Padding(
                         padding:
                         EdgeInsetsDirectional.only(start: 3.w),
                         child: Container(
                           width: double.infinity,
                           alignment: index%2==0
                               ? Alignment.centerRight
                               : Alignment.centerLeft,
                           child: Column(
                             mainAxisSize: MainAxisSize.min,
                             children: [
                               Row(
                                 mainAxisAlignment:
                                 index %2==0
                                     ? MainAxisAlignment.start
                                     : MainAxisAlignment.end,
                                 children: [
                                   Container(
                                  height: 10.h,
                                     width: 55.w,
                                     padding: EdgeInsets.symmetric(horizontal: 2.w),
                                     decoration: BoxDecoration(
                                         color: Colors.grey[300],
                                         borderRadius:
                                         BorderRadius.only(
                                             bottomLeft: index%2==0
                                                 ? Radius.circular(
                                                 15)
                                                 : Radius.circular(
                                                 0),
                                             topLeft:
                                             Radius.circular(
                                                 15),
                                             topRight:
                                             Radius.circular(
                                                 15),
                                             bottomRight: index %2==0


                                                 ? Radius.circular(0)
                                                 : Radius.circular(20))),

                                   ),

                                 ],
                               ),

                             ],
                           ),
                         ),
                       ),
                     ),),

               builder: (context)=> Container(
                  height: 86.h,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/chattt.png"),
                  )),
                  width: double.infinity,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.only(bottom: 10.h, end: 5.w),
                        child: ListView.separated(
                            reverse: true,
                            itemBuilder: (context, index) => Padding(
                                  padding:
                                      EdgeInsetsDirectional.only(start: 3.w),
                                  child: Container(
                                    alignment: index == messages.length
                                        ? Alignment.center
                                        : messagesMine.reversed.toList()[index]
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              index == messages.length - 1
                                                  ? MainAxisAlignment.center
                                                  : messagesMine.reversed
                                                          .toList()[index]
                                                      ? MainAxisAlignment.start
                                                      : MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              constraints: BoxConstraints(
                                                  minWidth: index ==
                                                          messages.length - 1
                                                      ? 18.w
                                                      : 10.w,
                                                  maxWidth: index ==
                                                          messages.length - 1
                                                      ? 90.w
                                                      : 65.w,
                                                  minHeight: 2.h,
                                                  maxHeight: double.infinity),
                                              padding: EdgeInsets.only(
                                                  left: index ==
                                                          messages.length - 1
                                                      ? 2.w
                                                      : 5.w,
                                                  right: index ==
                                                          messages.length - 1
                                                      ? 2.w
                                                      : 5.w,
                                                  top: 2.h,
                                                  bottom: 2.h),
                                              decoration: BoxDecoration(
                                                  color: index ==
                                                          messages.length - 1
                                                      ? backGround
                                                      : messagesMine.reversed
                                                              .toList()[index]
                                                          ? primary
                                                          : white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft: messagesMine
                                                                      .reversed
                                                                      .toList()[
                                                                  index]
                                                              ? Radius.circular(
                                                                  15)
                                                              : Radius.circular(
                                                                  0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  15),
                                                          topRight:
                                                              Radius.circular(
                                                                  15),
                                                          bottomRight: index ==
                                                                  messages.length -
                                                                      1
                                                              ? Radius.circular(
                                                                  15)
                                                              : messagesMine
                                                                      .reversed
                                                                      .toList()[index]
                                                                  ? Radius.circular(0)
                                                                  : Radius.circular(20))),
                                              child: Text(
                                                messages.reversed
                                                    .toList()[index],
                                                maxLines: 120,
                                                style: GoogleFonts.almarai(
                                                    color: messagesMine.reversed
                                                            .toList()[index]
                                                        ? white
                                                        : black,fontSize: index==messages.length-1?10.sp:null),
                                              ),
                                            ),
                                            Visibility(
                                              visible: index == 0 &&
                                                      messagesMine.reversed
                                                                  .toList()[
                                                              index] ==
                                                          false
                                                  ? true
                                                  : index <
                                                              senderIdList
                                                                      .reversed
                                                                      .toList()
                                                                      .length -
                                                                  1 &&
                                                          messagesMine.reversed
                                                                      .toList()[
                                                                  index] ==
                                                              false
                                                      ? senderIdList.reversed
                                                                  .toList()[
                                                              index] !=
                                                          senderIdList.reversed
                                                                  .toList()[
                                                              index - 1]
                                                      : false,
                                              child: Container(
                                                height: 5.h,
                                                width: 8.w,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: widget.gender == 1
                                                            ? AssetImage(
                                                                maleImage)
                                                            : AssetImage(
                                                                femaleImage))),
                                              ),
                                            )
                                          ],
                                        ),
                                        Visibility(
                                            visible: index ==
                                                    messages.length - 1
                                                ? false
                                                : index == 0
                                                    ? true
                                                    : index <
                                                            dateMessages
                                                                    .reversed
                                                                    .toList()
                                                                    .length -
                                                                1
                                                        ? dateMessages.reversed
                                                                    .toList()[
                                                                index] !=
                                                            dateMessages
                                                                    .reversed
                                                                    .toList()[
                                                                index - 1]
                                                        : false,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w),
                                              child: Row(
                                                mainAxisAlignment: messagesMine
                                                        .reversed
                                                        .toList()[index]
                                                    ? MainAxisAlignment.start
                                                    : MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    dateMessages.reversed
                                                        .toList()[index],
                                                    style: TextStyle(
                                                        color: Colors.grey[400],
                                                        fontSize: 10.sp),
                                                  ),
                                                ],
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 0.5.h,
                                ),
                            itemCount: messages.length),
                      ),
                      Positioned(
                        bottom: -2.h,
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                              bottom: 1.5.h, start: 1.w, end: 1.w),
                          child: Container(
                            width: 98.w,
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              controller: messagecontroller,
                              decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                    onTap: () async {
                                      if (hubConnection.state ==
                                          HubConnectionState.Connected) {
                                        await hubConnection
                                            .invoke('SendMessagee', args: [
                                          id!,
                                          widget.userId,
                                          messagecontroller.text,
                                          0,
                                          1,
                                          1
                                        ]).then((value) {
                                          print("gg");
                                          ConversationCubit.get(context).send();
                                        });
                                      }
                                    },
                                    child: Icon(
                                      Icons.send,
                                      color: white,
                                    ),
                                  ),
                                  hintText: "اكتب رسالة",
                                  contentPadding: EdgeInsetsDirectional.only(
                                      start: 5.w, top: 5.h),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(20)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(20)),
                                  filled: true,
                                  fillColor: primary,
                                  hintStyle:
                                      GoogleFonts.almarai(fontSize: 10.sp)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      )
    );
  }
}
