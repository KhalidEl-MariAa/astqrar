import 'package:astarar/modules/chats/cubit/cubit.dart';
import 'package:astarar/modules/chats/cubit/states.dart';
import 'package:astarar/modules/conversation/conversation.dart';
import 'package:astarar/modules/details_clients_delegates/details_clients_delegates.dart';
import 'package:astarar/modules/details_user/cubit/cubit.dart';
import 'package:astarar/modules/details_user/details_user.dart';
import 'package:astarar/modules/specific_delegate_screen/cubit/cubit.dart';
import 'package:astarar/modules/specific_delegate_screen/cubit/states.dart';
import 'package:astarar/shared/components/dialog_to_login.dart';
import 'package:astarar/shared/components/loading_gif.dart';
import 'package:astarar/shared/components/nameWithTitleWithRate.dart';
import 'package:astarar/shared/components/user/user_item.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SpeceficDelegateScreen extends StatelessWidget {
  final String name;
  final String id;

  const SpeceficDelegateScreen({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileDeleagateCubit, ProfileDeleagateStates>(
      listener: (context, state) {},
      builder: (context, state) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(13.h),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/appbarimage.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: typeOfUser == 1 || isLogin == false
                  ? InkWell(
                      onTap: () {
                        if (isLogin) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UserConversationScreen(
                                        gender: 2,
                                        userId: id,
                                        userName: name,
                                        typeUser: 2,
                                      )));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => DialogPleaseLogin());
                        }
                      },
                      child: Container(
                        height: 14.h,
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                              top: 8.h, start: 3.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset("assets/chat (7).png"),
                              SizedBox(
                                width: 3.w,
                              ),
                              Text(
                                "تواصل مع الخطابة",
                                style: GoogleFonts.poppins(
                                    fontSize: 11.sp,
                                    color: primary,
                                    decoration: TextDecoration.underline),
                              ),
                              const Spacer(),
                              /*    Padding(
                              padding: EdgeInsetsDirectional.only(end: 3.w),
                              child: Text(
                                "اخر ظهور :3:26",
                                style: GoogleFonts.poppins(
                                    color: Colors.grey[400], fontSize: 8.sp),
                              ),
                            )*/
                            ],
                          ),
                        ),
                      ),
                    )
                  : AppBar(
                      toolbarHeight: 13.h,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            isLogin! ? name! : "اهلا بك ",
                            style: TextStyle(color: white, fontSize: 11.sp),
                          ),
                          if (isLogin!)
                            Text(
                              age! + " " + "عاما",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: customGrey, fontSize: 11.sp),
                            ),
                        ],
                      ),
                      //   titleSpacing: -10,
                      leadingWidth: 21.5.w,
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
                      actions: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.only(end: 3.w, top: 2.h),
                          child: InkWell(
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
          body: ConditionalBuilder(
            condition: ProfileDeleagateCubit.get(context).getProfile,
            fallback: (context) => LoadingGif(),
            builder: (context) => SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 10.h,
                        width: 18.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(femaleImage))),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: GoogleFonts.poppins(
                                fontSize: 11.sp,
                                color: primary,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            " ",
                            style: GoogleFonts.poppins(fontSize: 9.2.sp),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: ProfileDeleagateCubit.get(context)
                                .clientsDelegate
                                .length >
                            0
                        ? 2.h
                        : 0.h,
                  ),
                  if (ProfileDeleagateCubit.get(context)
                          .clientsDelegate
                          .length >
                      0)
                    GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        childAspectRatio: 1 / 1.2,
                        crossAxisCount: 3,
                        crossAxisSpacing: 0.0,
                        mainAxisSpacing: 12.0,
                        children: List.generate(
                            ProfileDeleagateCubit.get(context)
                                .clientsDelegate
                                .length, (index) {
                          return Center(
                              child: UserItem(
                            visibileRemoveIcon: isLogin ? true : false,
                            removeUser: () {
                              ProfileDeleagateCubit.get(context).removeUser(
                                  userId: ProfileDeleagateCubit.get(context)
                                      .clientsDelegate[index]
                                      .client!
                                      .id!);
                            },
                            onclickUser: () {
                              if (isLogin == true) {
                                GetInformationCubit.get(context)
                                    .getInformationUser(
                                        userId:
                                            ProfileDeleagateCubit.get(context)
                                                .clientsDelegate[index]
                                                .client!
                                                .id!);
                              } else {
                                GetInformationCubit.get(context)
                                    .getInformationUserByVisitor(
                                        userId:
                                            ProfileDeleagateCubit.get(context)
                                                .clientsDelegate[index]
                                                .client!
                                                .id!);
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsUserScreen(
                                            messageVisibility: false,
                                            delegateId: id,
                                            delegateName: name,
                                          )));
                            },
                            genderValue: ProfileDeleagateCubit.get(context)
                                .clientsDelegate[index]
                                .client!
                                .gender!,
                            username: ProfileDeleagateCubit.get(context)
                                .clientsDelegate[index]
                                .client!
                                .user_Name!,
                          ));
                        })),
                  SizedBox(
                    height: 2.h,
                  ),
                  if (ProfileDeleagateCubit.get(context).rates.length > 0)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "التقييمات",
                            style: GoogleFonts.poppins(
                                color: Colors.grey[600], fontSize: 11.5.sp),
                          ),
                          const Spacer(),
                          /*   Text(
                            ">>المزيد",
                            style: GoogleFonts.poppins(
                                color: Colors.grey[600], fontSize: 9.sp),
                          ),*/
                        ],
                      ),
                    ),
                  if (ProfileDeleagateCubit.get(context).rates.length > 0)
                    Padding(
                      padding: EdgeInsetsDirectional.only(top: 2.h),
                      child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                /* Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SpeceficDelegateScreen()));*/
                              },
                              child: NameWithTitleWithRATE(
                                userName: ProfileDeleagateCubit.get(context)
                                    .rates[index]
                                    .client!
                                    .user_Name!,
                                gender: ProfileDeleagateCubit.get(context)
                                    .rates[index]
                                    .client!
                                    .gender!,
                                userRate: ProfileDeleagateCubit.get(context)
                                    .rates[index]
                                    .rate
                                    .toString(),
                              )),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 1.h,
                              ),
                          itemCount: ProfileDeleagateCubit.get(context)
                              .rates
                              .length),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
