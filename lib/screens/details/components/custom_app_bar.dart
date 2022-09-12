import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_ecommerce/components/back_button.dart';
import 'package:shop_ecommerce/screens/cart/cart_screen.dart';
import 'package:shop_ecommerce/screens/home/components/icon_btn_with_counter.dart';
import 'package:shop_ecommerce/size_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
   }) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        //margin: EdgeInsets.only(top: getProportionateScreenHeight(10)),
          padding: EdgeInsets.all(10), 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BackButtton(),
               
               IconBtnWithCounter(
              svgSrc: "assets/icons/Cart Icon.svg",
              press: () =>    Navigator.of(context).push(PageTransition(
                  type: PageTransitionType.rightToLeftWithFade,
                  duration: Duration(milliseconds: 450),
                  reverseDuration: Duration(milliseconds: 400),
                  child: CartScreen())),
            ),
             
              
            ],
          ),
       
      ),
    );
  }
}
