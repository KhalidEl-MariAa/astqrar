import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import '../../models/user_item.dart';
import '../../shared/components/components.dart';
import '../../shared/components/user/user_item.dart';
import '../../shared/styles/colors.dart';
import '../login/login.dart';
import '../user_details/cubit/cubit.dart';
import '../user_details/user_details.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'filter_search.dart';

class ResultScreen extends StatefulWidget 
{
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> 
{
  TextEditingController searchTextController = TextEditingController();

  List<UserItem> searchResult = [];

  @override
  Widget build(BuildContext context) 
  {
    return BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {
          if(state is GetSearchSuccessState)
          {
            setState(() {
              this.searchResult = state.searchResult;  
            });
          }
        },
        builder: (context, state) {
          
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: WHITE,
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
                            bottom: IS_LOGIN ? 3.h : 4.h,
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
                                        height: IS_LOGIN? 2.h : 0,
                                      ),
                                      Text(
                                        IS_LOGIN? NAME! : "اهلا بك ",
                                        style: TextStyle(
                                            color: WHITE, fontSize: 11.sp),
                                      ),
                                      if (IS_LOGIN)
                                        Text(
                                          AGE! + " " + "عاما",
                                          style: TextStyle(
                                              color: CUSTOME_GREY,
                                              fontSize: 11.sp),
                                        ),
                                      if (IS_LOGIN == false)
                                        Row(
                                          children: [
                                            Text(
                                              "سجل دخول",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: WHITE,
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
                                                    color: WHITE,
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
                                      onTap: () { show_filter_search_screen(context); },
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
                                                  onTap: () { show_filter_search_screen(context); },
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
                                                            onTap: () { show_filter_search_screen(context); },
                                                            child: const Text(
                                                                'بحث بالفلتر')),
                                                        const Spacer(),
                                                        InkWell(
                                                          onTap: () { show_filter_search_screen(context); },
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
                                      onTap: () async 
                                      {
                                        Uri url = Uri(
                                          scheme: "https", 
                                          path: "www.snapchat.com/add/zoagge?share_id=lRtrrfi6OZo&locale=ar-AE"
                                        );
                                        if (await launchUrl(url, mode: LaunchMode.platformDefault)) {} 
                                        else { throw 'Could not launch ${url}'; }
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
                        child: 
                        defaultTextFormField(
                            labelTextcolor: PRIMARY,
                            borderColor: PRIMARY,
                            container: BG_DARK_COLOR,
                            onsubmit: (value) { start_searching(context); },
                            suffixPressed: () { start_searching(context); },
                            onchange: (value) { },
                            context: context,
                            suffix: Icons.search,
                            controller: searchTextController,
                            type: TextInputType.text,
                            validate: (value) { return null; },
                            label: "البحث"),
                      ),
                      Visibility(
                        visible: true, //SearchCubit.get(context).getSearch,
                        child: 
                          ConditionalBuilder(
                            condition: (state is GetSearchLoadingState) || (state is FilterSearchLoadingState), 
                            builder: (context) => 
                                SingleChildScrollView(
                                  child: Column(                                    
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,                                    
                                    children: [
                                      Image(
                                        image: AssetImage("assets/loading.gif"), //loading image
                                        height: 12.h,
                                        width: 25.w,
                                      )
                                    ],
                                  ),
                                ),
                            fallback: 
                                (context) => Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(start: 5.w, top: 2.h),
                                        child: Text( 'النتائج' + " ( ${this.searchResult.length} )",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w200,
                                                fontSize: 19)),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(bottom: 2.h),
                                        child: GridView.count(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              childAspectRatio: 1 / 1.2,
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 0.0,
                                              mainAxisSpacing: 12.0,
                                              children: 
                                                List.generate(
                                                  this.searchResult.length, 
                                                  (index) {
                                                    return Center(
                                                        child: user_item_thmbnail(context, index)
                                                    );
                                                  }
                                                )
                                              ),
                                      ),
                                    ])
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  UserItemWidget user_item_thmbnail(BuildContext context, int index) 
  {
    return UserItemWidget(
      visibileRemoveIcon: false,
      removeUser: () {},
      onclickUser: () {
        if (IS_LOGIN) {
          UserDetailsCubit.get(context)
              .getOtherUser(
                  otherId: this.searchResult[index].id!);
        } else {
          UserDetailsCubit.get(context)
              .getInformationUserByVisitor(
                  userId: this.searchResult[index].id!);
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    UserDetailsScreen(
                      messageVisibility:
                          true,
                    )));
      },
      genderValue:
          this.searchResult[index].gender!,
      username:
          this.searchResult[index].user_Name!,
    );
  }

  void show_filter_search_screen(BuildContext context)
  {
    print(searchTextController.text);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  FilterSearchScreen(
                    textSearch: searchTextController.text,
                  )));

  }

  void start_searching(BuildContext context) 
  {

    if (searchTextController.text != "") 
    {
      SearchCubit.get(context).searchByText(
        text: searchTextController.text);

    } else {
      showToast(
          msg: "من فضلك اكتب اي كلمة بحثية",
          state: ToastStates.SUCCESS);
    }

  }
}
