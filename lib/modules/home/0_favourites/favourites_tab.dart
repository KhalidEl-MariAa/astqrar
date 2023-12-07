import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';
import '../../../shared/components/favourite_item.dart';
import '../../../shared/components/logo/normal_logo.dart';
import '../../../shared/styles/colors.dart';
import '../../user_details/cubit/cubit.dart';
import '../../user_details/user_details.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';


class FavouritesTab extends StatelessWidget 
{
  const FavouritesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      FavouritesCubit()
        ..getFavourites(),
      child: BlocConsumer<FavouritesCubit, FavouritesStates>(
        listener: (context, state) {},
        builder: (context, state) =>
            Scaffold(
              backgroundColor: WHITE,
                appBar: PreferredSize(
                    preferredSize: Size.fromHeight(10.h),
                    child: NormalLogo(
                      isBack: false,
                      appbarTitle: "المفضلة",
                    )),
                body: 
                ConditionalBuilder(
                  condition: state is GetFavouritesLoadingState,
                  builder: (context) => const Center(child:Image(image:AssetImage("assets/favourite.gif"))),
                  fallback: (context) =>
                  FavouritesCubit
                      .get(context)
                      .favouriteList.length>0?    Padding(
                        padding: EdgeInsetsDirectional.only(top: 1.h),
                        child: ListView.separated(
                            itemBuilder: (context, index) =>
                                FavouriteItem(
                                    onClicked: () 
                                    {
                                      if(IS_LOGIN){ 
                                        UserDetailsCubit.get(context)
                                            .getOtherUser(
                                            otherId: FavouritesCubit
                                                .get(context)
                                                .favouriteList[index]
                                                .id!);
                                        }else{
                                          UserDetailsCubit.get(context)
                                              .getInformationUserByVisitor(
                                              userId: FavouritesCubit
                                                  .get(context)
                                                  .favouriteList[index]
                                                  .id!);
                                      }
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserDetailsScreen(
                                                    messageVisibility: true,
                                                  )));
                                    },

                                    // زر القلب لالغاء اليوزر من المفلضلة
                                    widget: InkWell(
                                        onTap: () {
                                          FavouritesCubit.get(context)
                                            .deleteFromFavourite(userId: FavouritesCubit.get(context).favouriteList[index].id!);
                                        },
                                        child: 
                                          ConditionalBuilder(
                                            condition: 
                                                state is RemoveFromFavouriteLoadingState && 
                                                FavouritesCubit.get(context).favouriteList[index].id == state.userId,
                                            builder: (context) => CircularProgressIndicator(),
                                            fallback: (context) =>
                                              Icon(
                                                Icons.favorite, 
                                                color: FavouritesCubit.get(context).favouriteList[index].isFavourite? PRIMARY : WHITE,
                                              ),
                                            )
                                    ),
                                    contactor: FavouritesCubit
                                        .get(context)
                                        .favouriteList[index],
                                ),
                            separatorBuilder: (context, index) =>
                                SizedBox(
                                  height: 10,
                                ),
                            itemCount: FavouritesCubit
                                .get(context)
                                .favouriteList
                                .length),
                      )

                  :
                  Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(image:AssetImage("assets/favourite.gif"),
                        height: 12.h,
                        width: 85.w,) ,
                        
                        SizedBox(height: 2.h,),
                        
                        Text("المفضلة فارغة الان ",
                          style: GoogleFonts.almarai(fontSize: 15.sp),)
                      ],
                    ),
                  ),
                )),
      ),
    );
  }
}
