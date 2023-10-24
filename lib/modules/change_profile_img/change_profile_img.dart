import 'dart:developer';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../shared/components/components.dart';
import '../home/4_more/more_tab.dart';
import '../home/layout/layout.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ChangeProfileImg extends StatelessWidget 
{
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ChangeProfileImageCubit(),
      child: BlocConsumer<ChangeProfileImageCubit, ChangeProfileImgStates>(
        listener: (context,state){
          if(state is ChangeProfileImageSuccessState)
          {
            // if(state.res.key==1){
            //   showToast(msg: state.res.msg!, state: ToastStates.SUCCESS);
            //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LayoutScreen()), (route) => false);
            // }
            // else{
            //   showToast(msg: state.res.msg!, state: ToastStates.ERROR);
            // }
            showToast(msg: "تم رفع الصورة بنجاح", state: ToastStates.SUCCESS);
          }else if(state is ChangeProfileImageErrorState){
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
                      SizedBox(
                        height: 2.h,
                      ),



                      SizedBox(
                        height: 2.h,
                      ),
                      doubleInfinityMaterialButton(
                        onPressed: () async  
                        {

                          final ImagePicker picker = ImagePicker();

                          // Pick an image.
                          final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                          // log(image?.path??"dd" );
                          ChangeProfileImageCubit.get(context).changeProfileImageFromGallery(image?.path??"5");
                        }, 
                        text: "اختيار صورة من المعرض"
                      ),
                      SizedBox(height: 1.h,),

                      Center(
                        child: 
                          ConditionalBuilder(
                            condition: state is ChangeProfileImageLoadingState,                              
                            builder: (context) => CircularProgressIndicator(),
                            fallback: (context) => Text("", style: TextStyle(color: Colors.yellow),),
                        ),
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
