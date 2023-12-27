
import 'dart:developer';

import '../../shared/components/components.dart';

import '../user_details/cubit/cubit.dart';
import '../user_details/user_details.dart';
import '../login/login.dart';
import '../../shared/components/loading_gif.dart';
import '../../shared/components/user_item.dart';
import '../../constants.dart';
import '../../shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SectionMenOrWomen extends StatelessWidget 
{
  final String gender;
  final List<String> oneSection = ['#الكل', 'زواج معلن', 'زواج التعدد', 'زواج مسيار'];
  final List<String> twoSection = [
    "#الكل",
    "من 18 الي 30",
    "من 30 الي 40",
    "من 40 الي 50"
  ];

  final List<String> threeSection = ["#الكل", "سعودي", "مقيم"];
  static int oneIndexSection = 0;
  static int twoIndexSection = 0;
  static int threeIndexSection = 0;  

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  SectionMenOrWomen({required this.gender});

  @override
  Widget build(BuildContext context) 
  {
    bool is_landscape = (MediaQuery.of(context).orientation == Orientation.landscape);

    return BlocConsumer<MenWomenCubit, MenWomenStates>(      
      listener: (context, state) 
      {
        if(state is MenWomenInitialState){
          MenWomenCubit.get(context).users = [];
          log('INITIAL -------------------');
        }
      
      },
      builder: (context, state) => 
          Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 19.h,
                        width: double.infinity,
                        child: Stack(children: [
                          Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            bottom: 1.5.h,
                            child: PreferredSize(
                              preferredSize: Size.fromHeight(18.h),
                              child: Container(
                                height: 11.h,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/appbarimage.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: AppBar(
                                  toolbarHeight: 14.h,
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text(
                                        IS_LOGIN ? NAME! : "اهلا بك ",
                                        style: GoogleFonts.almarai(
                                            color: WHITE, fontSize: 15.sp),
                                      ),
                                      if (IS_LOGIN)
                                        Text(
                                          AGE! + " " + "عاما",
                                          style: GoogleFonts.almarai(
                                              color: GREY, fontSize: 13.sp),
                                        ),
                                      if (IS_LOGIN == false)
                                        Row(
                                          children: [
                                            Text(
                                              "سجل دخول",
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.almarai(color: WHITE, fontSize: 10.sp),
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
                                                            const LoginScreen()));
                                              },
                                              child: Text(
                                                "من هنا",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.almarai(
                                                    color: WHITE,
                                                    fontSize: 10.sp,
                                                    decoration: TextDecoration.underline),
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                  //   titleSpacing: -10,
                                  leadingWidth: 21.35.w,
                                  centerTitle: false,
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,

                                  leading: 
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.only(start: 3.w,top:0.h ),
                                            child: Icon(
                                              Icons.arrow_back_ios,
                                              color: WHITE,
                                              size: 13.sp,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 2.w,),
                                        Padding(
                                            padding: EdgeInsetsDirectional.only(top: 2.h, start: 0.w),
                                            child:
                                                Container(
                                                  height: 7.h,
                                                  width: 12.w,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: getUserImageByPath(
                                                            imgProfilePath: IMG_PROFILE,
                                                            gender:  GENDER_USER),
                                                          fit: BoxFit.cover
                                                    )),
                                                ),
                                              ),
                                      ],
                                    ),
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 0,
                            child: 
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 3.3.w),
                                height: 4.5.h,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: oneSection.length,
                                  separatorBuilder: (context, index) => SizedBox(width: 2.w,),
                                  itemBuilder: (context, index) => 

                                    // البادج حق الفلتر - نوع الزواج
                                    ChoiceChip (
                                      padding: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                                      selectedColor: PRIMARY,
                                      onSelected: (bool value) 
                                      {
                                        MenWomenCubit.get(context)
                                            .changeindexonesection(
                                                index: index,
                                                gender: this.gender == "1" ? "1" : "2");
                                      },
                                      label: 
                                        Text(oneSection[index],
                                          style: GoogleFonts.almarai(fontSize: 8.5.sp, fontWeight: FontWeight.bold)
                                        ),
                                      backgroundColor: Colors.grey[400],
                                      selected: index == oneIndexSection,
                                    ),                                  
                                ),

                              ),
                          ),
                        ]),
                      ),

                      SizedBox(height: 0.5.h, ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.3.w),
                        height: 4.5.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => 
                          // البادج حق الفلتر - العمر
                          ChoiceChip(
                            padding: EdgeInsets.all(2.0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                            selectedColor: PRIMARY,
                            onSelected: (bool value) {
                              MenWomenCubit.get(context)
                                  .changeindextwosection(
                                      index: index,
                                      gender: this.gender == "1" ? "1" : "2");
                            },
                            label: 
                              Text(twoSection[index],
                                style: GoogleFonts.almarai(fontSize: 8.5.sp, fontWeight: FontWeight.bold)
                              ),
                            backgroundColor: Colors.grey[400],
                            selected: index == twoIndexSection,
                          ),
                          itemCount: twoSection.length,
                          separatorBuilder: (context, index) => SizedBox(width: 1.w,),
                        ),
                      ),
                      SizedBox(height: 0.8.h,),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.3.w),
                        height: 4.5.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: threeSection.length,
                          separatorBuilder: (context, index) => SizedBox(width: 1.w,),
                          itemBuilder: (context, index) => 
                          
                          // البادج حق الفلتر - الجنسية
                          ChoiceChip(
                            padding: EdgeInsets.all(2.0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                            selectedColor: PRIMARY,
                            onSelected: (bool value) {
                              MenWomenCubit.get(context)
                                  .changeindexthreesection(
                                      index: index,
                                      gender: this.gender == "1" ? "1" : "2");
                            },
                            label: 
                              Text(threeSection[index],
                                style: GoogleFonts.almarai(fontSize: 8.5.sp, fontWeight: FontWeight.bold)

                              ),
                            backgroundColor: Colors.grey[400],
                            selected: index == threeIndexSection,
                          ),
                        ),
                      ),

                      RefreshIndicator(
                        key: _refreshIndicatorKey,
                        onRefresh: () => _pullRefresh(context), 
                        child: 
                          GridView.builder(
                            padding: EdgeInsets.all(10),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:   SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: is_landscape ? 5 : 3  ,
                              childAspectRatio: 1/1.4,  // width/height
                              crossAxisSpacing: 4.w,    // between columns
                              mainAxisSpacing: 1.h,    //between rows
                            ),
                            itemCount: MenWomenCubit.get(context).users.length,
                            itemBuilder: (context, index) => 
                                Container(
                                  // color: Colors.red,
                                  child: 
                                    UserItemWidget(
                                        showRemoveIcon: false,
                                        removeUser: () {},
                                        onclickUser: () { onClickUserItem(context, index); },
                                        otherUser: MenWomenCubit.get(context).users[index],
                                    ),
                                ),
                          )
                    ),


                    ConditionalBuilder(
                      condition: state is QuickFilterLoading || state is MenWomenLoadingState, 
                      builder: (context) =>  LoadingGif(), 
                      fallback: (context) =>                       
                        Center(
                          child: InkWell(
                            child: Text("المزيد ... ⬇️", 
                              style: GoogleFonts.almarai(fontSize: 15.5.sp, color: PRIMARY)
                            ),
                             
                            onTap: () {
                              log('refresh');
                              _refreshIndicatorKey.currentState?.show();
                            },),
                        ),
                    ),

                    SizedBox(height: 5.1.h,),

                    ],),
                ),
              ),
            ),
          ),

    );
  }

  void onClickUserItem(BuildContext context, int index) 
  {
    if (IS_LOGIN == true) 
     {
      UserDetailsCubit.get(context)
        .getOtherUser(
              otherId: MenWomenCubit.get(context).users[index].id!);
    }else{
      UserDetailsCubit.get(context)
          .getInformationUserByVisitor(
              userId: MenWomenCubit.get(context).users[index].id!);
    }
    navigateTo(
      context: context, 
      widget: UserDetailsScreen()
    );
  }

  Future<void> _pullRefresh(context) async
  {
    await MenWomenCubit.get(context).getUsersByQuickFilter(gender: this.gender);

    log("Lsit is RERFRESHED!!");
  }
}
