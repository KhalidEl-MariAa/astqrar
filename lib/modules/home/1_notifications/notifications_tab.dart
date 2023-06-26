import '../../user_details/cubit/cubit.dart';
import '../../user_details/user_details.dart';
import '../../../shared/components/accept_success_dialog.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'widgets/accepted_notification.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../shared/styles/colors.dart';

class NotificationTab extends StatelessWidget 
{
  const NotificationTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit, NotificationStates>(
      listener: (context, state) {
        if (state is AcceptChattRequestSuccessState) 
        {
          showDialog(
              context: context, 
              builder: (context) =>  SuccessDialog(
                successText:   "تم القبول بنجاح",
                subTitle:   "برجاء تحديد طريقة المحادثة مع الشخص المرسل",
                actionText:   "محادثة عادية",
              )
          );
        }
      },
      builder: (context, state) => Scaffold(
          backgroundColor: WHITE,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(10.h),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/appbarimage.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: AppBar(
                toolbarHeight: 8.h,
                title: Column(
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      "الاشعارات",
                      style: TextStyle(color: WHITE),
                    ),
                  ],
                ),
                titleSpacing: -5.w,
                //  leadingWidth: back == false ? 10 : 56,
                centerTitle: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Container(),
              ),
            ),
          ),
          body: ConditionalBuilder(
            condition: state is GetNotificationLoadingState,
            builder: (context) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                child: Shimmer(
                child: ListView.separated(
                  itemCount: 12,
                  separatorBuilder: (context, index) => SizedBox(height: 1.h,),
                  itemBuilder: (context, index) => Container(
                    height: 12.h,
                    color: Colors.grey[200],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 18.w,
                          height: 10.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              color: Colors.grey[400]
                          ),
                        ),
                        SizedBox(width: 3.w,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(height: 1.h, width: 45.w, color: Colors.grey[400],),
                            SizedBox(height: 2.h,),
                            Container(height: 1.h, width: 25.w, color: Colors.grey[400],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ),
            fallback: (context) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => AcceptNotification(
                        time: NotificationCubit.get(context)
                            .getNotificationsModel.data.reversed.toList()[index].notification!.time! ,
                            clickUser: () {
                              if (NotificationCubit.get(context)
                                      .getNotificationsModel
                                      .data
                                      .reversed
                                      .toList()[index]
                                      .userInformation!
                                      .typeUser ==1) {
                                UserDetailsCubit.get(context)
                                    .getInformationUser(
                                        otherId: NotificationCubit.get(context)
                                            .getNotificationsModel
                                            .data
                                            .reversed
                                            .toList()[index]
                                            .userInformation!
                                            .id!);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>UserDetailsScreen(
                                              messageVisibility: true,
                                            )));
                              }
                              if (NotificationCubit.get(context)
                                      .getNotificationsModel
                                      .data
                                      .reversed
                                      .toList()[index]
                                      .userInformation!
                                      .typeUser == 2) {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             SpeceficDelegateScreen(
                                //               name:
                                //                   NotificationCubit.get(context)
                                //                       .getNotificationsModel
                                //                       .data
                                //                       .reversed
                                //                       .toList()[index]
                                //                       .userInformation!
                                //                       .user_Name!,
                                //               id: NotificationCubit.get(context)
                                //                   .getNotificationsModel
                                //                   .data
                                //                   .reversed
                                //                   .toList()[index]
                                //                   .userInformation!
                                //                   .id!,
                                //             )));
                              }
                            },
                            userId: NotificationCubit.get(context)
                                        .getNotificationsModel
                                        .data
                                        .reversed
                                        .toList()[index]
                                        .userInformation !=
                                    null
                                ? NotificationCubit.get(context)
                                    .getNotificationsModel
                                    .data
                                    .reversed
                                    .toList()[index]
                                    .userInformation!
                                    .id!
                                : " ",
                            message: NotificationCubit.get(context)
                                    .getNotificationsModel
                                    .data
                                    .reversed
                                    .toList()[index]
                                    .notification!
                                    .message ??
                                " ",
                            gender: NotificationCubit.get(context)
                                        .getNotificationsModel
                                        .data
                                        .reversed
                                        .toList()[index]
                                        .userInformation !=
                                    null
                                ? NotificationCubit.get(context)
                                    .getNotificationsModel
                                    .data
                                    .reversed
                                    .toList()[index]
                                    .userInformation!
                                    .gender!
                                : 1,
                            userName: NotificationCubit.get(context)
                                        .getNotificationsModel
                                        .data
                                        .reversed
                                        .toList()[index]
                                        .userInformation !=
                                    null
                                ? NotificationCubit.get(context)
                                    .getNotificationsModel
                                    .data
                                    .reversed
                                    .toList()[index]
                                    .userInformation!
                                    .user_Name!
                                : "مستخدم",
                            notificationType: NotificationCubit.get(context)
                                .getNotificationsModel
                                .data
                                .reversed
                                .toList()[index]
                                .notification!
                                .notificationType!,
                          ),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 0,
                          ),
                      itemCount: NotificationCubit.get(context)
                          .getNotificationsModel
                          .data
                          .length)
                ],
              ),
            ),
          )),
    );
  }
}
