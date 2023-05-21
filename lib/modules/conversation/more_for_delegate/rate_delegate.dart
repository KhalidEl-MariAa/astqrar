

import 'package:astarar/modules/conversation/more_for_delegate/cubit/cubit.dart';
import 'package:astarar/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

import '../../../shared/components/logo/normal_logo.dart';

class RateDelegate extends StatelessWidget {
  final String delegateId;
  const RateDelegate({Key? key,required this.delegateId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   double valueOfRating=0.0;
    return Directionality(
     textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(11.h),
            child: NormalLogo(appbarTitle: "تقييم الخطابة",isBack: true,)
        ),
        body: Column(

            children:[ Center(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(top: 40.0),
                child: RatingBar.builder(
                  initialRating: 0,
                  itemSize: 40,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 6,
                  itemPadding:
                  const EdgeInsets.symmetric(horizontal: 3.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    valueOfRating=rating;
                    print(valueOfRating);
                  },
                ),
              ),
            ),
              const  SizedBox(height: 50.0,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: doubleInfinityMaterialButton(
                    text: "ارسال التقييم",
                    onPressed: () {
                      PaymentDelegateCubit.get(context).addRate(delegateId: delegateId, rate:valueOfRating.toInt());
                    }),
              )
            ]  ),
      ),
    );
  }
}
