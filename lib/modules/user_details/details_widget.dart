
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';
import '../../models/user.dart';
import '../../models/user_other.dart';
import '../../shared/components/components.dart';
import '../../shared/components/dialog_please_login.dart';
import '../../shared/styles/colors.dart';
import '../../utils.dart';
import '../chatt/chatt.dart';
import '../home/layout/cubit/cubit.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'details_item.dart';
import 'image_viewer.dart';

class DetailsWidget extends StatefulWidget 
{
  final bool messageVisibility;
  final UserDetailsStates state;
  final OtherUser otherUser;

  DetailsWidget(
      {required this.state,
      required this.messageVisibility,
      required this.otherUser});

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  // DetailWidget({
  @override
  Widget build(BuildContext context) {
    return Column(
      // padding: EdgeInsetsDirectional.only(top: 1.h),
      children: [

        SizedBox(height: 1.h,),

        if(!widget.otherUser.IsActive!)
          Center(            
            child: Text("غير مشترك",  
                style: GoogleFonts.almarai(color: Colors.red[600], fontSize: 24), )),

        // صورة البروفايل
        Center(
          child: InkWell(
            onTap: () 
            {                  
              ImageProvider img = getUserImage( widget.otherUser, larg: true );

              navigateTo(
                context: context, 
                widget: ImageViewer(theImage: img ) );
            },
            child: 
              Container(
                height: 20.h,                
                // width: 50.w,
                decoration: BoxDecoration(
                    color: WHITE,
                    image: DecorationImage(
                      opacity: widget.otherUser.IsActive! ? 1.0: 0.5,
                      fit: BoxFit.fitHeight,
                      image: getUserImage(widget.otherUser, larg: true) ,                    
                    )),
              ),
          )
        ),

        SizedBox(height: 2.h,),

        // Like, Chat, LastLogin ...etc
        Padding(
          padding: EdgeInsetsDirectional.only(end: 2.w),          
          child: Row(
            children: [
              Container(
                width: 35.w,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: 4.w),
                  child: Text(widget.otherUser.user_Name ?? "--------",
                      style: GoogleFonts.almarai(fontSize: 12.sp)),
                ),
              ),
              SizedBox(
                width: 2.w,
              ),

              Container(
                  // width: 28.w,
                  child: 
                    Center(
                      child: Text(" اخر ظهور " + "\n" + formatTimeAgo(widget.otherUser.LastLogin!),
                        style: GoogleFonts.almarai(color: Colors.grey[700])),
                    ),
              ),
              
              const Spacer(),

              // ايقونة البلوك
              Visibility(
                visible: widget.otherUser.isBlockedByMe,
                child: ConditionalBuilder(
                  condition: widget.state is BlockHimLoading,
                  builder: (context) => CircularProgressIndicator(),
                  fallback: (context) => InkWell(
                    onTap: () {
                      UserDetailsCubit.get(context)
                          .unblockHim(userId: widget.otherUser.id ?? "");
                    },
                    child: Icon(
                      Icons.block,
                      color: PRIMARY,
                      size: 33,
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: 3.w,
              ),

              // زر اللايك
              Visibility(
                visible: widget.messageVisibility ,
                child: ConditionalBuilder(
                  condition: widget.state is ToggleFavouriteLoading,
                  builder: (context) => CircularProgressIndicator(),
                  fallback: (context) => InkWell(
                    onTap: () {
                      if (IS_LOGIN == false) {
                        showDialog(
                            context: context,
                            builder: (context) => const DialogPleaseLogin());
                        return;
                      }
                      favourite_on_click(context);
                    },
                    child: Image(
                        height: 3.5.h,
                        image: (widget.otherUser.isFavorate ?? false)
                            ? const AssetImage("assets/fullFavorite.png")
                            : const AssetImage('assets/Frame 146.png')),
                  ),
                ),
              ),

              // زر الشات
              Visibility(
                visible: widget.messageVisibility,
                child: SizedBox(width: 3.w,),
              ),

              Visibility(
                  visible: widget.messageVisibility,
                  child: ConditionalBuilder(
                    condition: widget.state is AddHimToMyContactsLoading,
                    builder: (context) => CircularProgressIndicator(),
                    fallback: (context) => InkWell(
                      onTap: () {
                        if (IS_LOGIN == false) {
                          showDialog(
                              context: context,
                              builder: (context) => const DialogPleaseLogin());
                          return;
                        }
                        enter_chatt_screen(context);
                      },
                      child: Image(
                          height: 3.h,
                          image: const AssetImage('assets/chat (7).png')),
                    ),
                  )),
              
              SizedBox(width: 2.w,),
            ],
          ),
        ),

        SizedBox(height: 2.h,),

        Container(
          // height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              Container(
                  width: 45.w,
                  child: DetailsItem(
                      title: 'العمر',
                      subTitle: widget.otherUser.age.toString() + "  عام ")
              ),
              Container(
                  width: 45.w,
                  child: DetailsItem(
                    title: 'مؤهل علمي',
                    subTitle: findSubSpecificationOrEmptyStr(
                        SpecificationIDs.qualification),
                  )),
            ],
          ),
        ),
        Container(
          // height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              Container(
                  width: 45.w,
                  child: DetailsItem(
                      title: 'الجنسية',
                      subTitle: LayoutCubit.Countries.firstWhere(
                                  (c) => c.id == widget.otherUser.countryId)
                              .NameAr ??
                          "--------")),
              Container(
                width: 45.w,
                child: DetailsItem(
                  title: 'المدينة',
                  subTitle: widget.otherUser.city ?? "--------",
                ),
              ),
            ],
          ),
        ),

        Container(
          // height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              Container(
                width: 45.w,
                child: DetailsItem(
                  title: 'الاسم ينتهي',
                  subTitle: findSubSpecificationOrEmptyStr(
                      SpecificationIDs.name_end_with),
                ),
              ),
              Container(
                  width: 45.w,
                  child: DetailsItem(
                      title: 'اسم العائلة',
                      subTitle: widget.otherUser.tribe??"--------")
              ),
            ],
          ),
        ),

        Container(
          // height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              Container(
                width: 45.w,
                child: DetailsItem(
                  title: 'الوظيفة',
                  subTitle:
                      findSubSpecificationOrEmptyStr(SpecificationIDs.job),
                ),
              ),
              Container(
                  width: 45.w,
                  child: DetailsItem(
                    title: 'مسمى الوظيفة',
                    subTitle: widget.otherUser.nameOfJob?? "--------",
                  )),

            ],
          ),
        ),


        Container(
          // height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              Container(
                  width: 45.w,
                  child: DetailsItem(
                      title: 'الطول',
                      subTitle: widget.otherUser.height == null
                          ? "------"
                          : "${widget.otherUser.height} سم")),
              Container(
                width: 45.w,
                child: DetailsItem(
                  title: 'الوزن',
                  subTitle: widget.otherUser.weight == null
                      ? "-----"
                      : "${widget.otherUser.weight} ك",
                ),
              ),
            ],
          ),
        ),

        Container(
          // height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              Container(
                  width: 45.w,
                  child: DetailsItem(
                    title: 'الحالة الصحية',
                    subTitle: findSubSpecificationOrEmptyStr(
                        SpecificationIDs.health_status),
                  )),
              Container(
                width: 45.w,
                child: DetailsItem(
                  title: 'نوع المرض',
                  subTitle: widget.otherUser.illnessType??"--------",
                ),
              ),
            ],
          ),
        ),

        Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              Container(
                  width: 45.w,
                  child: DetailsItem(
                    title: 'لون الشعر',
                    subTitle: findSubSpecificationOrEmptyStr(
                        SpecificationIDs.hair_colour),
                  )),
              Container(
                  width: 45.w,
                  child: DetailsItem(
                    title: 'نوع الشعر',
                    subTitle: findSubSpecificationOrEmptyStr(
                        SpecificationIDs.hair_type),
                  )),
            ],
          ),
        ),

        Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              Container(
                width: 45.w,
                child: DetailsItem(
                  title: 'من عرق',
                  subTitle:
                      findSubSpecificationOrEmptyStr(SpecificationIDs.strain),
                ),
              ),
              Container(
                width: 45.w,
                child: DetailsItem(
                  title: 'لون البشرة',
                  subTitle: findSubSpecificationOrEmptyStr(
                      SpecificationIDs.skin_colour),
                ),
              ),
            ],
          ),
        ),



        Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              Container(
                width: 45.w,
                child: DetailsItem(
                  title: 'الحالة الاجتماعية',
                  subTitle: findSubSpecificationOrEmptyStr(
                      SpecificationIDs.social_status),
                ),
              ),
              Container(
                width: 45.w,
                child: DetailsItem(
                  title: 'الوضع المالي',
                  subTitle: findSubSpecificationOrEmptyStr(
                      SpecificationIDs.financial_situation),
                ),
              ),
            ],
          ),
        ),

        Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              Container(
                  width: 45.w,
                  child: DetailsItem(
                    title: 'هل لديك اطفال',
                    subTitle: findSubSpecificationOrEmptyStr(
                        SpecificationIDs.have_children),
                  )),
              Container(
                width: 45.w,
                child: DetailsItem(
                  title: 'عدد الأطفال',
                  subTitle: widget.otherUser.numberOfKids?.toString()??"لا يوجد",
                ),
              ),
            ],
          ),
        ),

        Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              Container(
                  width: 45.w,
                  child: DetailsItem(
                    title: 'التدخين',
                    subTitle: findSubSpecificationOrEmptyStr(
                        SpecificationIDs.smoking),
                  )),
              Container(
                  width: 45.w,
                  child: DetailsItem(
                    title: 'النظرة الشرعية',
                    subTitle: findSubSpecificationOrEmptyStr(
                        SpecificationIDs.have_a_legitimate_view),
                  )),
            ],
          ),
        ),


        Container(
          // height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(            
            children: [
              Container(
                width: 45.w,
                child: DetailsItem(
                  title: 'نبذة عن مظهرك',
                  subTitle:
                      findSubSpecificationOrEmptyStr(SpecificationIDs.appearance),
                ),
              ),

              Container(
                  width: 45.w,
                  child: DetailsItem(
                      title: 'عاهه جسدية',
                      subTitle: (widget.otherUser.specialNeeds ?? false)
                          ? "يوجد "
                          : "لا يوجد")),
            ],
          ),
        ),


        //---------------------------------------------
        
        
        
        //---------------------------------------------


        Container(
          // height: 9.5.h,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              Container(
                  width: 45.w,
                  child: DetailsItem(
                      title: 'نوع الزواج',
                      subTitle: findSubSpecificationOrEmptyStr(
                          SpecificationIDs.marriage_Type))),
              Container(
                  width: 45.w,
                  child: DetailsItem(
                      title: 'قيمة المهر',
                      subTitle: widget.otherUser.dowry.toString())),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(bottom: 2.h),
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
                    subTitle: widget.otherUser.terms ?? "--------",
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
  void favourite_on_click(BuildContext context) {
    if (widget.otherUser.isFavorate ?? false) {
      UserDetailsCubit.get(context)
          .deleteFromFavourite(userId: widget.otherUser.id!);
    } else {
      UserDetailsCubit.get(context)
          .addToFavourite(userId: widget.otherUser.id!);
    }
  }

//favourite_on_click
  void enter_chatt_screen(BuildContext context) {
    // حسب طلب صاحب التطبيق ان يتم الدخول على الشات مباشرة بدون طلب
    UserDetailsCubit.get(context)
        .addHimToMyContacts(hisUserId: widget.otherUser.id!);

    // if(GetInformationCubit.get(context).getInformationUserModel.isInMyContacts!)
    // {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => ConversationScreen(otherUser: widget.otherUser)
      ),
      (route) => true,
      
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

    return widget.otherUser.subSpecifications
        .firstWhere((ss) => subkeys.contains(ss.id),
            orElse: () => SubSpecification(0, "-----", 0, "---------"))
        .value
        .toString();
  }
}
