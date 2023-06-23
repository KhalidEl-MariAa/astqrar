import 'cubit/cubit.dart';
import 'cubit/states.dart';
import '../../../../shared/components/loading_gif.dart';
import '../../../../shared/components/logo/stack_logo.dart';
import '../../../../shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            backgroundColor: white,
            body: ConditionalBuilder(
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
