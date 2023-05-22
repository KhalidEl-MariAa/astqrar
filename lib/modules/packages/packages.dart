import 'package:astarar/modules/packages/cubit/cubit.dart';
import 'package:astarar/modules/packages/cubit/states.dart';
import 'package:astarar/shared/components/components.dart';
import 'package:astarar/shared/components/loading_gif.dart';
import 'package:astarar/shared/components/logo/normal_logo.dart';
import 'package:astarar/shared/components/user/adsAndPackages/adsAndPackages.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class PackagesScreen extends StatelessWidget {
  const PackagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetPackagesCubit, GetPackagesStates>(
      listener: (context, state) {
        if(state is AddPackageSuccessState){
          if(state.statusCode==200){
            showToast(msg: "انتظر تاكيد عملية الدفع من الادمن", state:  ToastStates.SUCCESS);
          //  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
          }
          else{
            showToast(msg: "من فضلك حاول لاحقا", state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(10.h),
              child: NormalLogo(appbarTitle: "الباقات ",isBack: false),
            ),
            body: ConditionalBuilder(
              condition: GetPackagesCubit.get(context).getPackagesDone,
              fallback: (context) => LoadingGif(),
              builder: (context) => AdsAndPackages(packages: GetPackagesCubit.get(context).getPackgesModel.data,
                  isPackages: true,
            )
            )),
      ),
    );
  }
}
