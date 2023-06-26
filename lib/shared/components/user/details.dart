import 'package:astarar/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';
import '../../../models/get_information_user.dart';
import '../../../models/user.dart';
import '../../../modules/chatt/chatt.dart';
import '../../../modules/user_details/cubit/cubit.dart';
import '../../../modules/user_details/cubit/states.dart';
import '../dialog_please_login.dart';
import 'details_item.dart';

class DetailWidget extends StatefulWidget 
{
  final bool messageVisibility;
  final UserDetailsStates state;
  final OtherUserModel other;

  DetailWidget({
    required this.state,
    required this.messageVisibility,
    required this.other
  });

  @override
  State<DetailWidget> createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> 
{
  // DetailWidget({
  @override
  Widget build(BuildContext context) 
  {
    return Column(
      children: [
        
        Padding(
          padding: EdgeInsetsDirectional.only(top: 1.h),
          child: Center(
            child: Container(
              height: 20.h,
              width: 50.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: widget.other.gender == 1 ? AssetImage(maleImage,) : AssetImage(femaleImage),
                  )),
            ),
          ),
        ),

        SizedBox( height: 2.h, ),

        Padding(
          padding: EdgeInsetsDirectional.only(end: 2.w),
          child: Row(
            children: [
              Container(
                width: 35.w,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: 4.w),
                  child:
                      Text(widget.other.userName??"--------", style: GoogleFonts.poppins(fontSize: 12.sp)),
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
            // Container(
            //     width: 28.w,
            //     child: Text('أخر ظهور:3:26',
            //         style: GoogleFonts.poppins(color: Colors.grey[500])),
            // ),
              const Spacer(),

              // ايقونة البلوك
              Visibility(
                visible: widget.other.isBlocked??false,
                child: 
                  ConditionalBuilder(
                    condition: widget.state is BlockHimLoading ,
                    builder:  (context) => CircularProgressIndicator(),
                    fallback: (context)  => 
                      InkWell(
                        onTap: () {  UserDetailsCubit.get(context).unblockHim(userId: widget.other.id??""); },
                        child:  
                          Icon(Icons.block, color: PRIMARY,size: 33,),
                      ),                    
                    ),
              ),

              SizedBox( width: 3.w,),

              // زر اللايك
              Visibility(
                visible: widget.messageVisibility && TYPE_OF_USER==1,
                child: 
                  ConditionalBuilder(
                    condition: widget.state is ToggleFavouriteLoading ,
                    builder:  (context) => CircularProgressIndicator(),
                    fallback: (context)  =>                  
                      InkWell(
                        onTap: () {
                          if(IS_LOGIN==false){
                            showDialog(context: context, builder: (context) => const DialogPleaseLogin());
                            return ;
                          }
                          favourite_on_click(context);
                        },
                        child: Image(
                            height: 3.5.h, 
                            image: (widget.other.isFavorate??false)?
                              const AssetImage("assets/fullFavorite.png")
                              :
                              const AssetImage('assets/Frame 146.png')),
                      ),
                    ),
              ),
              Visibility(
                visible: widget.messageVisibility,
                child: SizedBox( width: 3.w, ),
              ),
              Visibility(
                visible: widget.messageVisibility,
                child: 
                ConditionalBuilder(
                  condition: widget.state is AddHimToMyContactsLoading,
                  builder: (context) => CircularProgressIndicator(),
                  fallback: (context) =>
                    InkWell(
                      onTap: () {
                        if(IS_LOGIN==false){
                          showDialog(context: context, builder: (context) => const DialogPleaseLogin());
                          return;
                        }
                        enter_chatt_screen(context);
                      },
                      child: Image(height: 3.h, image: const AssetImage('assets/chat (7).png')),
                    ),

                  )
                ),

            ],
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              Container(
                  width: 46.w,
                  child: DetailsItem(
                    title: 'العمر', 
                    subTitle: widget.other.age.toString() + "  عام ")),
              Container(
                width: 35.w,
                child: DetailsItem(
                  title: 'المدينة',
                  subTitle: widget.other.city??"--------",
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              Container(
                  width: 46.w,
                  child: DetailsItem(title: 'الجنسية', subTitle: widget.other.nationality??"--------")),
              Container(
                width: 35.w,
                child: DetailsItem(                  
                  title: 'الاسم ينتهي',
                  subTitle: findSubSpecificationOrEmptyStr(SpecificationIDs.name_end_with),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              Container(
                  width: 46.w,
                  child: DetailsItem(title: 'الطول', subTitle: "${widget.other.height} سم")),
              Container(
                width: 35.w,
                child: DetailsItem(title: 'الوزن', subTitle: "${widget.other.weight} ك",
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              Container(
                  width: 46.w,
                  child: DetailsItem(
                    title: 'لون الشعر', 
                    subTitle: findSubSpecificationOrEmptyStr(SpecificationIDs.hair_colour),                  
                    )),
              Container(
                width: 35.w,
                child: DetailsItem(
                  title: 'من عرق',
                  subTitle: findSubSpecificationOrEmptyStr(SpecificationIDs.strain),                  
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              Container(
                  width: 46.w,
                  child: DetailsItem(
                    title: 'مؤهل علمي', 
                    subTitle: findSubSpecificationOrEmptyStr(SpecificationIDs.qualification),
                  )
              ),

              Container(
                width: 35.w,
                child: DetailsItem(
                  title: 'الوظيفة',
                  subTitle: findSubSpecificationOrEmptyStr(SpecificationIDs.job),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              Container(width: 46.w,child: 
                DetailsItem(
                  title: 'الحالة الصحية', 
                  subTitle: findSubSpecificationOrEmptyStr(SpecificationIDs.health_status),
                )
              ),
              Container(
                width: 35.w,
                child: DetailsItem(
                  title: 'الحالة الاجتماعية',
                  subTitle: findSubSpecificationOrEmptyStr(SpecificationIDs.social_status),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              Container(
                width: 46.w,
                child: DetailsItem(
                  title: 'هل لديك اطفال', 
                  subTitle: findSubSpecificationOrEmptyStr(SpecificationIDs.have_children),)
              ),

              Container(
                width: 35.w,
                child: DetailsItem(
                  title: 'نبذة عن مظهرك',
                  subTitle: findSubSpecificationOrEmptyStr(SpecificationIDs.job),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              Container(width: 46.w,child: 
                  DetailsItem(title: 'عاهه جسدية', 
                  subTitle: (widget.other.specialNeeds??false)? "يوجد " : "لا يوجد")),

              Container(
                width: 35.w,
                child: DetailsItem(
                  title: 'الوضع المالي',
                  subTitle: findSubSpecificationOrEmptyStr(SpecificationIDs.financial_situation),

                  
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              Container(
                width: 46.w,
                child: DetailsItem(
                  title: 'نوع الزواج',                   
                  subTitle: findSubSpecificationOrEmptyStr(SpecificationIDs.marriage_Type)                   
                  )),

              Container(width: 46.w,child: DetailsItem(title: 'قيمة المهر', subTitle: widget.other.dowry.toString() )),
            ],
          ),
        ),
        Padding(
          padding:  EdgeInsetsDirectional.only(bottom: 2.h),
          child: Container(
            //height: 9.5.h,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [


                Container(
                  width: 80.w,
                  child: DetailsItem(
                    subTitle: widget.other.terms??"--------",
                    title: 'الشروط',
                  ),
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }

  //-----------------------------------------------
  void favourite_on_click(BuildContext context) 
  {
    if (UserDetailsCubit
          .get(context)
          .getInformationUserModel.otherUser?.isFavorate??false) 
    {
      UserDetailsCubit
        .get(context)
        .deleteFromFavourite(
            userId: UserDetailsCubit.get(context)
                .getInformationUserModel
                .otherUser!
                .id!
        );
    }else 
    {
      UserDetailsCubit
        .get(context)
        .addToFavourite(
          userId: UserDetailsCubit.get(context)
              .getInformationUserModel
              .otherUser!
              .id!
        );
    }
  }
//favourite_on_click
  void enter_chatt_screen(BuildContext context) 
  {
    // حسب طلب صاحب التطبيق ان يتم الدخول على الشات مباشرة بدون طلب
    UserDetailsCubit
      .get(context)
      .addHimToMyContacts(
        userId: UserDetailsCubit.get(context)
            .getInformationUserModel.otherUser!.id!);



    // if(GetInformationCubit.get(context).getInformationUserModel.isInMyContacts!)
    // {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConversationScreen(
              typeUser: 1,
              gender: UserDetailsCubit.get(context)
                  .getInformationUserModel
                  .otherUser!.gender!,
              userId: UserDetailsCubit.get(context)
                    .getInformationUserModel
                    .otherUser!
                    .id!,
              userName: UserDetailsCubit.get(context)
                    .getInformationUserModel
                    .otherUser!
                    .userName!
            ))
      );
    // }else{
    //   GetInformationCubit
    //     .get(context)
    //     .addChattRequest(
    //       userId: GetInformationCubit.get(context)
    //           .getInformationUserModel
    //           .userSubSpecifications!
    //           .id!);
    // }
  }

  findSubSpecificationOrEmptyStr(int specId) 
  {

    var subkeys = SpecificationIDs.getSubSpecificationKeys(specId);
    return widget.other.userSubSpecificationDto
                  .firstWhere(
                    (ss) => subkeys.contains(ss.id),
                            orElse: ( ) => UserSubSpecificationDtoModel(0, "X", "---------") )
                  .value
                  .toString();
  }
}
