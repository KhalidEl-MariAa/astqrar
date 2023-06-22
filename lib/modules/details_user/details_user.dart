import 'dart:developer';

import '../../layout/layout.dart';
import '../conversation/conversation.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/loading_gif.dart';
import '../../shared/components/user/details_user/details.dart';
import '../../shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../contact_us/contact_us.dart';

class DetailsUserScreen extends StatelessWidget 
{
  final bool messageVisibility;
  final String?delegateId;
  final String?delegateName;

  DetailsUserScreen({Key? key,required this.messageVisibility,this.delegateId,this.delegateName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetInformationCubit, GetInformationStates>(
      listener: (context, state) {
        if (state is AddChattRequestSuccessState) {
          if (state.statusCode == 200) {
            showToast(msg: "تم ارسال طلب محادثة بنجاح", state: ToastStates.SUCCESS);
          }
        }else if (state is AddChattRequestErrorState){
          showToast(msg: state.error, state: ToastStates.SUCCESS);
        }
      },

      builder: (context, state) => Directionality(
        textDirection: TextDirection.rtl,
        child: ConditionalBuilder(
          condition: state is GetInformationLoadingState,
          builder: (context) => Scaffold(
            backgroundColor: white,
            body: LoadingGif(),
          ),
          fallback: (context) => Scaffold(
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
                            snapchatPressed(context);                            
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
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text("حظر المستخدم",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                        onTap: () {
                                          blockUser_pressed(context);
                                        },

                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 0.01.h,
                                    color: Colors.black,
                                  ),
                                  InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text("الابلاغ عن محتوي غير مناسب",
                                          style: TextStyle( fontWeight: FontWeight.w300)),
                                    ),
                                    onTap: (){
                                      ReportAnIssuePressed(context);
                                    },
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
                    .userSubSpecifications!.dowry!, 
                terms: GetInformationCubit.get(context)
                    .getInformationUserModel
                    .userSubSpecifications!.terms!,
                    
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
                              ))
                  );
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
                    .userSubSpecifications!
                    .specialNeeds!,

                userSubSpecificationDto: GetInformationCubit.get(context)
                    .getInformationUserModel
                    .userSubSpecifications!
                    .userSubSpecificationDto,

                favouriteFunction: () {
                  if (GetInformationCubit.get(context)
                      .getInformationUserModel
                      .isFavorate!) {
                    GetInformationCubit.get(context).deleteFromFavourite(
                        userId: GetInformationCubit.get(context)
                            .getInformationUserModel
                            .userSubSpecifications!
                            .id!);
                  } else {
                    GetInformationCubit.get(context).addToFavourite(
                        userId: GetInformationCubit.get(context)
                            .getInformationUserModel
                            .userSubSpecifications!
                            .id!);
                  }
                },

                
                //TODO: تعديل بحيث يدخل على الشات فورا
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
                                    .userSubSpecifications!.gender!,
                                  userId: GetInformationCubit.get(context)
                                      .getInformationUserModel
                                      .userSubSpecifications!
                                      .id!,
                                  userName: GetInformationCubit.get(context)
                                      .getInformationUserModel
                                      .userSubSpecifications!
                                      .userName!)))
                      : GetInformationCubit.get(context).addChattRequest(
                          userId: GetInformationCubit.get(context)
                              .getInformationUserModel
                              .userSubSpecifications!
                              .id!);
                },
                isFavourite: GetInformationCubit.get(context)
                    .getInformationUserModel
                    .isFavorate!,
                height: GetInformationCubit.get(context)
                    .getInformationUserModel
                    .userSubSpecifications!
                    .height
                    .toString(),
                weight: GetInformationCubit.get(context)
                    .getInformationUserModel
                    .userSubSpecifications!
                    .weight
                    .toString(),
                gender: int.parse(GetInformationCubit.get(context)
                    .getInformationUserModel
                    .userSubSpecifications!
                    .gender
                    .toString()),
                age: GetInformationCubit.get(context)
                    .getInformationUserModel
                    .userSubSpecifications!
                    .age
                    .toString(),
                city: GetInformationCubit.get(context)
                        .getInformationUserModel
                        .userSubSpecifications!
                        .city ?? " ",
                email: GetInformationCubit.get(context)
                        .getInformationUserModel
                        .userSubSpecifications!
                        .email ?? " ",
                name: GetInformationCubit.get(context)
                    .getInformationUserModel
                    .userSubSpecifications!
                    .userName!,
                nationality: GetInformationCubit.get(context)
                        .getInformationUserModel
                        .userSubSpecifications!
                        .nationality ?? " ",
                messageVisibility: messageVisibility,
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  void blockUser_pressed(BuildContext context)
  {
    //TODO: كتابة الكووود الخاص بعملية الحظر
    showToast(msg: "تم حظر المستخدم", state: ToastStates.SUCCESS);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
  }
  
  void ReportAnIssuePressed(BuildContext context)
  {
    navigateTo(context: context, widget: ContactUS(
      isFromLogin: false,
    ));
  }
  
  void snapchatPressed(BuildContext context) async 
  {
      Uri url = Uri(
        scheme: "https", 
        path: "www.snapchat.com/add/zoagge?share_id=lRtrrfi6OZo&locale=ar-AE"
      );
      log('Launch to ${url}');
      if (await launchUrl(url, mode: LaunchMode.platformDefault)) {} 
      else {
        throw 'Could not launch ${url}';
      }
  }
}
