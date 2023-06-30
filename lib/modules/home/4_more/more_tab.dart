import 'package:astarar/modules/home/4_more/4_about_version/about_version.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/logo/normal_logo.dart';
import '../../../shared/styles/colors.dart';
import '../../login/login.dart';
import '../../user_profile/user_profile.dart';
import '1_about/about.dart';
import '2_terms/terms.dart';
import '3_contact_us/contact_us.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'widgets/default_raw.dart';
import 'widgets/dialog_remove_acc.dart';

class MoreTab extends StatefulWidget 
{
  static var oldPasswordController = TextEditingController();
  static var confirmPasswordController = TextEditingController();
  static var passwordController = TextEditingController();
  static var form = GlobalKey<FormState>();

  @override
  State<MoreTab> createState() => _MoreTabState();
}

class _MoreTabState extends State<MoreTab> {
  String appVersion = "------";

  @override
  void initState() 
  {
    super.initState();
    PackageInfo.fromPlatform().then((info) 
    {
      setState(() { appVersion = info.version;  });        
    });
  }



  @override
  Widget build(BuildContext context) 
  {
    return BlocConsumer<SettingsCubit, SettingsStates>(
      listener: (context, state) { on_state_changed(context, state); },
      builder: (context, state) => Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(10.h),
              child: NormalLogo(
                appbarTitle: "المزيد",
                isBack: false,
              )),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              children: [
                SizedBox( height: 1.5.h, ),
                if (IS_LOGIN)
                  Container(
                    height: 9.h,
                    decoration: BoxDecoration(
                        color: PRIMARY,
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Row(
                        children: [
                          if (IS_LOGIN)
                            Container(
                              height: 8.h,
                              width: 12.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: GENDER_USER == 1
                                          ? AssetImage(maleImage)
                                          : AssetImage(femaleImage))),
                            ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                NAME ?? "",
                                style: TextStyle(color: WHITE, fontSize: 10.sp),
                              ),
                              SizedBox(
                                height: 1.3.h,
                              ),
                              Text(
                                EMAIL ?? "",
                                style: TextStyle(color: Colors.black87),
                              )
                            ],
                          ),
                          const Spacer(),
                          if (IS_LOGIN)
                            InkWell(
                              onTap: () { SettingsCubit.get(context).logOut(); },
                              child: Text(
                                "تسجيل الخروج",
                                style: TextStyle(
                                    color: WHITE,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),

                SizedBox( height: 2.h, ),

                Material(
                  elevation: 10,
                  shadowColor: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    // height: IS_LOGIN ? 55.h : 45.h,
                    decoration: BoxDecoration(
                        color: WHITE, borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        top: 2.h,
                        start: 8.w,
                        end: 3.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (IS_LOGIN)
                            Text("الاعدادات",
                              style: GoogleFonts.poppins(
                                fontSize: 13.sp, color: Colors.grey[600]
                              ),
                            ),
                          /*   if(isLogin!)         SwitchRaw(
                              image: "assets/notifications-button.png",
                              text: "الاشعارات",
                              value: true),
                          if(isLogin!)        SwitchRaw(
                              image: "assets/man-user.png",
                              text: "صورة الملف الشخصي",
                              value: false),*/
                          if (IS_LOGIN)
                            SizedBox(
                              height: 2.h,
                            ),
                          if (IS_LOGIN)
                            InkWell(
                                child: DefaultRaw(
                                    image: "assets/man-user.png",
                                    text: "الملف الشخصي"),

                                onTap: () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) => UserProfileScreen()
                                  );
                                },
                            ),
                          
                          SizedBox(height: 1.h,),
                          // if (isLogin && typeOfUser == 2)
                          //   InkWell(
                          //       onTap: () {
                          //         if (typeOfUser == 2) {
                          //           Navigator.push(
                          //               context,
                          //               MaterialPageRoute(
                          //                   builder: (context) => UserRegister(delegateId: id) ));
                          //         }
                          //       },
                          //       child: DefaultRaw(
                          //           image: "assets/man-user.png",
                          //           text: "اضافة مستخدم")
                          //   ),
                          
                          SizedBox(height: 1.h,),

                          if (IS_LOGIN)
                            InkWell(
                                onTap: () {
                                  showCupertinoDialog(
                                      context: context,
                                      builder: (context) => DialogRemoveAcc());
                                  // SettingsCubit.get(context)
                                  //     .removeAccount();
                                },
                                child: DefaultRaw(
                                    image: "assets/man-user.png",
                                    text: "حذف الحساب ")
                            ),
                          SizedBox( height: 2.h,),
                          Text( "معلومات",
                            style: GoogleFonts.poppins( fontSize: 13.sp, color: Colors.grey[600]),
                          ),
                          
                          SizedBox( height: 2.h,),
                          InkWell(
                            onTap: () {
                              navigateTo(context: context, widget: const AboutScreen() );
                            },
                            child: DefaultRaw(
                                image: "assets/information.png",
                                text: "عن التطبيق"),
                          ),
                          SizedBox( height: 2.h, ),
                          InkWell(
                            onTap: () {
                              navigateTo( context: context, widget: const TermsScreen() );
                            },
                            child: DefaultRaw(
                                image: "assets/Filled outline.png",
                                text: "الشروط و الاحكام"),
                          ),
                          SizedBox( height: 2.h, ),
                          InkWell(
                            onTap: () {
                              navigateTo( context: context, widget: ContactUS( isFromLogin: false, ) );
                            },
                            child: DefaultRaw(
                                image: "assets/phone.png", text: "اتصل بنا"),
                          ),
                          SizedBox( height: 2.h, ),
                          InkWell(
                              onTap: () {
                                Share.share('https://play.google.com/store/apps/details?id=com.astqrar.com');
                              },
                              child: DefaultRaw(
                                  image: "assets/sharing.png",
                                  text: "مشاركة التطبيق")),

                          SizedBox( height: 2.h, ),
                          InkWell(
                              onTap: () {
                                navigateTo( context: context, widget: AboutVersion( isFromLogin: false, ) );
                              },
                              child: DefaultRaw(
                                  image: "assets/information.png",
                                  text: "عن الإصدار" + " " + appVersion )),
                          
                          SizedBox( height: 2.h, ),

                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  void on_state_changed(BuildContext context, SettingsStates state)
  {
    if (state is LogoutSuccessState) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);
    }

    if (state is RemoveAccountSuccessState) {
      if (state.statusCode == 200) {
        showToast(msg: "تم حذف الحساب!!", state: ToastStates.SUCCESS);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
      } else {
        showToast(msg: "حدث خطا ما", state: ToastStates.ERROR);
      }
    }

  }
}//end class
