import 'dart:convert';
import 'dart:developer';

import '../../models/get_information_user.dart';

import '../../shared/components/components.dart';

import '../../models/chatModel.dart';
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
class ConversationScreen extends StatefulWidget {
  OtherUser? otherUser = null;
  String? otherId = null;

  ConversationScreen({
    Key? key,
    this.otherUser,
  }) : super(key: key);

  ConversationScreen.byOtherId({Key? key, otherId}) : super(key: key) {
    this.otherId = otherId;
  }

  @override
  ConversationScreenState createState() => ConversationScreenState();
}

class ConversationScreenState extends State<ConversationScreen> {
  static var messagecontroller = new TextEditingController();

  late HubConnection hub;
  String status = "غير متصل";

  static List<String> messages = [];
  static List<bool> messagesMine = [];
  static List<String> senderIdList = [];
  static List<String> dateMessages = [];
  static late ChatModel chat;

  @override
  void initState() {
    super.initState();

    hub = HubConnectionBuilder()
        .withUrl(
          "${BASE_URL}chat",
        )
        .build();

    connect();
  }

  void connect() async {
    await hub.start()?.then((value) => log('connected  ✅ 🔗')).catchError((e) {
      log('DISCONNECTED....... ❌  *** ');
      log(e.toString());
    });

    await hub
        .invoke('Connect', args: [ID!])
        .then((value) => print("connected user success"))
        .catchError((e) {
          log('USER is DISCONNECTED.......');
          log(e.toString());
        });

    // hub.onclose( ({error}) => log("HUB ERR: " + error.toString() ) );

    hub.on('receiveMessage', (args) async {
      // this.otherUser.heBlockedMe = state.heBlockedMe;
      dynamic ss = {};
      ss = jsonEncode(args![0]);
      jsonDecode(ss);
      print("ss" + jsonDecode(ss).toString());
      chat = ChatModel.fromJson(jsonDecode(ss));
      if (mounted) {
        setState(() {
          ConversationScreenState.messages.add(chat.text.toString());
          ConversationScreenState.messagesMine.add(false);
          ConversationScreenState.senderIdList.add(chat.senderId.toString());
          dateMessages.add(chat.date);
        });
      }
    });

    hub.on("aUserIsConnected", (args) {
      dynamic list = [];
      print(args!.length);

      print("jj" + jsonEncode(args[0]));
      list = jsonEncode(args[0]);
      print("list" + list.toString());
      list = jsonDecode(list);
      print("li" + list.toString());
      for (int i = 0; i < list!.length; i++) {
        print(list[0]);
        if (list[i].toString() == widget.otherUser?.id) {
          setState(() {
            this.status = " متصل الان";
          });
        } else {
          print("no");
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    hub.stop().then((value) => log("HUB is CLOSED!")).catchError((e) {
      log('Error while HUB closing .......');
      log(e.toString());
    });
  }

  Future<void> send_a_message(context) async {
    if (widget.otherUser!.isBlockedByMe || widget.otherUser!.heBlockedMe) {
      showToast(
          msg: "قام أحد الطرفين بحظر الطرف الاخر", state: ToastStates.ERROR);
      return;
    }

    await hub.invoke('SendMessagee', args: [
      ID!,
      widget.otherUser!.id!,
      messagecontroller.text,
      0,
      1,
      1
    ]).then((value) {
      log("ggggg");
      ConversationCubit.get(context).send();
    }).catchError((e) {
      log('Failed to send ....... ❌❌ ');
      log(e.toString());
      showToast(
          msg: "غير متصل بمحرك المحادثات، الرجاء المحاولة لاحقاً",
          state: ToastStates.ERROR);
    });
  }

  @override
  Widget build(BuildContext context) {
    // log( widget.otherId??"XXXXXXXXXX");
    // log( widget.otherUser?.id);

    return BlocProvider(
        create: (BuildContext context) {
          ConversationCubit cub = ConversationCubit();

          if (widget.otherUser == null) {
            cub.getMessages(userId: widget.otherId ?? "");
          } else {
            cub.getMessages(userId: widget.otherUser!.id ?? "");
          }
          return cub;
        },
        child: BlocConsumer<ConversationCubit, ConversationStates>(
          listener: (context, state) {
            if (state is GetMessagesSuccessState) {
              if (widget.otherUser != null) return;
              setState(() {
                widget.otherUser = state.otherUser;
              });
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
                    leading: Container( width: 0, ),

                    title: Row(children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                                end: 2.w, start: 1.w),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: WHITE,
                              size: 20.sp,
                            ),
                          )),

                      Container(
                        height: 30.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: widget.otherUser?.gender == 1
                                    ? AssetImage(maleImage)
                                    : AssetImage(femaleImage))),
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
                            this.status,
                            style: GoogleFonts.almarai(
                                color: CUSTOME_GREY, fontSize: 11.sp),
                          )
                        ],
                      ),

                      // SizedBox(width: 10.w,),
                    ]),

                    //   titleSpacing: -10,
                    centerTitle: false,
                    backgroundColor: Colors.transparent,
                    elevation: 1,
                  ),
                ),
              ),
              body: ConditionalBuilder(
                  condition: state is GetMessagesLoadingState,
                  builder: createShimmer,
                  fallback: createContainer),
            ),
          ),
        ));
  }

  Widget createContainer(context) {
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
                                  decoration: BoxDecoration(
                                      color: index == messages.length - 1
                                          ? BG_DARK_COLOR
                                          : messagesMine.reversed
                                                  .toList()[index]
                                              ? PRIMARY
                                              : WHITE,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: messagesMine.reversed
                                                  .toList()[index]
                                              ? Radius.circular(15)
                                              : Radius.circular(0),
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomRight:
                                              index == messages.length - 1
                                                  ? Radius.circular(15)
                                                  : messagesMine.reversed
                                                          .toList()[index]
                                                      ? Radius.circular(0)
                                                      : Radius.circular(20))),
                                  child: Text(
                                    messages.reversed.toList()[index],
                                    maxLines: 120,
                                    style: GoogleFonts.almarai(
                                        color: messagesMine.reversed
                                                .toList()[index]
                                            ? WHITE
                                            : BLACK,
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
                                            image: widget.otherUser?.gender == 1
                                                ? AssetImage(maleImage)
                                                : AssetImage(femaleImage))),
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
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () async {
                          await send_a_message(context);
                        },
                        child: Icon(
                          Icons.send,
                          color: WHITE,
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

  Widget createShimmer(context) {
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
