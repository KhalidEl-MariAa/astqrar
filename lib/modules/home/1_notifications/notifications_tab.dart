import 'dart:developer';

import 'package:astarar/shared/components/loading_gif.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sizer/sizer.dart';

import '../../../shared/components/accept_success_dialog.dart';
import '../../../shared/styles/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'widgets/notification_widget.dart';

class NotificationTab extends StatelessWidget 
{
  const NotificationTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) 
  {
    return 
      BlocProvider<NotificationCubit>(
          create: (BuildContext context) => NotificationCubit()..getNotifications(),
          child: BlocConsumer<NotificationCubit, NotificationStates>(
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
                          SizedBox( height: 3.h, ),
                          Text(
                            "الاشعارات",
                            style: GoogleFonts.almarai(color: WHITE),
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
                  fallback: (context) => 
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2.1.h,),

                          if(NotificationCubit.get(context).getNotificationsModel.data.length >= 1)
                            Row(                          
                              children: [
                                SizedBox(width: 2.w,),
                                Icon(Icons.delete, color: Colors.red,),
                                Text("لحذف الإشعار اسحب لليسار", 
                                  style: GoogleFonts.almarai(color: CUSTOME_GREY, fontSize: 11.sp),
                                ),
                                
                                Icon(Icons.arrow_forward_rounded, color: PRIMARY,),
                              ],
                            ),

                          ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) => const SizedBox(height: 0,),

                              itemCount: NotificationCubit.get(context)
                                  .getNotificationsModel
                                  .data
                                  .length,

                              itemBuilder: (context, index) => 

                                ConditionalBuilder(
                                  condition: state is RemoveNotificationLoadingState && state.index == index,
                                  builder: (context) => 

                                    Container(
                                      alignment: Alignment.topLeft,
                                      height: 8.5.h,
                                      width: 5,
                                      child: LoadingGif(),
                                    ),
                                    
                                  fallback: (context) 
                                  {
                                    return Dismissible(
                                      key: UniqueKey(),
                                      child:
                                        NotificationWiget(
                                          user: NotificationCubit.get(context)
                                                  .getNotificationsModel
                                                  .data[index]
                                                  .userInformation!,
                                                  
                                          note: NotificationCubit.get(context)
                                                  .getNotificationsModel
                                                  .data[index]
                                                  .notification!
                                      
                                        ),
                                        
                                        onResize: ()
                                        {
                                          NotificationCubit.get(context)
                                            .removeNotification(index: index);
                                        },
                                    
                                        background: Container(
                                          color: PRIMARY,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional.only(
                                                    start: MediaQuery.of(context).size.width * 0.055),
                                    
                                                child: Icon( Icons.delete_outline, color: WHITE,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    
                                    );
                                  }
                                ),

                          ),
                        ],
                      ),
                    ),
                )),
    ),);
  }
}
