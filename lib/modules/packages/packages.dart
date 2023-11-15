import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../shared/components/adsAndPackages.dart';
import '../../shared/components/components.dart';
import '../../shared/components/loading_gif.dart';
import '../../shared/components/logo/normal_logo.dart';
import '../../shared/styles/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class PackagesScreen extends StatelessWidget 
{
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
          backgroundColor: WHITE,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(10.h),
              child: NormalLogo(appbarTitle: "الباقات ",isBack: false),
            ),
            
            body: ConditionalBuilder(
              condition: state is GetPackagesLoadingState,
              builder: (context) => LoadingGif(),
              fallback: (context) => 
                  AdsAndPackages(
                    packages: GetPackagesCubit.get(context).pakages,
                    isPackages: true,
                  )
            )
          ),
      ),
    );
  }
}
