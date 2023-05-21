import 'package:astarar/modules/ads/cubit/cubit.dart';
import 'package:astarar/modules/ads/cubit/states.dart';
import 'package:astarar/shared/components/components.dart';
import 'package:astarar/shared/components/loading_gif.dart';
import 'package:astarar/shared/components/logo/normal_logo.dart';
import 'package:astarar/shared/components/user/adsAndPackages/adsAndPackages.dart';
import 'package:astarar/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class AdsScreen extends StatelessWidget {
  const AdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdsCubit, AdsStates>(
      listener: (context, state) {
        if(state is AddAdsSuccessState){
          if(state.statusCode==200){
           // showToast(msg: "تمت اضافة اعلانك بنجاح", state: ToastStates.SUCCESS);
            //HomeCubit().getUserAds();
          //  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
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
                condition: AdsCubit.get(context).getAdsDone,
                fallback: (context) => const LoadingGif(),
                builder: (context) => AdsAndPackages(
                    packages: AdsCubit.get(context).getAdsModel.data,
                    isPackages: false))),
      ),
    );
  }
}
