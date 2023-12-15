import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../../modules/ads/cubit/cubit.dart';
import '../../modules/payment/payment_screen.dart';
import '../styles/colors.dart';
import 'components.dart';

class AdsAndPackages extends StatelessWidget 
{
  final List packages;
  final bool isPackages;

  const AdsAndPackages({required this.packages, required this.isPackages});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 1 / 1.5,
        crossAxisCount: 2,
        crossAxisSpacing: 0.0,
        mainAxisSpacing: 1.0,
        children: List.generate(packages.length, (index) {
          return Padding(
            padding:
                EdgeInsetsDirectional.only(top: 6.h, start: 1.h, end: 0.5.h),
            child: Container(
              height: 30.h,
              width: 46.w,
              decoration: BoxDecoration(
                border: Border.all(color: HexColor("ffC4A54C")),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -15.h,
                    left: 12.3.w,
                    child: Container(
                      height: 30.h,
                      width: 22.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffC4A54C),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${packages[index].days} يوم ',
                            style: GoogleFonts.almarai(color: Colors.white, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 0.5.h,),
                          Text('${packages[index].price} ريال',
                              style: GoogleFonts.almarai(color: Colors.white, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: 8.h,
                      child: Container(
                        width: 46.7.w,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Text(
                            isPackages
                                ? packages[index].description??"" 
                                : packages[index].descriptionAr??"" + " , " + packages[index].nameAr??"",
                            textAlign: TextAlign.center,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )),
                  Positioned(
                    bottom: 0,
                    child: 
                    GestureDetector(
                        onTap: () {
                          Subscribe_click(context, index);
                        },
                        child: Container(
                          width: 46.5.w,
                          height: 7.h,
                          color: PRIMARY, 
                          child: Center(
                              child: Text('اشترك',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.almarai(color: WHITE, fontSize: 18.sp),
                          )),
                        )),
                  )
                ],
              ),
            ),
          );
        }));
  }

  void Subscribe_click(BuildContext context, int index) 
  {
    if (isPackages) {
      navigateTo(context: context, 
        widget: PaymentScreen(
          price: packages[index].price,
          serviceType: "package",
          idService: packages[index].id,
        ));
    } else {
      navigateTo(
        context: context, 
        widget: 
          PaymentScreen(
            price: AdsCubit.get(context).ads[index].price,
            serviceType: "Ads",
            idService: AdsCubit.get(context).ads[index].id!,
          )
      );
        
      // AdsCubit.get(context).addAds(
      //     adId: AdsCubit.get(context).ads[index].id!);
    }
  }
}
