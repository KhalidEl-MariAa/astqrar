
import '../../../../constants.dart';
import '../../../../models/user.dart';
import '../../../../shared/components/double_infinity_material_button.dart';
import '../../../../shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../../shared/components/components.dart';
import '../../4_more/more_tab.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ChangeProfileImg extends StatefulWidget 
{
  final User current_user;

  ChangeProfileImg(this.current_user);

  @override
  State<ChangeProfileImg> createState() => _ChangeProfileImgState();
}

class _ChangeProfileImgState extends State<ChangeProfileImg> 
{
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) 
  {
    return BlocProvider(
      create: (BuildContext context) => ChangeProfileImageCubit(),
      child: BlocConsumer<ChangeProfileImageCubit, ChangeProfileImgStates>(
        listener: (context, state){
          if(state is ChangeProfileImageSuccessState)
          {

            setState(() {
              // this.widget.current_user.imgProfile= "/images/Users/e0e720d8a3634614a188a7a9d78dc539.jpg";
              this.widget.current_user.imgProfile = state.updatedUser.imgProfile;
              this.widget.current_user.hideImg = state.updatedUser.hideImg;
              IMG_PROFILE = state.updatedUser.imgProfile;
              // log(state.updatedUser.imgProfile??"XXXX");
              // log("${state.updatedUser.hideImg??true}");
            });

            showToast(msg: "تم رفع الصورة بنجاح", state: ToastStates.SUCCESS);

          }else if( state is SwitchHidingImgSuccessState){
              setState(() {
                this.widget.current_user.hideImg = state.hideImg;
              });
          }
          else if(state is ChangeProfileImageErrorState ){
            showToast(msg: state.error, state: ToastStates.ERROR);
          }else if( state is SwitchHidingImgErrorState){
            showToast(msg: state.error, state: ToastStates.ERROR);
          }
        },
        builder:(context,state)=> Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
            child: Padding(
              padding:
                   EdgeInsetsDirectional.only(start: 4.w, top: 1.h, end: 4.w),
              child: SingleChildScrollView(
                child: Form(
                  key: MoreTab.form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "تغيير الصورة الشخصية",
                        style: GoogleFonts.almarai(fontSize: 12.sp, color: Colors.black),
                      ),
                      
                      SizedBox( height: 2.h, ),

                      SizedBox(height: 2.h, ),

                      doubleInfinityMaterialButton(
                        onPressed: () async  
                        {
                          final ImagePicker picker = ImagePicker();

                          // Pick an image.
                          final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                          ChangeProfileImageCubit.get(context).changeProfileImageFromGallery(image?.path??"");
                          // log(image?.path??"dd" );
                        }, 
                        text: "اختيار صورة من المعرض"
                      ),

                      SizedBox(height: 1.h,),

                      // دائرة التحميل
                      Center(
                        child: 
                          ConditionalBuilder(
                            condition: state is ChangeProfileImageLoadingState,                              
                            builder: (context) => CircularProgressIndicator(),
                            fallback: (context) => Text(""),
                        ),
                      ),

                      // عرض الصورة بعد الرفع
                      Center(
                        child: Container(
                            height: 20.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                image: DecorationImage(
                                  opacity: this.widget.current_user.IsExpired! ? 0.5 : 1.0,
                                  fit: BoxFit.fitWidth,
                                  image: getUserImage(this.widget.current_user) ,                    
                                )),
                          ) 
                        ),

                        SizedBox(height: 1.h,),
                      
                        // زر اخفاء الصورة
                        Row(
                          children: [
                            ConditionalBuilder(
                              condition: state is SwitchHidingImgLodingState, 
                              builder: (context) => CircularProgressIndicator(), 
                              fallback: (context) =>
                                Switch(                          
                                  value: this.widget.current_user.hideImg??true,
                                  activeColor: PRIMARY,
                                  onChanged: (bool value) 
                                  {
                                    ChangeProfileImageCubit
                                      .get(context)
                                      .switchHidingImgProfile(value);
                                  }
                                )
                            ),
                            SizedBox(width: 0.5.w,),
                            Text("إخفاء الصورة",
                              style: GoogleFonts.almarai(fontSize: 13.sp),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
