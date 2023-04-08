import 'package:flutter/material.dart';
import 'package:shop_ecommerce/components/custom_app_bar.dart';
 import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/all_view/all_view.dart';
import 'package:shop_ecommerce/screens/bg_animation/bg_animation.dart';
import 'package:shop_ecommerce/screens/my_slots/components/body.dart';
import 'package:shop_ecommerce/size_config.dart';

class MySlots extends StatelessWidget {
  const MySlots({super.key});

  static String routeName = "/my_slots";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        child: CustomAppBar(needBackBtn: false,
          viewTicketCount: true,
          text: "My slots",
        ),
        preferredSize: Size.fromHeight(getProportionateScreenHeight(77.3)),
      ),
      body:   AllView(body:  Body()) ,
       
     );
  }
}
