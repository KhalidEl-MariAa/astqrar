import 'package:astarar/modules/about_app/about_app.dart';
import 'package:astarar/modules/contact_us/contact_us.dart';
import 'package:astarar/modules/login/login.dart';
import 'package:astarar/modules/more/cubit/cubit.dart';
import 'package:astarar/modules/more/cubit/states.dart';
import 'package:astarar/modules/more/widgets/dialog_log_out.dart';
import 'package:astarar/modules/register_user/user_register.dart';
import 'package:astarar/modules/specific_delegate_screen/cubit/cubit.dart';
import 'package:astarar/modules/specific_delegate_screen/specific_Delegate_screen.dart';
import 'package:astarar/modules/terms/terms.dart';
import 'package:astarar/modules/user_profile_screen/user_profile_screen.dart';
import 'package:astarar/modules/more/widgets/default_raw.dart';
import 'package:astarar/shared/components/components.dart';
import 'package:astarar/shared/components/logo/normal_logo.dart';
import 'package:astarar/shared/contants/contants.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

class MoreScreen extends StatelessWidget {
  static var oldPasswordController = TextEditingController();
  static var confirmPasswordController = TextEditingController();
  static var passwordController = TextEditingController();
  static var form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsStates>(
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false);
        }

        if (state is RemoveAccountSuccessState) {
          if (state.statusCode == 200) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false);
          } else {
            showToast(msg: "حدث خطا ما", state: ToastStates.ERROR);
          }
        }
      },
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
                SizedBox(
                  height: 1.5.h,
                ),
                if (isLogin)
                  Container(
                    height: 9.h,
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Row(
                        children: [
                          if (isLogin)
                            Container(
                              height: 8.h,
                              width: 12.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: genderUser == 1
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
                                name ?? "",
                                style: TextStyle(color: white, fontSize: 10.sp),
                              ),
                              SizedBox(
                                height: 1.3.h,
                              ),
                              Text(
                                email ?? "",
                                style: TextStyle(color: Colors.grey[500]),
                              )
                            ],
                          ),
                          const Spacer(),
                          if (isLogin)
                            InkWell(
                              onTap: () {
                                SettingsCubit.get(context).logOut();
                              },
                              child: Text(
                                "تسجيل الخروج",
                                style: TextStyle(
                                    color: white,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                SizedBox(
                  height: 2.h,
                ),
                Material(
                  elevation: 10,
                  shadowColor: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: isLogin ? 55.h : 35.h,
                    decoration: BoxDecoration(
                        color: white, borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        top: 2.h,
                        start: 8.w,
                        end: 3.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isLogin)
                            Text(
                              "الاعدادات",
                              style: GoogleFonts.poppins(
                                  fontSize: 13.sp, color: Colors.grey[600]),
                            ),
                          /*   if(isLogin!)         SwitchRaw(
                              image: "assets/notifications-button.png",
                              text: "الاشعارات",
                              value: true),
                          if(isLogin!)        SwitchRaw(
                              image: "assets/man-user.png",
                              text: "صورة الملف الشخصي",
                              value: false),*/
                          if (isLogin)
                            SizedBox(
                              height: 2.h,
                            ),
                          if (isLogin)
                            InkWell(
                                onTap: () {
                                  if (typeOfUser == 1) {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) =>
                                            UserProfileScreen());
                                  }
                                  if (typeOfUser == 2) {
                                    ProfileDeleagateCubit.get(context)
                                        .getProfileDelegate(delegateId: id!);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SpeceficDelegateScreen(
                                                  id: id!,
                                                  name: name!,
                                                )));
                                  }
                                },
                                child: DefaultRaw(
                                    image: "assets/man-user.png",
                                    text: "الملف الشخصي")),
                          SizedBox(
                            height: 1.h,
                          ),
                          if (isLogin && typeOfUser == 2)
                            InkWell(
                                onTap: () {
                                  if (typeOfUser == 2) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UserRegister(
                                                  delegateId: id,
                                                )));
                                  }
                                },
                                child: DefaultRaw(
                                    image: "assets/man-user.png",
                                    text: "اضافة مستخدم")),
                          SizedBox(
                            height: 1.h,
                          ),
                          if (isLogin)
                            InkWell(
                                onTap: () {
                                  showCupertinoDialog(
                                      context: context,
                                      builder: (context) => DialogLogout());
                                  // SettingsCubit.get(context)
                                  //     .removeAccount();
                                },
                                child: DefaultRaw(
                                    image: "assets/man-user.png",
                                    text: "حذف الحساب ")),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "معلومات",
                            style: GoogleFonts.poppins(
                                fontSize: 13.sp, color: Colors.grey[600]),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          InkWell(
                            onTap: () {
                              navigateTo(
                                  context: context, widget: const AboutApp());
                            },
                            child: DefaultRaw(
                                image: "assets/information.png",
                                text: "عن التطبيق"),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          InkWell(
                            onTap: () {
                              navigateTo(
                                  context: context,
                                  widget: const TermsScreen());
                            },
                            child: DefaultRaw(
                                image: "assets/Filled outline.png",
                                text: "الشروط و الاحكام"),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          InkWell(
                            onTap: () {
                              navigateTo(
                                  context: context,
                                  widget: ContactUS(
                                    isFromLogin: false,
                                  ));
                            },
                            child: DefaultRaw(
                                image: "assets/phone.png", text: "اتصل بنا"),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          InkWell(
                              onTap: () {
                                Share.share(
                                    'https://play.google.com/store/apps/details?id=com.astqrar.com');
                              },
                              child: DefaultRaw(
                                  image: "assets/sharing.png",
                                  text: "مشاركة التطبيق"))
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
}
