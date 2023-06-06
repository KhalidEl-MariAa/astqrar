import '../details_user/cubit/cubit.dart';
import '../details_user/details_user.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import '../../shared/components/favourite_item.dart';
import '../../shared/components/logo/normal_logo.dart';
import '../../shared/contants/contants.dart';
import '../../shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';


class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      GetFavouritesCubit()
        ..getFavourites(),
      child: BlocConsumer<GetFavouritesCubit, GetFavouritesStates>(
        listener: (context, state) {},
        builder: (context, state) =>
            Scaffold(
              backgroundColor: white,
                appBar: PreferredSize(
                    preferredSize: Size.fromHeight(10.h),
                    child: NormalLogo(
                      isBack: false,
                      appbarTitle: "المفضلة",
                    )),
                body: ConditionalBuilder(
                  condition: GetFavouritesCubit
                      .get(context)
                      .getFavouritesDone,
                  fallback: (context) =>
                const   Center(child:Image(image:AssetImage("assets/favourite.gif"))),
                  builder: (context) =>
                  GetFavouritesCubit
                      .get(context)
                      .favouriteList.length>0?    Padding(
                        padding: EdgeInsetsDirectional.only(top: 1.h),
                        child: ListView.separated(
                            itemBuilder: (context, index) =>
                                FavouriteItem(
                                    onClicked: () {
                                     if(isLogin){ GetInformationCubit.get(context)
                                          .getInformationUser(
                                          userId: GetFavouritesCubit
                                              .get(context)
                                              .favouriteList[index]
                                              .id!);}
                                     else{
                                       GetInformationCubit.get(context)
                                           .getInformationUserByVisitor(
                                           userId: GetFavouritesCubit
                                               .get(context)
                                               .favouriteList[index]
                                               .id!);
                                     }
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsUserScreen(
                                                    messageVisibility: true,
                                                  )));
                                    },
                                    name: GetFavouritesCubit
                                        .get(context)
                                        .favouriteList[index]
                                        .username!,
                                    gender: GetFavouritesCubit
                                        .get(context)
                                        .favouriteList[index]
                                        .gender!,
                                    widget: InkWell(
                                        onTap: () {
GetFavouritesCubit.get(context).deleteFromFavourite(userId: GetFavouritesCubit.get(context).favouriteList[index].id!);
                                        },
                                        child: Icon(
                                          Icons.favorite, color: GetFavouritesCubit.get(context).FavouriteMap[GetFavouritesCubit.get(context).favouriteList[index].id]!?primary:white,)
                                    ),
                                ),
                            separatorBuilder: (context, index) =>
                                SizedBox(
                                  height: 10,
                                ),
                            itemCount: GetFavouritesCubit
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
                        Image(image:AssetImage("assets/favourite.gif"),height: 12.h,width: 85.w,) ,
SizedBox(height: 2.h,),
                        Text("المفضلة فارغة الان ",style: GoogleFonts.almarai(
                          fontSize: 15.sp
                        ),)
                      ],
                    ),
                  ),
                )),
      ),
    );
  }
}
