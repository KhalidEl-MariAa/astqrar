import 'dart:developer';

import 'package:astarar/constants.dart';
import 'package:astarar/models/user.dart';
import 'package:astarar/shared/components/dialog_please_login.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/user_other.dart';
import '../../shared/components/components.dart';
import '../../shared/components/loading_gif.dart';
import '../../shared/styles/colors.dart';
import '../home/4_more/3_contact_us/contact_us.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'details_widget.dart';

class UserDetailsScreen extends StatefulWidget 
{
  final String? otherUserId;
  
  UserDetailsScreen({
      Key? key, 
      String? this.otherUserId,
    }
  ):super(key: key);

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> 
{  
  OtherUser otherUser = new OtherUser();

  @override
  void initState() 
  {
    super.initState();


    if (widget.otherUserId != null){
      UserDetailsCubit.get(context).getOtherUser(otherId: widget.otherUserId??"");
    }

  }  

  @override
  Widget build(BuildContext context) 
  {
    return BlocConsumer<UserDetailsCubit, UserDetailsStates>(
      listener: (context, state) {
        if (state is UserDetailsSuccessState){
          otherUser = state.otherUser!;
        }
        //UserDetailsErrorState
        else if (state is UserDetailsErrorState ) {
          showToast(msg: state.error,  state: ToastStates.ERROR);
        }
        else if (state is AddHimToMyContactsSuccess ) { }
        else if (state is AddHimToMyContactsAdded ) {
          if(state.msg.isNotEmpty) 
            showToast(msg: state.msg,  state: ToastStates.SUCCESS);
        }
        else if (state is AddHimToMyContactsError){
          showToast(msg: state.error, state: ToastStates.SUCCESS);
        }else if( state is BlockHimSuccess){
          setState(() { 
            this.otherUser.isBlockedByMe = state.isBlockedByMe;             
          });
          showToast(msg: state.msg, state: ToastStates.SUCCESS);
        }
        else if (state is BlockHimError){
          showToast(msg: state.error, state: ToastStates.SUCCESS);
        }
        else if (state is AddToFavouriteSuccessState){
          setState(() { this.otherUser.isFavorate = true; });
          showToast(msg: "تم التحديث", state: ToastStates.SUCCESS);
        }
        else if (state is RemoveFromFavouriteSuccessState){
          setState(() { this.otherUser.isFavorate = false; });
          showToast(msg: "تم التحديث", state: ToastStates.SUCCESS);
        }
      },

      builder: (context, state) => 
        Directionality(
          textDirection: TextDirection.rtl,
          child: 
            Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: BG_DARK_COLOR,
                toolbarHeight: 9.h,
                title: 
                  ConditionalBuilder(
                    condition: state is UserDetailsLoadingState,                    
                    builder: (context) => Text("..."),
                    fallback: (context) => 
                      Text( this.otherUser.user_Name??  "التفاصيل", 
                                style: GoogleFonts.almarai(color: Colors.white), ),
                    ),
                actions: [
                  Padding(
                    padding:
                    EdgeInsetsDirectional.only(end: 3.w, top: 0.h),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () async { snapchatPressed(context); },
                            child: Image(image: AssetImage("assets/snapchat.png"), height: 4.h, width: 10.w,)
                        ),

                        // قائمة الثلاث نقط
                        PopupMenuButton(
                            onSelected: (item) { },
                            position: PopupMenuPosition.under,
                            itemBuilder: (context) => <PopupMenuEntry>[
                              PopupMenuItem(
                                height: 10.h,
                                padding: EdgeInsets.all(0),
                                child: Column(
                                  children: [
                                    InkWell(
                                      child: 
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            children: [
                                              Text("         حظر المستخدم",
                                                style: GoogleFonts.almarai( fontWeight: FontWeight.w300),
                                              ),
                                                            
                                              SizedBox(width: 1.w,),
                                              
                                              ConditionalBuilder(
                                                condition: state is BlockHimLoading ,
                                                builder:  (context) => CircularProgressIndicator(),
                                                fallback: (context)  => Icon(Icons.block, color: PRIMARY,size: 33,)
                                                ),
                                          ]),
                                        ),
                                      onTap: () 
                                      {
                                        if (IS_LOGIN == false) {
                                          showDialog(
                                              context: context,
                                              builder: (context) => const DialogPleaseLogin());
                                          return;
                                        }
                                        blockUser_pressed(context); 
                                      },
                                    ),
                      
                                    Container( height: 0.01.h, color: Colors.black, ),
                                    
                                    InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text("الابلاغ عن محتوي غير مناسب",
                                            style: GoogleFonts.almarai( fontWeight: FontWeight.w300)),
                                      ),
                                      onTap: (){ ReportAnIssuePressed(context); },
                                    ),
                                  ],
                                ),
                              )
                            ]),
                      ],
                    ),
                  )
                ],
                leading: InkWell(
                  onTap: () { Navigator.pop(context); },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),

              body: 
                SingleChildScrollView(
                  // ويدجيت لعرض بيانات المستخدم،
                  child: 
                    ConditionalBuilder(
                      condition: state is UserDetailsLoadingState,
                      builder:  (context) => LoadingGif(),
                      fallback: (context) => 
                        DetailsWidget(
                          state: state,
                          otherUser: this.otherUser,
                        ),
                      ),
                      ),
                ),
              ),

        );
  } //end

  void blockUser_pressed(BuildContext context)
  {
    UserDetailsCubit.get(context)
        .blockHim(userId: this.otherUser.id!);

  }

  void ReportAnIssuePressed(BuildContext context)
  {
    navigateTo(context: context, widget: ContactUS(
      isFromLogin: false,
    ));
  }

  void snapchatPressed(BuildContext context) async 
  {

      String uristr = "https://www.snapchat.com/add/zoagge?share_id=lRtrrfi6OZo&locale=ar-AE";
      Uri uri = Uri(
        scheme: "https", 
        path: "www.snapchat.com/add/zoagge?share_id=lRtrrfi6OZo&locale=ar-AE"
      );
      log('Launch to ${uri}');
      // if (await launchUrl(uri, mode: LaunchMode.platformDefault)) {} 
      if (await launch( uristr )) { }
      else {
        showToast(msg: 'Could not launch ${uri}', state: ToastStates.ERROR);
      }
  }
}
