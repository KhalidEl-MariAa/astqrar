import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../shared/components/loading_gif.dart';
import '../../../../shared/components/logo/normal_logo.dart';
import '../../../../shared/components/logo/stack_logo.dart';
import '../../../../shared/styles/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class AboutScreen extends StatelessWidget 
{
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AboutUsCubit()..aboutUs(),
      child: BlocConsumer<AboutUsCubit, AboutUsStates>(
        listener: (context, state) {},
        builder: (context, state) => Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            // appBar: PreferredSize(
            //     preferredSize: Size.fromHeight(11.h),
            //     child: NormalLogo(
            //       appbarTitle: "اصتعراض",
            //       isBack: true,
            //     )),
            
            backgroundColor: WHITE, 
            body: 
              ConditionalBuilder(
                condition: state is AboutUsLoadingState,
                builder: (context)=> const LoadingGif(),
                fallback:(context)=> StackLogo(
                  appbarTitle: "عن التطبيق",
                  strings: AboutUsCubit.get(context).splittingAboutUs,
                ),
              )
            ),
        ),
      ),
    );
  }
}
