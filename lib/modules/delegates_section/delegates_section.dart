import 'package:astarar/modules/delegates_section/cubit/cubit.dart';
import 'package:astarar/modules/delegates_section/cubit/states.dart';
import 'package:astarar/modules/specific_delegate_screen/cubit/cubit.dart';
import 'package:astarar/modules/specific_delegate_screen/specific_Delegate_screen.dart';
import 'package:astarar/shared/components/loading_gif.dart';
import 'package:astarar/shared/components/logo/appbar_name_image.dart';
import 'package:astarar/shared/components/nameWithTitleWithRate.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../shared/styles/colors.dart';

class DelegatesSection extends StatelessWidget {
  const DelegatesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DelegatesCubit, DelegateSectionStates>(
      listener: (context, state) {},
      builder: (context, state) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(12.h),
              child: AppBarWithNameAndImage(),
            ),
            body: ConditionalBuilder(
              condition: DelegatesCubit.get(context).getDelegatesDone,
              fallback: (context) => LoadingGif(),
              builder: (context) => Padding(
                padding: EdgeInsetsDirectional.only(top: 2.h),
                child: ListView.separated(
                    itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          ProfileDeleagateCubit.get(context).getProfileDelegate(
                              delegateId: DelegatesCubit.get(context)
                                  .getAllDelegatesModel
                                  .delegates[index]
                                  .delegate!
                                  .id!);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SpeceficDelegateScreen(
                                      name: DelegatesCubit.get(context)
                                          .getAllDelegatesModel
                                          .delegates[index]
                                          .delegate!
                                          .user_Name!,
                                      id: DelegatesCubit.get(context)
                                          .getAllDelegatesModel
                                          .delegates[index]
                                          .delegate!
                                          .id!)));
                        },
                        child: NameWithTitleWithRATE(
                          userRate: DelegatesCubit.get(context)
                              .getAllDelegatesModel
                              .delegates[index]
                              .rate!
                              .toStringAsFixed(2)
                              .toString(),
                          gender: 2,
                          userName: DelegatesCubit.get(context)
                              .getAllDelegatesModel
                              .delegates[index]
                              .delegate!
                              .user_Name!,
                        )),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 1.h,
                        ),
                    itemCount: DelegatesCubit.get(context)
                        .getAllDelegatesModel
                        .delegates
                        .length),
              ),
            )),
      ),
    );
  }
}
