import '../../models/user.dart';
import 'components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';


import '../../modules/user_details/cubit/cubit.dart';
import '../../modules/user_details/user_details.dart';

class FavouriteItem extends StatelessWidget 
{
  final Widget widget;
  final Function onClicked;
  final User contactor;

  FavouriteItem(
      {Key? key,
      required this.widget,
      required this.onClicked,
      required this.contactor }) : super(key: key);

  @override
  Widget build(BuildContext context) 
  {
    return InkWell(
      onTap: () { this.onClicked(); },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Container(
          height: 11.5.h,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.h),
            child: Row(
              children: [
                InkWell(
                  onTap: (){
                      UserDetailsCubit.get(context)
                          .getOtherUser(otherId: this.contactor.id! );

                      navigateTo(context: context, widget: UserDetailsScreen( messageVisibility: true,));
                  },
                  child:
                    Container(
                      height: 7.h,
                      width: 12.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            opacity: this.contactor.IsExpired??true ? 0.5 : 1.0,
                            image: getUserImageByPath(
                              imgProfilePath: this.contactor.imgProfile??"",
                              gender:  this.contactor.gender??0)
                      )),
                    ),

                ),

                SizedBox( width: 3.w, ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text( this.contactor.user_Name??"-------", 
                        style: GoogleFonts.almarai(fontSize: 12.sp),
                    ),
                    SizedBox( height: 1.h, ),
                  ],
                ),

                const Spacer(),
                
                this.widget,
              ],
            ),
          ),
        ),
      )
    );
  }
}
