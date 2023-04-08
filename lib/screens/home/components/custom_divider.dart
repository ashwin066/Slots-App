import 'package:flutter/material.dart';
import 'package:shop_ecommerce/components/bg_box.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/size_config.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return  
         Padding(
           padding: paddingMarginAll15,
           child: BgBox(
              padding: EdgeInsets.zero,
              bgColor: MediumPinkPurple,
              child: SizedBox(
                height: getProportionateScreenHeight(1),
                width: SizeConfig.screenWidth! / 3.5,
              )),
         ) ;
  }
}