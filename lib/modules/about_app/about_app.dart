import 'package:astarar/modules/about_app/cubit/cubit.dart';
import 'package:astarar/modules/about_app/cubit/states.dart';
import 'package:astarar/shared/components/loading_gif.dart';
import 'package:astarar/shared/components/logo/stack_logo.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AboutUsCubit()..aboutUs(),
      child: BlocConsumer<AboutUsCubit, AboutUsStates>(
        listener: (context, state) {},
        builder: (context, state) => Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: white,
              body: ConditionalBuilder(
                fallback: (context)=>const LoadingGif(),
                condition:AboutUsCubit.get(context).getAboutUsDone ,
                builder:(context)=> StackLogo(
            appbarTitle: "عن التطبيق",
            strings: AboutUsCubit.get(context).splittingAboutUs,
          ),
              )),
        ),
      ),
    );
  }
}
