import 'package:astarar/modules/details_user/cubit/cubit.dart';
import 'package:astarar/modules/details_user/details_user.dart';
import 'package:astarar/modules/login/login.dart';
import 'package:astarar/modules/search/cubit/cubit.dart';
import 'package:astarar/modules/search/cubit/states.dart';
import 'package:astarar/modules/search/filter_search.dart';
import 'package:astarar/shared/components/components.dart';
import 'package:astarar/shared/components/loading_gif.dart';
import 'package:astarar/shared/components/user/user_item.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchCubit.get(context).searchDone = false;
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: white,
              body: Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 20.h,
                        width: double.infinity,
                        child: Stack(clipBehavior: Clip.none, children: [
                          Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            bottom: isLogin ? 3.h : 4.h,
                            child: PreferredSize(
                              preferredSize: Size.fromHeight(18.h),
                              child: Container(
                                height: 10.h,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/appbarimage.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: AppBar(
                                  toolbarHeight: 15.h,
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: isLogin! ? 2.h : 0,
                                      ),
                                      Text(
                                        isLogin! ? name! : "اهلا بك ",
                                        style: TextStyle(
                                            color: white, fontSize: 11.sp),
                                      ),
                                      if (isLogin!)
                                        Text(
                                          age! + " " + "عاما",
                                          style: TextStyle(
                                              color: customGrey,
                                              fontSize: 11.sp),
                                        ),
                                      if (isLogin == false)
                                        Row(
                                          children: [
                                            Text(
                                              "سجل دخول",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: white,
                                                  fontSize: 10.sp),
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
                                                    color: white,
                                                    fontSize: 10.sp,
                                                    decoration: TextDecoration
                                                        .underline),
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
                                            color: white,
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
                                                  image: genderUser == 1
                                                      ? AssetImage(maleImage)
                                                      : AssetImage(
                                                      femaleImage))),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // leading: Padding(
                                  //     padding: EdgeInsetsDirectional.only(
                                  //         top: 2.h, start: 2.5.w),
                                  //     child: Container(
                                  //       height: 2.h,
                                  //       decoration: BoxDecoration(
                                  //           shape: BoxShape.circle,
                                  //           image: DecorationImage(
                                  //               image: genderUser == 1
                                  //                   ? AssetImage(maleImage)
                                  //                   : AssetImage(femaleImage))),
                                  //     )),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0.h,
                            child: Container(
                              height: 9.h,
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(
                                    top: 2.h, start: 40.w),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        print(SearchCubit.get(context)
                                            .searchTextController
                                            .text);
                                        if (SearchCubit.get(context)
                                                .searchTextController
                                                .text !=
                                            "") {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FilterSearchScreen(
                                                        textSearch: SearchCubit
                                                                .get(context)
                                                            .searchTextController
                                                            .text,
                                                      )));
                                        } else {
                                          showToast(
                                              msg: "من فضلك ابحث عن شي",
                                              state: ToastStates.SUCCESS);
                                        }
                                      },
                                      child: Container(
                                        width: 40.w,
                                        height: 9.h,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Material(
                                              elevation: 5.0,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Container(
                                                height: 6.h,
                                                width: 40.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: InkWell(
                                                  onTap: () {
                                                    print(SearchCubit.get(
                                                            context)
                                                        .searchTextController
                                                        .text);
                                                    if (SearchCubit.get(context)
                                                            .searchTextController
                                                            .text !=
                                                        "") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  FilterSearchScreen(
                                                                    textSearch: SearchCubit.get(
                                                                            context)
                                                                        .searchTextController
                                                                        .text,
                                                                  )));
                                                    } else {
                                                      showToast(
                                                          msg:
                                                              "من فضلك ابحث عن شي",
                                                          state: ToastStates
                                                              .SUCCESS);
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .only(
                                                            top: 5.0,
                                                            start: 10.0,
                                                            end: 10),
                                                    child: Row(
                                                      children: [
                                                        InkWell(
                                                            onTap: () {
                                                              print(SearchCubit
                                                                      .get(
                                                                          context)
                                                                  .searchTextController
                                                                  .text);
                                                              if (SearchCubit.get(
                                                                          context)
                                                                      .searchTextController
                                                                      .text !=
                                                                  "") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            FilterSearchScreen(
                                                                              textSearch: SearchCubit.get(context).searchTextController.text,
                                                                            )));
                                                              } else {
                                                                showToast(
                                                                    msg:
                                                                        "من فضلك ابحث عن شي",
                                                                    state: ToastStates
                                                                        .SUCCESS);
                                                              }
                                                            },
                                                            child: const Text(
                                                                'بحث بالفلتر')),
                                                        const Spacer(),
                                                        InkWell(
                                                          onTap: () {
                                                            print(SearchCubit
                                                                    .get(
                                                                        context)
                                                                .searchTextController
                                                                .text);
                                                            if (SearchCubit.get(
                                                                        context)
                                                                    .searchTextController
                                                                    .text !=
                                                                "") {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          FilterSearchScreen(
                                                                            textSearch:
                                                                                SearchCubit.get(context).searchTextController.text,
                                                                          )));
                                                            } else {
                                                              showToast(
                                                                  msg:
                                                                      "من فضلك ابحث عن شي",
                                                                  state: ToastStates
                                                                      .SUCCESS);
                                                            }
                                                          },
                                                          child: Image(
                                                            image: AssetImage(
                                                                'assets/filter.png'),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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
                                      child: Container(
                                        height: 80.0,
                                        width: 70.0,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/snapchat.png'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 2.5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: defaultTextFormField(
                            labelTextcolor: primary,
                            borderColor: primary,
                            container: backGround,
                            onsubmit: (value) {
                              SearchCubit.get(context).search(
                                  text: SearchCubit.get(context)
                                      .searchTextController
                                      .text);
                              SearchCubit.get(context).getSearch = true;
                            },
                            suffixPressed: () {
                              SearchCubit.get(context).search(
                                  text: SearchCubit.get(context)
                                      .searchTextController
                                      .text);
                              SearchCubit.get(context).getSearch = true;
                            },
                            onchange: (value) {
                              print(value);
                            },
                            context: context,
                            suffix: Icons.search,
                            controller:
                                SearchCubit.get(context).searchTextController,
                            type: TextInputType.text,
                            validate: (value) {},
                            label: "البحث"),
                      ),
                      Visibility(
                        visible: SearchCubit.get(context).getSearch,
                        child: ConditionalBuilder(
                            condition: state is! GetSearchLoadingState,
                            fallback: (context) => SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            "assets/double_ring.gif"),
                                        height: 12.h,
                                        width: 25.w,
                                      )
                                    ],
                                  ),
                                ),
                            builder: (context) => Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(
                                            start: 5.w, top: 2.h),
                                        child: Text('النتائج',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w100,
                                                fontSize: 19)),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(bottom: 2.h),
                                        child: GridView.count(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              childAspectRatio: 1 / 1.2,
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 0.0,
                                              mainAxisSpacing: 12.0,
                                              children: List.generate(
                                                  SearchCubit.get(context)
                                                      .searchList
                                                      .length, (index) {
                                                return Center(
                                                    child: UserItem(
                                                  visibileRemoveIcon: false,
                                                  removeUser: () {},
                                                  onclickUser: () {
                                                    if (isLogin!) {
                                                      GetInformationCubit
                                                              .get(context)
                                                          .getInformationUser(
                                                              userId:
                                                                  SearchCubit.get(
                                                                          context)
                                                                      .searchList[
                                                                          index]
                                                                      .id!);
                                                    } else {
                                                      GetInformationCubit
                                                              .get(context)
                                                          .getInformationUserByVisitor(
                                                              userId:
                                                                  SearchCubit.get(
                                                                          context)
                                                                      .searchList[
                                                                          index]
                                                                      .id!);
                                                    }
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                DetailsUserScreen(
                                                                  messageVisibility:
                                                                      true,
                                                                )));
                                                  },
                                                  genderValue:
                                                      SearchCubit.get(context)
                                                          .searchList[index]
                                                          .gender!,
                                                  username:
                                                      SearchCubit.get(context)
                                                          .searchList[index]
                                                          .user_Name!,
                                                ));
                                              })),
                                      ),

                                    ])),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
