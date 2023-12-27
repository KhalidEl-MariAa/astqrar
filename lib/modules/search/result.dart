import '../../shared/components/defaultTextFormField.dart';
import '../../shared/components/loading_gif.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import '../../models/user.dart';
import '../../shared/components/components.dart';
import '../../shared/components/user_item.dart';
import '../../shared/styles/colors.dart';
import '../login/login.dart';
import '../user_details/cubit/cubit.dart';
import '../user_details/user_details.dart';
import 'advanced_filter.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ResultScreen extends StatefulWidget {
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> 
{
  TextEditingController searchTextController = TextEditingController();

  List<User> searchResult = [];

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) 
  {
    return 
      BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) 
        {
          if (state is GetSearchSuccessState) {
            setState(() {
              this.searchResult = state.searchResult;
            });
          }
        }, 
        builder: (context, state) 
        {
          bool is_landscape = (MediaQuery.of(context).orientation == Orientation.landscape);
          
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: IS_LOGIN ? 2.h : 0,
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
                                              color: GREY,
                                              fontSize: 13.sp),
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
                                                            LoginScreen()));
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
                                  leading: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 3.w, top: 0.h),
                                          child: Icon(
                                            Icons.arrow_back_ios,
                                            color: WHITE,
                                            size: 13.sp,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(
                                            top: 2.h, start: 0.w),
                                        child: Container(
                                          height: 7.h,
                                          width: 12.w,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: getUserImageByPath(
                                                      imgProfilePath:
                                                          IMG_PROFILE,
                                                      gender: GENDER_USER),
                                                  fit: BoxFit.cover,
                                              ),
                                                  
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                        show_filter_search_screen(context);
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
                                                    show_filter_search_screen(
                                                        context);
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
                                                              show_filter_search_screen(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              'بحث بالفلتر',
                                                              style: GoogleFonts
                                                                  .almarai(
                                                                      fontSize:
                                                                          12.sp),
                                                            )),
                                                        const Spacer(),
                                                        InkWell(
                                                          onTap: () {
                                                            show_filter_search_screen(
                                                                context);
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
                                        String uristr =
                                            "https://www.snapchat.com/add/zoagge?share_id=lRtrrfi6OZo&locale=ar-AE";
                                        Uri uri = Uri(
                                            scheme: "https",
                                            path:
                                                "www.snapchat.com/add/zoagge?share_id=lRtrrfi6OZo&locale=ar-AE");
                                        // if (await launchUrl(uri, mode: LaunchMode.platformDefault)) {}
                                        if (await launch(uristr)) {
                                        } else {
                                          showToast(
                                              msg: 'Could not launch ${uri}',
                                              state: ToastStates.ERROR);
                                        }
                                      },
                                      child: Container(
                                        height: 80.0,
                                        width: 70.0,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                                AssetImage('assets/snapchat.png'),
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

                      SizedBox(height: 2.5.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: defaultTextFormField(
                            labelTextcolor: PRIMARY,
                            borderColor: PRIMARY,
                            container: BG_DARK_COLOR,
                            onsubmit: (value) {
                              this.searchResult.clear();
                              SearchCubit.get(context).searchText = value??"";
                              SearchCubit.get(context).query.clear();
                              start_searching(context);
                            },
                            suffixPressed: () {
                              this.searchResult.clear();
                              SearchCubit.get(context).searchText = searchTextController.text;
                              SearchCubit.get(context).query.clear();
                              start_searching(context);
                            },
                            onchange: (value) {},
                            context: context,
                            suffix: Icons.search,
                            controller: searchTextController,
                            type: TextInputType.text,
                            validate: (value) {
                              return null;
                            },
                            label: "  البحث   "),
                      ),

                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            RefreshIndicator(
                              key: _refreshIndicatorKey,
                              onRefresh: () => start_searching(context), 
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
                                  itemCount: this.searchResult.length,
                                  itemBuilder: (context, index) => 
                                      Container(
                                        // color: Colors.red,
                                        child: 
                                          UserItemWidget(
                                              showRemoveIcon: false,
                                              removeUser: () {},
                                              onclickUser: () { onClickUserItem(context, index); },
                                              otherUser: this.searchResult[index],
                                          ),
                                      ),
                                )
                            ),

                            ConditionalBuilder(
                              condition: (state is GetSearchLoadingState) || (state is FilterSearchLoadingState),
                              builder: (context) => LoadingGif(),
                              fallback: (context) => Center(
                                child: InkWell(
                                  child: Text("المزيد ... ⬇️",
                                      style: GoogleFonts.almarai(
                                          fontSize: 15.5.sp, color: PRIMARY)),
                                  onTap: () {
                                    // _refreshIndicatorKey.currentState?.show();
                                    start_searching(context);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 3.5.h,
                            ),
                          ])
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }//end build

  void onClickUserItem(BuildContext context, int index) 
  {
      if (IS_LOGIN) {
        UserDetailsCubit.get(context).getOtherUser(
          otherId: this.searchResult[index].id!);
      } else {
        UserDetailsCubit.get(context).getInformationUserByVisitor(
          userId: this.searchResult[index].id!);
      }

      navigateTo(
          context: context,
          widget: UserDetailsScreen( ) 
      );

  }

  void show_filter_search_screen(BuildContext context) {
    navigateTo(
        context: context,
        widget: AdvancedFilterScreen(
          textSearch: searchTextController.text,
        ));
  }

  Future<void> start_searching(BuildContext context) async
  {
    if (SearchCubit.get(context).query.isNotEmpty) {
      SearchCubit.get(context).query["skipPos"] = SearchCubit.get(context).searchResult.length;
      SearchCubit.get(context).searchByFilter();
    }
    else if (searchTextController.text.isNotEmpty) {
      SearchCubit.get(context).searchByText(text: searchTextController.text);
    } else {
      showToast(msg: "من فضلك اكتب اي كلمة بحثية", state: ToastStates.SUCCESS);
    }
  }

}
