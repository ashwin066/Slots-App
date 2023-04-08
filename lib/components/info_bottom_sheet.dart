import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_ecommerce/components/bg_box.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/size_config.dart';

FirebaseService _service = FirebaseService();

Iterable<int> get positiveIntegers sync* {
  int i = 1;
  while (true) yield i++;
}

void showInfoBottomSheet(
  context,
  String mainText,
  String subText,
  dynamic bottom,
) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return  Stack( 
          alignment: Alignment.center,
          children: [Container(
        padding: paddingMarginAll15,
        height: getProportionateScreenHeight(230),width: double.infinity,
        decoration: BoxDecoration(
            // color: MediumPinkPurple,
            color: MuchDarkPurple, 
            borderRadius: borderRadiusLR18,
            image: DecorationImage(
                opacity: .05,
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/ticket_design.jpg",
                ))),
        child:
            Column( 
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BgBox(child: SizedBox(height: getProportionateScreenHeight(2 ),width: getProportionateScreenHeight(68),), ),
                Spacer(),
                Text(
                  mainText,
                  style: text23LightFw700,
                  textAlign: TextAlign.center,
                ),
                Text(
                  subText,
                  style: text16LightGrayFw400,
                  textAlign: TextAlign.center,
                ),
                if (bottom != null)
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                if (bottom != null) bottom,
                 Spacer(),
              ],
            ),
         
      ) ,  Lottie.asset("assets/lottie/yellow_confetti.json",
                fit: BoxFit.cover,
                height: getProportionateScreenHeight(230),
                width: double.infinity,
              errorBuilder: (context, exception, stackTrace) {
            return const Text('');
          },
              onWarning: (warning) {},
                frameRate: FrameRate.max,
                alignment: Alignment.bottomCenter)
          ],
        ) ;
    },
  );
}
