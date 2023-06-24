import '../user_details/cubit/cubit.dart';
import '../user_details/user_details.dart';
import '../login/login.dart';
import '../section%20men%20_women/cubit/cubit.dart';
import '../section%20men%20_women/cubit/states.dart';
import '../../shared/components/loading_gif.dart';
import '../../shared/components/user/user_item.dart';
import '../../constants.dart';
import '../../shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class SectionMenOrWomen extends StatelessWidget 
{
  final int gender;
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

  SectionMenOrWomen({required this.gender});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUserByGenderCubit, GetUserByGenderStates>(
      listener: (context, state) {},
      builder: (context, state) => 
        ConditionalBuilder(
          condition: state is GetUserByGenderLoadingState,
          builder: (context) => Scaffold(backgroundColor: WHITE, body: const LoadingGif()),
          fallback: (context) => Directionality(
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
                                        style: TextStyle(
                                            color: WHITE, fontSize: 11.sp),
                                      ),
                                      if (IS_LOGIN)
                                        Text(
                                          AGE! + " " + "عاما",
                                          style: TextStyle(
                                              color: CUSTOME_GREY, fontSize: 10.sp),
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
                                                            const LoginScreen()));
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
                                  leadingWidth: 21.35.w,
                                  centerTitle: false,
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  leading: Row(
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
                                          padding: EdgeInsetsDirectional.only(
                                              top: 2.h, start: 0.w),
                                          child:
                                              Container(
                                                height: 7.h,
                                                width: 12.w,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: GENDER_USER == 1
                                                            ? AssetImage(maleImage)
                                                            : AssetImage(
                                                                femaleImage))),
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
                            right: 4.w,
                            child: Container(
                              height: 4.5.h,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => ChoiceChip (
                                  selectedColor: PRIMARY,
                                  onSelected: (bool value) 
                                  {
                                    GetUserByGenderCubit.get(context)
                                        .changeindexonesection(
                                            index: index,
                                            gender: gender == 1 ? "1" : "2");
                                  },
                                  label: Text(oneSection[index],
                                      style: GoogleFonts.poppins(fontSize: 9.5.sp)),
                                  backgroundColor: Colors.grey[400],
                                  selected: index == oneIndexSection,
                                ),
                                itemCount: oneSection.length,
                                separatorBuilder: (context, index) => SizedBox(
                                  width: 2.w,
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.3.w),
                        child: Container(
                          height: 4.5.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => ChoiceChip(
                              selectedColor: PRIMARY,
                              onSelected: (bool value) {
                                GetUserByGenderCubit.get(context)
                                    .changeindextwosection(
                                        index: index,
                                        gender: gender == 1 ? "1" : "2");
                              },
                              label: Text(twoSection[index],
                                  style: GoogleFonts.poppins(fontSize: 9.5.sp)),
                              backgroundColor: Colors.grey[400],
                              selected: index == twoIndexSection,
                            ),
                            itemCount: twoSection.length,
                            separatorBuilder: (context, index) => SizedBox(
                              width: 1.w,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.8.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.3.w),
                        child: Container(
                          height: 4.5.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: threeSection.length,
                            separatorBuilder: (context, index) => SizedBox(width: 1.w,),
                            itemBuilder: (context, index) => ChoiceChip(
                              selectedColor: PRIMARY,
                              onSelected: (bool value) {
                                GetUserByGenderCubit.get(context)
                                    .changeindexthreesection(
                                        index: index,
                                        gender: gender == 1 ? "1" : "2");
                              },
                              label: Text(threeSection[index],
                                  style: GoogleFonts.poppins(fontSize: 9.5.sp)),
                              backgroundColor: Colors.grey[400],
                              selected: index == threeIndexSection,
                            ),
                          ),
                        ),
                      ),

                      if (GetUserByGenderCubit.get(context).users.isNotEmpty)
                        GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 1 / 0.15.h,
                            crossAxisCount: 3,
                            crossAxisSpacing: 0.0,
                            mainAxisSpacing: 1.h,
                            children: List.generate(
                                GetUserByGenderCubit.get(context).users.length,
                                (index) {
                                  return Center(
                                      child: UserItemWidget(
                                          visibileRemoveIcon: false,
                                          removeUser: () {},
                                          onclickUser: () { onClickUserItem(context, index); },
                                          genderValue: GetUserByGenderCubit.get(context)
                                              .users[index]
                                              .gender!,
                                          username: GetUserByGenderCubit.get(context)
                                              .users[index]
                                              .user_Name!,
                                  )
                                );
                              }
                            )

                      )
                    ],
                  ),
                ),
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
      GetInformationCubit.get(context)
          .getInformationUser(
              otherId:
                  GetUserByGenderCubit.get(context)
                      .users[index]
                      .id!);
    }else{
      GetInformationCubit.get(context)
          .getInformationUserByVisitor(
              userId:
                  GetUserByGenderCubit.get(context)
                      .users[index]
                      .id!);
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserDetailsScreen(
                  messageVisibility: true,
                )));
  }
}
