import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/components/logo/stack_logo.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          TermsAndConditionsCubit()..getConditions(),
      child: BlocConsumer<TermsAndConditionsCubit, TermsAndConditionsStates>(
        listener: (context, state) {},
        builder: (context, state) => Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(

              body: StackLogo(
            appbarTitle: "الشروط و الاحكام",
            strings: TermsAndConditionsCubit.get(context).splitting,
          )),
        ),
      ),
    );
  }
}
