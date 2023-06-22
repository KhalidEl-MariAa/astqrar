import 'dart:developer';
import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../notification.dart';
import '../../shared/components/loading_gif.dart';
import '../../shared/contants/constants.dart';
import '../../shared/styles/colors.dart';
import '../ads/ads.dart';
import '../login/login.dart';
import '../search/cubit/cubit.dart';
import '../search/filter_search.dart';
import '../search/result.dart';
import '../section%20men%20_women/cubit/cubit.dart';
import '../section%20men%20_women/section_men_women.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'widgets/container_home.dart';
import 'widgets/empty_slider.dart';
import 'widgets/slider_home.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> 
{
  @override
  void initState() 
  {
    super.initState();
    NotiticationWidget(context).init();
    if (Platform.isIOS) {
      NotiticationWidget(context).requestIOSPermissions();
    }

    NotiticationWidget(context);

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        log("empty");
      }
    });
    
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) 
    {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      //foreground
      if (notification != null && android != null) {
        NotiticationWidget.showNotification(
          notification.hashCode,
          payload: message.data['screen'],
          title: notification.title,
          body: notification.body,
        );
      }
    });

    // background State
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if (event.data["screen"] == "cart") {
      } else {}
    });

    //terminal
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        if (event.data["screen"] == "cart") {
        } else {}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 22.h,
                width: double.infinity,
                child: Stack(clipBehavior: Clip.none, children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    bottom: 3.5.h,
                    child: PreferredSize(
                      preferredSize: Size.fromHeight(19.h),
                      child: Container(
                        height: 12.h,
                        decoration:const  BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/appbarimage.png"),
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
                                isLogin? name??"XX" :"اهلا بك ",
                                style: TextStyle(color: white,fontSize: 11.sp),
                              ),
                          if(isLogin)    Text(
                              age! + " " + "عاما",
                                textAlign: TextAlign.start,
                                style:
                                    TextStyle(color: customGrey, fontSize: 11.sp),
                              ),
                              if(isLogin==false)
                                Row(
                                  children: [
                                    Text(
                                     "سجل دخول",
                                      textAlign: TextAlign.start,
                                      style:
                                      TextStyle(color: white, fontSize: 10.sp),
                                    ),
                                    SizedBox(width: 1.w,),
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                                      },
                                      child: Text(
                                        "من هنا",
                                        textAlign: TextAlign.start,
                                        style:
                                        TextStyle(color: white, fontSize: 10.sp,decoration:TextDecoration.underline),
                                      ),
                                    ),
                                  ],
                                ),

                            ],
                          ),
                          //   titleSpacing: -10,
                          leadingWidth: 13.w,
                          centerTitle: false,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          leading: Padding(
                              padding: EdgeInsetsDirectional.only(
                                  top: 2.h, start: 2.5.w),
                              child: Container(
                                height: 2.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: genderUser == 1
                                            ? AssetImage(maleImage)
                                            : AssetImage(femaleImage))),
                              )),
                          actions: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.only(end: 3.w, top: 2.h),
                              child: InkWell(
                                  onTap: () async 
                                  {
                                    Uri url = Uri(
                                      scheme: "https", 
                                      path: "www.snapchat.com/add/zoagge?share_id=lRtrrfi6OZo&locale=ar-AE"
                                    );
                                    if (await launchUrl(url, mode: LaunchMode.platformDefault)) {} 
                                    else { throw 'Could not launch ${url}'; }
                                  },
                                  child: Image(
                                    image: AssetImage("assets/snapchat.png"),
                                    height: 3.h,
                                    width: 10.w,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.h,
                    top: 13.8.h,
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.h),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        shadowColor: Colors.grey[400],
                        child: Container(
                          height: 4.8.h,
                          width: 92.w,
                          child: TextFormField(
                            readOnly: true,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ResultScreen() ));
                            },
                            decoration: InputDecoration(
                              prefixIcon:const  Icon(Icons.search),
                              hintText: "ابحث الان",
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20)),
                              filled: true,
                              fillColor: white,
                            ),
                          ),
                        ),
                      ),
                    )),
                  ),
                ]),
              ),
              SizedBox(
                height:isLogin&&typeOfUser==1? 1.h:5.h,
              ),
       if(isLogin&&typeOfUser==1)     Padding(
                padding:
                    EdgeInsetsDirectional.only(start: 5.w, top: 2.h, bottom: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("تواصل معنا لتعلن عن صفحتك الشخصية",
                        style: GoogleFonts.almarai(
                            color: grey, 
                            fontSize: 9.6.sp,
                            fontWeight: FontWeight.w600)),
                    SizedBox(
                      width: 1.w,
                    ),
                    InkWell(
                      child: Text(
                        "تواصل معنا",
                        style: GoogleFonts.almarai(
                            color: primary,
                            decoration: TextDecoration.underline,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                           MaterialPageRoute(builder: (context) => AdsScreen()));
                      },
                    )
                  ],
                ),
              ),

            ConditionalBuilder(
                condition: state is GetUserAdsLoadingState,
                builder: (context) => LoadingGif(),
                fallback: (context) =>  HomeCubit.get(context).getAllAdsWithUsersModel.data.length > 0? SliderHome():EmptyResult(),
              ),
              SizedBox(
                height: 5.h,
              ),

            // if(typeOfUser==1||isLogin==false)
            //   Padding(
            //     padding: EdgeInsetsDirectional.only(start: 3.w),
            //     child: Text(
            //         "تواصل  مع اي خطابة تريد لمساعدتك في ايجاد الشخص المناسب",
            //         style: GoogleFonts.almarai(
            //             color: HexColor("A4A4A4"), fontSize: 8.8.sp,fontWeight: FontWeight.w600)),
            //   ),
            //   SizedBox(
            //     height: 1.5.h,
            //   ),
            // if(typeOfUser==1||isLogin==false) Padding(
            //   padding: EdgeInsetsDirectional.only(start: 3.w),
            //   child: InkWell(
            //     onTap: () {
            //       navigateTo(context: context, widget: DelegatesSection());
            //     },
            //     child: Text(
            //       "تواصل مع الخطابة",
            //       style: GoogleFonts.almarai(
            //           color: primary,
            //           decoration: TextDecoration.underline,
            //           fontSize: 12.sp,
            //           fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),

              SizedBox(
                height: 4.h,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 10),
                child: Text(
                  ": بامكانك ان تبحث بنفسك هنا",
                  style: GoogleFonts.almarai(
                    color: grey,
                    fontWeight: FontWeight.w600)
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Row(
                  children: [
                    
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          HubConnectionBuilder()
                            .withUrl("${BASE_URL}chatHub")
                            .build();

                          SectionMenOrWomen.oneIndexSection=0;
                              SectionMenOrWomen.twoIndexSection=0;
                              SectionMenOrWomen.threeIndexSection=0;
                              GetUserByGenderCubit.get(context).getUserByGender(genderValue: 1);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SectionMenOrWomen(gender: 1,)));
                        },
                        child: ContainerHome(
                          text: "قسم الرجال",
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Expanded(
                      child: InkWell(
                          onTap: () {
                            SectionMenOrWomen.oneIndexSection = 0;
                            SectionMenOrWomen.twoIndexSection = 0;
                            SectionMenOrWomen.threeIndexSection = 0;
                            GetUserByGenderCubit.get(context)
                                .getUserByGender(genderValue: 2);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SectionMenOrWomen(
                                          gender: 2,
                                        )));
                          },
                          child: ContainerHome(text: "قسم النساء")),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
