import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';
import '../../modules/user_details/cubit/cubit.dart';
import '../../modules/user_details/user_details.dart';

class FavouriteItem extends StatelessWidget 
{
  final String otherId;
  final String name;
  final int gender;
  final Function onClicked;
  final Widget widget;

  const FavouriteItem(
      {Key? key,
      required this.widget,
      required this.otherId,
      required this.name,
      required this.gender,
      required this.onClicked}) : super(key: key);

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
                          .getOtherUser(otherId: this.otherId);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserDetailsScreen( messageVisibility: true,)
                          )
                      );
                  },
                  child:
                    Image(
                      width: 14.w, height: 14.h,
                      image: this.gender == 1? AssetImage(maleImage): AssetImage(femaleImage),
                    ),
                )
                ,
                SizedBox( width: 3.w, ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text( this.name, style: GoogleFonts.almarai(fontSize: 12.sp),
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
