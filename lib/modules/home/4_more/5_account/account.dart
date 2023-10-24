
import 'package:astarar/shared/components/loading_gif.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as dt;
import 'package:sizer/sizer.dart';

import '../../../../models/user.dart';
import '../../../../shared/components/logo/normal_logo.dart';
import '../../../../shared/styles/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class AccountScreen extends StatelessWidget 
{
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) 
  {
    late User auser = new User();

    return BlocProvider(
      create: (BuildContext context) => AccountCubit()..getUserData(),
      child: BlocConsumer<AccountCubit, AccountStates>(
        listener: (context, state) {
          if (state is AccountInitialState) 
          {
          }else if (state is AccountSuccess) 
          {
            auser = state.current_user;
          }
        },
        builder: (context, state) => Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(11.h),
                  child: NormalLogo(
                    appbarTitle: "حالة الحساب",
                    isBack: true,
                  )),
              body: 
              ConditionalBuilder(
                condition: state is AccountLoading,
                builder: (context) => LoadingGif(),
                fallback: (context) => ListView(
                  children: <Widget>[
                    _infoTile("اسم المستخدم", auser.user_Name??"----"),
                    _infoTile("رقم الهوية", auser.nationalID??"-----"),
                    _infoTile("رقم الجوال", auser.phone??"-----"),
                    _infoTile(
                      "الحساب صالح لغاية", 
                      dt.DateFormat(' a hh:mm  yyyy / MM / dd ').format(auser.ExpiredDate!),
                      color: (auser.IsExpired == true)? Colors.red: BLACK_OPACITY 
                      ),

                    _infoTile(
                      "حالة الحساب", 
                      auser.IsActive == true? "مفتوح" : "مغلق من قبل الإدارة",
                      color: (auser.IsActive == false)? Colors.red: BLACK_OPACITY  
                    ),

                    _infoTile(
                      "حالةالتفعيل", 
                      auser.ActiveCode == true? "مفعل" : "معطل" ,
                      color: (auser.ActiveCode == false)? Colors.red: BLACK_OPACITY
                    ),

                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget _infoTile(String title, String subtitle, {Color color=BLACK_OPACITY}) 
  {
    return ListTile(
      title: Padding(
        padding: const EdgeInsetsDirectional.only(bottom: 5),
        child: Text(
          title,
          style: GoogleFonts.almarai(
              color: BLACK, fontSize: 17.0, fontWeight: FontWeight.w700),
        ),
      ),

      subtitle: Text(subtitle.isEmpty ? '-------' : subtitle,
          style: GoogleFonts.almarai(color: color, fontSize: 14.sp)),
    );
  }
}
