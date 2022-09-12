import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/size_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
          height: 75,
          aspectRatio: 16 / 9,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: false,
          autoPlayInterval: Duration(seconds: 5),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ),
        items: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(12),
              vertical: getProportionateScreenWidth(5),
            ),
            width: double.infinity,
            decoration: BoxDecoration(
                color: SecondaryColor.withOpacity(0.25),
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: AssetImage('assets/images/offer.png'),
                    fit: BoxFit.cover)),
            margin: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(15),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: aWhite,
                border: Border.all(width: 1, color: SecondaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(8),
                vertical: getProportionateScreenWidth(3),
              ),
              child: Text.rich(
                TextSpan(
                  text: "Get 10% off use code:\n",
                  style: TextStyle(
                    color: aBlack,
                    fontSize: 14.sp,
                  ),
                  children: [
                    TextSpan(
                      text: "WELCOME",
                      style: TextStyle(
                        fontSize: 23.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]);
  }
}
