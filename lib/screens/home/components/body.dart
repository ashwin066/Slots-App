import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shop_ecommerce/components/banner.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/home/components/categories.dart';
import 'package:shop_ecommerce/screens/home/components/discount_banner.dart';
import 'package:shop_ecommerce/screens/home/components/home_header_Bottom.dart';
import 'package:shop_ecommerce/screens/home/components/popular_products.dart';
import 'package:shop_ecommerce/screens/home/components/special_offers.dart';
import 'package:shop_ecommerce/service/controllers/cartController.dart';
import 'package:shop_ecommerce/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final cartcontroll = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: PrimaryColor,
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                     const HomeHeaderBottom(),
                    SizedBox(height: getProportionateScreenWidth(15)),
                    const DiscountBanner(),
                    SizedBox(height: getProportionateScreenWidth(15)),
                    MainBanner(),
                    SizedBox(height: getProportionateScreenWidth(15)),
                    PopularProducts(),
                    SizedBox(height: getProportionateScreenWidth(25)),
                    const Categories(),
                    SizedBox(height: getProportionateScreenWidth(25)),
                    const SpecialOffers(),
                    SizedBox(height: getProportionateScreenWidth(25)),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
