import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/cart/cart_screen.dart';
import 'package:shop_ecommerce/screens/home/components/icon_btn_with_counter.dart';
import 'package:shop_ecommerce/screens/home/components/search_field.dart';
import 'package:shop_ecommerce/size_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class HomeHeaderTop extends StatelessWidget {
  const HomeHeaderTop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Expanded(
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          color: PrimaryColor,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SearchField(),
              IconBtnWithCounter(
                svgSrc: "assets/icons/Cart Icon.svg",
                press: () =>  Navigator.of(context).push(PageTransition(
                  type: PageTransitionType.rightToLeftWithFade,
                  duration: Duration(milliseconds: 450),
                  reverseDuration: Duration(milliseconds: 400),
                  child: CartScreen())), 
              ),
              IconBtnWithCounter(
                svgSrc: "assets/icons/Bell.svg",
                numOfItems: 5,
                press: () {},
              ),
            ],
          ),
       
      ),
    );
  }
}
