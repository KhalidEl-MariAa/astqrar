import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../shared/styles/colors.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class DialogLogout extends StatelessWidget {
  const DialogLogout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit,SettingsStates>(
      listener: (context,state){},
      builder:(context,state)=> AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        contentPadding: const EdgeInsetsDirectional.only(top: 0),
        actionsPadding: const EdgeInsetsDirectional.only(top: 0),
        actionsOverflowButtonSpacing: 0,
        content: Container(
            decoration: BoxDecoration(
                color: white, borderRadius: BorderRadius.circular(20)),
            height: 22.h,
            width: 80.w,
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsetsDirectional.only(
                        top: 4.5.h, start: 1.w, end: 3.w),
                    child: Center(
                      child: Text("هل انت متاكد من حدف الحساب؟",
                          style: GoogleFonts.almarai(fontSize: 11.sp)),
                    )),
                SizedBox(height: 4.5.h),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        SettingsCubit.get(context).removeAccount();
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(start: 1.w),
                        child: Container(
                          margin: EdgeInsetsDirectional.only(
                              start: 2.w, top: 1.h, bottom: 1.h),
                          height: 6.h,
                          width: 35.w,
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Center(
                            child: Text(
                              'تاكيد الحذف',
                              style: GoogleFonts.almarai(color: white, fontSize: 12.sp),
                              softWrap: false,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(start: 3.w),
                        child: Container(
                          margin: EdgeInsetsDirectional.only(end: 2.w),
                          height: 6.h,
                          width: 35.w,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Center(
                            child: Text(
                              'الغاء',
                              style: GoogleFonts.almarai(
                                  color: Colors.white, fontSize: 12.sp),
                              softWrap: false,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
