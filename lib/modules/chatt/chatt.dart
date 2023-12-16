import 'dart:convert';
import 'dart:developer';

import '../../models/message.dart';
import 'package:intl/intl.dart' as dt;

import '../../models/user_other.dart';

import '../../shared/components/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';
import '../../constants.dart';
import '../../shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class ConversationScreen extends StatefulWidget 
{

  late OtherUser? otherUser = null;
  late String? otherId = null;

  ConversationScreen({ Key? key, this.otherUser, }) : super(key: key) {
    this.otherId = this.otherUser!.id!;
  }

  ConversationScreen.byOtherId({Key? key, otherId}) : super(key: key) {
    this.otherId = otherId;
  }

  @override
  ConversationScreenState createState() => ConversationScreenState();
}

class ConversationScreenState extends State<ConversationScreen> 
{
  static var messagecontroller = new TextEditingController();

  late HubConnection hub;
  bool otherUserIsConnected = false;
  bool IamConnected = false;

  static List<String> messages = [];
  static List<bool> messagesMine = [];
  static List<String> senderIdList = [];
  static List<String> dateMessages = [];
  // static late ChatModel chat;

  @override
  void initState() {
    super.initState();

    this.hub = HubConnectionBuilder()
        .withUrl("${BASE_URL}chat",)
        .build();

    connect();
  }

  void connect() async 
  {

    await this.hub.start()?.then( (_) 
    {
        this.IamConnected = true;
        log('connected  ✅ 🔗');
    }).catchError((e) {
        this.IamConnected = false;
        log('DISCONNECTED....... ❌   ');
        log(e.toString());
    });


    this.hub.on("aUserIsConnected", (args) 
    {
      String str = "[]";
      dynamic connectedUserIds = [];

      str = jsonEncode(args![0]);
      connectedUserIds = jsonDecode( str );

      bool inConnectedList = connectedUserIds.contains( widget.otherId );
      if (inConnectedList){
          setState( () { this.otherUserIsConnected = true; });
      }

    });


    this.hub.on("aUserIsDisconnected", (args) 
    {
      String str = jsonEncode( args![0] );
      dynamic diconnectedUserId = jsonDecode(str);

      if (diconnectedUserId == widget.otherUser?.id) {
        setState(() {
          this.otherUserIsConnected = false;
        });
      }
    });

    this.hub.on('receiveMessage', (args) async 
    {

      String str = jsonEncode( args![0] );
      dynamic jasonified = jsonDecode(str);
      Message msg = Message.fromJson(  jasonified );

      if (mounted) {
        setState(() {
          messages.add(msg.message.toString());
          messagesMine.add(false);
          senderIdList.add(msg.senderId.toString());
          dateMessages.add(dt.DateFormat('mm : hh a', 'ar_SA').format(msg.date!));
        });
      }
    });

    this.hub
      .invoke('Connect', args: [ID!])
      .then( (args) {
        log("`Connect` Repley: " + args.toString() );

        String str = jsonEncode( args );
        dynamic connectedUserIds = jsonDecode(str);
        bool inConnectedList = connectedUserIds.contains( widget.otherId );
        if (inConnectedList){
            setState( () { this.otherUserIsConnected = true; });
        }

      })
      .catchError((e) {
        log('Error while adding to connected list .......');
        log(e.toString());
      });

    this.hub.onclose( ({error}) {
        log("HUB IS CLOSED: " + error.toString() );
        setState(() { this.IamConnected = true; });
    });

  }

  @override
  void dispose() async
  {
    super.dispose();

    await this.hub
        .invoke('DisConnect', args: [ID!])
        .then((value) 
        { 
          log("User is removed from Connected list: " + value.toString());
        })
        .catchError((e) {
          log('Error while `DisConnect` function .......');
          log(e.toString());
        });

    await this.hub.stop()
    .then((value) {
      this.IamConnected = false;
      log("HUB is STOPPED!");
    })
    .catchError((e) {
      log('Error while HUB closing .......');
      log(e.toString());
    });
  }


  @override
  Widget build(BuildContext context) 
  {
    return BlocProvider(
        create: (BuildContext context) 
        {
          ConversationCubit cub = ConversationCubit();

          if (widget.otherUser == null) {
            cub.getMessages(userId: widget.otherId ?? "");
          } else {
            cub.getMessages(userId: widget.otherUser!.id ?? "");
          }
          return cub;
        },
        child: BlocConsumer<ConversationCubit, ConversationStates>(
          listener: (context, state) 
          {
            if (state is GetOtherUserSuccess)
            {
              setState(() {
                widget.otherUser = state.otherUser;
              });
            }
            else if (state is GetMessagesSuccessState) 
            {
              // بعد وصول جميع الرسائل
              setState(() {
                for (var m in state.messages) {
                  Message msg = Message.fromJson(m);

                  messages.add(msg.message!);
                  senderIdList.add(msg.senderId.toString());
                  dateMessages.add(
                      dt.DateFormat('mm : hh a   dd / MM/ yyyy', 'ar_SA').format(msg.date!));
                  messagesMine.add( msg.isMine! );
                }
              });

              ConversationCubit.get(context).setAllMessagesToSeen();

            }
            else if( state is SendMessageErrorState)
            {
              showToast(
                msg: state.error,
                state: ToastStates.ERROR);
            }
            else if( state is SendMessageSuccessState)
            {
                messages.add(state.sentMsg.message??"❌");

                messagesMine.add(true);
                senderIdList.add(state.sentMsg.senderId??ID!);
                dateMessages
                    .add(dt
                        .DateFormat('mm : hh a', 'ar_SA')
                        .format( state.sentMsg.date! ));

                messagecontroller.clear();
            }
            else if( state is SendMessageByOtherSuccessState)
            {
              messagecontroller.clear();
            }
          },
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

                    leadingWidth: 0.w,
                    leading: Container(
                      width: 0,
                    ),

                    // شريط العنوان
                    title: Row(
                      children: [
                        InkWell(
                            onTap: () { Navigator.pop(context); },
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(end: 2.w, start: 1.w),
                              child: Icon(Icons.arrow_back_ios, color: WHITE, size: 20.sp,
                              ),
                            )),

                        // صورة المستخدم
                        Container(
                          height: 30.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                opacity: this.widget.otherUser?.IsExpired??true ? 0.5 : 1.0,
                                image: getUserImage(widget.otherUser)
                                // image: AssetImage(femaleImage)
                          )),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // اسم اليوزر
                            Text(
                              widget.otherUser?.user_Name ?? "------",
                              style: GoogleFonts.almarai(
                                  color: OFF_WHITE, fontSize: 16.sp),
                            ),
                            SizedBox(
                              height: 0.4.h,
                            ),

                            //متصل او غير متصل
                            Text(
                              this.otherUserIsConnected? "متصل" : "غير متصل",
                              style: GoogleFonts.almarai(
                                  color: this.otherUserIsConnected? Colors.green : CUSTOME_GREY, 
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                      ]),

                    centerTitle: false,
                    backgroundColor: Colors.transparent,
                    elevation: 1,
                  ),
                ),
              ),

              //  الرسائل
              body: ConditionalBuilder(
                  condition: state is GetMessagesLoadingState,
                  builder:  (context) =>  createShimmer(context, state),
                  fallback: (context) =>  createContainer(context, state)
              ),
            ),
          ),
        ));
  }

  Widget createContainer(context, ConversationStates state) 
  {
    return Container(
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
            padding: EdgeInsetsDirectional.only(bottom: 10.h, end: 5.w),
            child: ListView.separated(
                reverse: true,
                itemBuilder: (context, index) => Padding(
                      padding: EdgeInsetsDirectional.only(start: 3.w),
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
                              mainAxisAlignment: index == messages.length - 1
                                  ? MainAxisAlignment.center
                                  : messagesMine.reversed.toList()[index]
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.end,
                              children: [
                                // صندوق الرسالة
                                Container(
                                  constraints: BoxConstraints(
                                      minWidth: index == messages.length - 1
                                          ? 18.w
                                          : 10.w,
                                      maxWidth: index == messages.length - 1
                                          ? 90.w
                                          : 65.w,
                                      minHeight: 2.h,
                                      maxHeight: double.infinity),
                                  padding: EdgeInsets.only(
                                      left: index == messages.length - 1
                                          ? 2.w
                                          : 5.w,
                                      right: index == messages.length - 1
                                          ? 2.w
                                          : 5.w,
                                      top: 2.h,
                                      bottom: 2.h),
                                  decoration: 
                                    BoxDecoration(
                                      color: index == messages.length - 1
                                          ? BG_DARK_COLOR
                                          : messagesMine.reversed.toList()[index]
                                              ? PRIMARY
                                              : WHITE,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: messagesMine.reversed.toList()[index]
                                              ? Radius.circular(15)
                                              : Radius.circular(0),
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomRight:
                                              index == messages.length - 1
                                                  ? Radius.circular(15)
                                                  : messagesMine.reversed.toList()[index]
                                                      ? Radius.circular(0)
                                                      : Radius.circular(20))
                                    ),
                                  child: Text(
                                    messages.reversed.toList()[index],
                                    maxLines: 120,
                                    style: GoogleFonts.almarai(
                                        color: messagesMine.reversed.toList()[index] ? WHITE: BLACK,
                                        fontSize: index == messages.length - 1
                                            ? 10.sp
                                            : null),
                                  ),
                                ),

                                //الصورة الشعارية
                                Visibility(
                                  visible: index == 0 &&
                                          messagesMine.reversed
                                                  .toList()[index] ==
                                              false
                                      ? true
                                      : index <
                                                  senderIdList.reversed
                                                          .toList()
                                                          .length -
                                                      1 &&
                                              messagesMine.reversed
                                                      .toList()[index] ==
                                                  false
                                          ? senderIdList.reversed
                                                  .toList()[index] !=
                                              senderIdList.reversed
                                                  .toList()[index - 1]
                                          : false,
                                  child: Container(
                                    height: 5.h,
                                    width: 8.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          opacity: this.widget.otherUser!.IsExpired! ? 0.5 : 1.5,
                                          image: getUserImage(this.widget.otherUser)
                                        )
                                    ),
                                  ),
                                )
                              ],
                            ),

                            // تاريخ الرسالة
                            Visibility(
                                visible: index == messages.length - 1
                                    ? false
                                    : index == 0
                                        ? true
                                        : index <
                                                dateMessages.reversed
                                                        .toList()
                                                        .length -
                                                    1
                                            ? dateMessages.reversed
                                                    .toList()[index] !=
                                                dateMessages.reversed
                                                    .toList()[index - 1]
                                            : false,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 1.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        messagesMine.reversed.toList()[index]
                                            ? MainAxisAlignment.start
                                            : MainAxisAlignment.end,
                                    children: [
                                      Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: Text(
                                          dateMessages.reversed.toList()[index],
                                          style: TextStyle(
                                              color: Colors
                                                  .grey[700], // Colors.red,
                                              fontSize: 11.sp),
                                        ),
                                      ),

                                      // Text(
                                      //   dateMessages.reversed.toList()[index],
                                      //   style: TextStyle(
                                      //       color: Colors.grey[600],
                                      //       fontSize: 10.sp),
                                      // ),
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

                  // زر الارسال  - Send
                  decoration: InputDecoration(
                      suffixIcon:
                        ConditionalBuilder(
                        condition: state is SendMessageLoadingState,
                        builder: (context) => 
                          SizedBox(
                            child: Center(
                              child: CircularProgressIndicator(strokeWidth: 3.0, color: BLACK_OPACITY),
                            ),
                            height: 50.0,
                            width: 50.0,
                          ),
                        fallback: (context) =>
                          InkWell(
                            child: Icon( Icons.send, color: WHITE, ),
                            onTap: ()  
                            {
                              if( messagecontroller.text.trim().isEmpty ) return;

                              if (widget.otherUser!.isBlockedByMe || widget.otherUser!.heBlockedMe) {
                                showToast(
                                    msg: "قام أحد الطرفين بحظر الطرف الاخر", 
                                    state: ToastStates.ERROR);
                                return;
                              }
                              
                              if (widget.otherUser!.IsActive! == false) {
                                ConversationCubit.get(context)
                                  .send_a_message(this.hub, ID!, "أنا غير مشترك ولا يمكنني استلام رسالتك أو الرد عليك حالياً" , senderId: widget.otherId);
                              }
                              ConversationCubit.get(context)
                                .send_a_message(this.hub, widget.otherUser!.id!, messagecontroller.text);
                            },
                          ),
                      ),
                      hintText: "اكتب رسالة",
                      contentPadding:
                          EdgeInsetsDirectional.only(start: 5.w, top: 5.h),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                      filled: true,
                      fillColor: PRIMARY,
                      hintStyle: GoogleFonts.almarai(fontSize: 10.sp)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget createShimmer(context, ConversationStates state) 
  {
    return Shimmer(
      child: ListView.separated(
        itemCount: 8,
        separatorBuilder: (context, index) => SizedBox(
          height: 1.h,
        ),
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsetsDirectional.only(start: 3.w),
          child: Container(
            width: double.infinity,
            alignment:
                index % 2 == 0 ? Alignment.centerRight : Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: index % 2 == 0
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 10.h,
                      width: 55.w,
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.only(
                              bottomLeft: index % 2 == 0
                                  ? Radius.circular(15)
                                  : Radius.circular(0),
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomRight: index % 2 == 0
                                  ? Radius.circular(0)
                                  : Radius.circular(20))),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
