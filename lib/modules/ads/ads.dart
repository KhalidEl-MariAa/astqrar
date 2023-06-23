import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../shared/components/components.dart';
import '../../shared/components/loading_gif.dart';
import '../../shared/components/logo/normal_logo.dart';
import '../../shared/components/adsAndPackages.dart';
import '../../shared/styles/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class AdsScreen extends StatelessWidget 
{
  const AdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) 
  {
    return BlocConsumer<AdsCubit, AdsStates>(
      listener: (context, state) {
        if(state is AddAdsSuccessState){
          if(state.statusCode==200){
            // showToast(msg: "تمت اضافة اعلانك بنجاح", state: ToastStates.SUCCESS);
            // HomeCubit().getUserAds();
            // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
          }
          else{
            showToast(msg: "حدث خطا ما , يرجي المحاولة", state: ToastStates.ERROR);

          }
        }
      },
      builder: (context, state) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(10.h),
              child: NormalLogo(appbarTitle: "الاعلانات ",isBack: true),
            ),
            body: ConditionalBuilder(
                condition: state is GetAdsLoadingState,
                builder: (context) => const LoadingGif(),
                fallback: (context) => AdsAndPackages(
                    packages: AdsCubit.get(context).getAdsModel.data,
                    isPackages: false))),
      ),
    );
  }
}
