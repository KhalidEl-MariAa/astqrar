import 'package:astarar/layout/layout.dart';
import 'package:astarar/modules/conversation/conversation.dart';
import 'package:astarar/modules/details_user/cubit/cubit.dart';
import 'package:astarar/modules/details_user/cubit/states.dart';
import 'package:astarar/shared/components/components.dart';
import 'package:astarar/shared/components/loading_gif.dart';
import 'package:astarar/shared/components/user/details_item.dart';
import 'package:astarar/shared/components/user/details_user/details.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../contact_us/contact_us.dart';

class DetailsUserScreen extends StatelessWidget {
  final bool messageVisibility;
  String?delegateId;
  String?delegateName;
 DetailsUserScreen({Key? key,required this.messageVisibility,this.delegateId,this.delegateName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetInformationCubit, GetInformationStates>(
      listener: (context, state) {
        if (state is AddRequestSuccessState) {
          if (state.statusCode == 200) {
            showToast(
                msg: "تم ارسال طلب محادثة بنجاح", state: ToastStates.SUCCESS);
          }
        }
      },
      builder: (context, state) => Directionality(
        textDirection: TextDirection.rtl,
        child: ConditionalBuilder(
          condition: GetInformationCubit.get(context).getInformationDone,
          fallback: (context) => Scaffold(
            backgroundColor: white,
            body: LoadingGif(),
          ),
          builder: (context) => Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: backGround,
              toolbarHeight: 9.h,
              title: const Text(
                "التفاصيل",
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                Padding(
                  padding:
                  EdgeInsetsDirectional.only(end: 3.w, top: 0.h),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () async {
                            String url =
                                "https://www.snapchat.com/add/zoagge?share_id=lRtrrfi6OZo&locale=ar-AE";
                            if (await launch(url)) {
                              await launch(url,
                                  forceWebView: false,
                                  enableJavaScript: false,
                                  forceSafariVC: false);
                            } else {
                              throw 'Could not launch ${url}';
                            }
                          },
                          child: Image(
                            image: AssetImage("assets/snapchat.png"),
                            height: 4.h,
                            width: 10.w,
                          )),
                      PopupMenuButton(
                          onSelected: (item) {
                          },
                          position: PopupMenuPosition.under,
                          itemBuilder: (context) => <PopupMenuEntry>[
                            PopupMenuItem(
                              height: 10.h,
                              padding: EdgeInsets.all(0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                         showToast(msg: "تم حظر المستخدم", state: ToastStates.SUCCESS);
                                         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            "حظر المستخدم",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 0.01.h,
                                    color: Colors.black,
                                  ),
                                  InkWell(
                                    onTap: (){
                                      navigateTo(
                                          context: context, widget: ContactUS(
                                        isFromLogin: false,
                                      ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text("الابلاغ عن محتوي غير مناسب",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300)),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ])
                    ],
                  ),
                )
              ],
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: DetailsItemScreen(
                dowry: GetInformationCubit.get(context)
                    .getInformationUserModel
                    .userSubSpecification!.dowry!,
                terms: GetInformationCubit.get(context)
                    .getInformationUserModel
                    .userSubSpecification!.terms!,
                onClickUser: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UserConversationScreen(
                                gender: 2,
                                userId: delegateId!,
                                userName: delegateName!,
                                typeUser: 2,
                              )));
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => UserConversationScreen(
                  //           gender: 2,
                  //           userId: GetInformationCubit.get(context)
                  //               .getInformationUserModel
                  //               .userSubSpecification!.id!,
                  //           userName: GetInformationCubit.get(context)
                  //               .getInformationUserModel
                  //               .userSubSpecification!.userName!,
                  //           typeUser:1,
                  //         )));
                },
                specialNeeds: GetInformationCubit.get(context)
                    .getInformationUserModel
                    .userSubSpecification!
                    .specialNeeds!,
                userSubSpecificationDto: GetInformationCubit.get(context)
                    .getInformationUserModel
                    .userSubSpecification!
                    .userSubSpecificationDto,
                favouriteFunction: () {
                  if (GetInformationCubit.get(context)
                      .getInformationUserModel
                      .isFavorate!) {
                    print("hh");
                    GetInformationCubit.get(context).deleteFromFavourite(
                        userId: GetInformationCubit.get(context)
                            .getInformationUserModel
                            .userSubSpecification!
                            .id!);
                  } else {
                    GetInformationCubit.get(context).addToFavourite(
                        userId: GetInformationCubit.get(context)
                            .getInformationUserModel
                            .userSubSpecification!
                            .id!);
                  }
                },
                chatFunction: () {

                    GetInformationCubit.get(context)
                          .getInformationUserModel
                          .isInMyContacts!
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserConversationScreen(
                                 typeUser: 1,
                                gender: GetInformationCubit.get(context)
                                    .getInformationUserModel
                                    .userSubSpecification!.gender!,
                                  userId: GetInformationCubit.get(context)
                                      .getInformationUserModel
                                      .userSubSpecification!
                                      .id!,
                                  userName: GetInformationCubit.get(context)
                                      .getInformationUserModel
                                      .userSubSpecification!
                                      .userName!)))
                      : GetInformationCubit.get(context).addRequest(
                          userId: GetInformationCubit.get(context)
                              .getInformationUserModel
                              .userSubSpecification!
                              .id!);



                },
                isFavourite: GetInformationCubit.get(context)
                    .getInformationUserModel
                    .isFavorate!,
                height: GetInformationCubit.get(context)
                    .getInformationUserModel
                    .userSubSpecification!
                    .height
                    .toString(),
                weight: GetInformationCubit.get(context)
                    .getInformationUserModel
                    .userSubSpecification!
                    .weight
                    .toString(),
                gender: int.parse(GetInformationCubit.get(context)
                    .getInformationUserModel
                    .userSubSpecification!
                    .gender
                    .toString()),
                age: GetInformationCubit.get(context)
                    .getInformationUserModel
                    .userSubSpecification!
                    .age
                    .toString(),
                city: GetInformationCubit.get(context)
                        .getInformationUserModel
                        .userSubSpecification!
                        .city ??
                    " ",
                email: GetInformationCubit.get(context)
                        .getInformationUserModel
                        .userSubSpecification!
                        .email ??
                    " ",
                name: GetInformationCubit.get(context)
                    .getInformationUserModel
                    .userSubSpecification!
                    .userName!,
                nationality: GetInformationCubit.get(context)
                        .getInformationUserModel
                        .userSubSpecification!
                        .nationality ??
                    " ",
                messageVisibility: messageVisibility,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
