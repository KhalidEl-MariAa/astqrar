import 'dart:developer';

import 'package:astarar/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/components/loading_gif.dart';
import '../../../constants.dart';
import '../../../shared/network/remote.dart';
import '../../../shared/styles/colors.dart';
import '../../ads/ads.dart';
import '../../login/login.dart';
import '../../search/result.dart';
import '../../section_men_women/cubit/cubit.dart';
import '../../section_men_women/section_men_women.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'widgets/big_button.dart';
import 'widgets/empty_slider.dart';
import 'widgets/slider_ads.dart';

class HomeTab extends StatefulWidget 
{
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> 
{
  @override
  void initState() 
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) 
  {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is GetUserAdsSuccessState) {}
      },
      builder: (context, state) => Scaffold(
        backgroundColor: WHITE,
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
                        decoration: const BoxDecoration(
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
                                IS_LOGIN ? NAME ?? "---------" : "اهلا بك ",
                                style: GoogleFonts.almarai(color: WHITE, fontSize: 11.sp),
                              ),
                              if (IS_LOGIN)
                                Text(
                                  AGE! + " " + "عاما",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.almarai(
                                      color: CUSTOME_GREY, fontSize: 11.sp),
                                ),
                              if (IS_LOGIN == false)
                                Row(
                                  children: [
                                    Text(
                                      "سجل دخول",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: WHITE, fontSize: 10.sp),
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen()));
                                      },
                                      child: Text(
                                        "من هنا",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: WHITE,
                                            fontSize: 10.sp,
                                            decoration:
                                                TextDecoration.underline),
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
                                        opacity: IS_ACTIVE ? 1.0 : 0.5,
                                        image: getUserImageByPath(
                                          imgProfilePath:  IMG_PROFILE!, 
                                          gender: GENDER_USER!)
                                    )),
                              )),
                          actions: [
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                  end: 3.w, top: 2.h),
                              child: InkWell(
                                  onTap: () async {
                                    String uristr = "https://www.snapchat.com/add/zoagge?share_id=lRtrrfi6OZo&locale=ar-AE";
                                    Uri uri = Uri(
                                        scheme: "https",
                                        path:
                                            "www.snapchat.com/add/zoagge?share_id=lRtrrfi6OZo&locale=ar-AE");
                                    // if (await launchUrl( Uri.parse(uristr) )) {
                                    if (await launch( uristr )) {
                                      log("SNap Done");
                                    } else {
                                      showToast(msg: 'Could not launch ${uri}', state: ToastStates.ERROR);
                                    }
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
                              navigateTo(context: context, widget: ResultScreen() );
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => ResultScreen()));
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              hintText: "ابحث الان",
                              hintStyle: GoogleFonts.almarai(fontSize: 12.sp),
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20)),
                              filled: true,
                              fillColor: WHITE,
                            ),
                          ),
                        ),
                      ),
                    )),
                  ),
                ]),
              ),
              
              SizedBox(height: IS_LOGIN ? 1.h : 5.h, ),

              if (IS_LOGIN )
                Padding(
                  padding: EdgeInsetsDirectional.only(
                      start: 5.w, top: 2.h, bottom: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("أعلن عن صفحتك الشخصية",
                          style: GoogleFonts.almarai(
                              color: GREY,
                              fontSize: 9.6.sp,
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        width: 1.w,
                      ),
                      InkWell(
                        child: Text(
                          "من هنا",
                          style: GoogleFonts.almarai(
                              color: PRIMARY,
                              decoration: TextDecoration.underline,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdsScreen()));
                        },
                      )
                    ],
                  ),
                ),

              ConditionalBuilder(
                condition: state is GetUserAdsLoadingState,
                builder: (context) => LoadingGif(),
                fallback: (context) {
                  // log(LayoutCubit.Countries.toString());
                  if(HomeCubit.get(context).userAds.length > 0 ) 
                  {
                    return SliderAds();
                  } else {
                    return EmptySlider();
                  }
                },
              ),

              SizedBox(
                height: 5.h,
              ),


              SizedBox(
                height: 4.h,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 10),
                child: Text(": بامكانك ان تبحث بنفسك هنا",
                    style: GoogleFonts.almarai(
                        color: GREY, fontWeight: FontWeight.w600)),
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
                        onTap: () async { MenSectionClick(context); },
                        child: BigButton(text: "قسم الرجال",),
                      ),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Expanded(
                      child: InkWell(
                          onTap: () { WomenSectionClick(context); },
                          child: BigButton(text: "قسم النساء")),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 3.h,
              ),

              if (IS_DEVELOPMENT_MODE)
                InkWell(
                  onTap: () { DioHelper.init(); },
                  child: Text("RECONNECT"),
                ),
                
              if (IS_DEVELOPMENT_MODE)
                Text(BASE_URL, style: TextStyle(fontSize: 12.sp),)
            ],
          ),
        ),
      ),
    );
  }

  void WomenSectionClick(BuildContext context) 
  {
    SectionMenOrWomen.oneIndexSection = 0;
    SectionMenOrWomen.twoIndexSection = 0;
    SectionMenOrWomen.threeIndexSection = 0;

    MenWomenCubit.get(context).getUsersByQuickFilter(gender: "2");

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SectionMenOrWomen(gender: "2")));
  }

  void MenSectionClick(BuildContext context) 
  {
    HubConnectionBuilder().withUrl("${BASE_URL}chatHub").build();

    SectionMenOrWomen.oneIndexSection = 0;
    SectionMenOrWomen.twoIndexSection = 0;
    SectionMenOrWomen.threeIndexSection = 0;
    
    MenWomenCubit.get(context).getUsersByQuickFilter(gender: "1");

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SectionMenOrWomen( gender: "1",)
        ));
  }
}
