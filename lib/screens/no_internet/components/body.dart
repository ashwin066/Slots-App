import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce/components/default_button.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/provider/user_provider.dart';
import 'package:shop_ecommerce/screens/home/home_screen.dart';
import 'package:shop_ecommerce/size_config.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
 
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset("assets/lottie/astronaut.json",
                width: SizeConfig.screenWidth! / 1.5, fit: BoxFit.contain),
          ),
          SizedBox(
            height: getProportionateScreenHeight(15),
          ),
          Text(
            "Uh-Oh",
            style: text30DarkFw800,
          ),
          SizedBox(
            height: getProportionateScreenHeight(5),
          ),
          Text(
            "That did not go through, please check your\ninternet connection",
            style: text15DarkGrayFw400,textAlign: TextAlign.center,
          )
        ]);
  }
}
