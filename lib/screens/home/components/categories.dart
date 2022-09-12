import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_ecommerce/components/category_card.dart';
import 'package:shop_ecommerce/components/navigate_button.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/map/map_screen.dart';
import 'package:shop_ecommerce/size_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        "icon": "assets/icons/Flash Icon.svg",
        "text": "YoDeals",
        "color": PrimaryColor,
        "textColor": kTextColor
      },
      {
        "icon": "assets/icons/Bill Icon.svg",
        "text": "Bill",
        "color": PrimaryColor,
        "textColor": kTextColor
      },
      {
        "icon": "assets/icons/Game Icon.svg",
        "text": "Game",
        "color": PrimaryColor,
        "textColor": kTextColor
      },
      {
        "icon": "assets/icons/Gift Icon.svg",
        "text": "Daily Gift",
        "color": PrimaryColor,
        "textColor": kTextColor
      },
      {
        "icon": "assets/icons/Discover.svg",
        "text": "More",
        "color": PrimaryColor,
        "textColor": kTextColor
      },
    ];
    return Container(
      decoration:
          BoxDecoration(color: backgroundColor, gradient: k1GradientColor
              //  border: Border(
              //     top: BorderSide(width: 13.0, color: SecondaryColor),
              //     //bottom: BorderSide(width: 13.0, color: Success),
              //   ),
              ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(15),
            vertical: getProportionateScreenHeight(7)),
        child: Column(
          children: [
            Row(
              children: [
                NavigateButton(
                  color: PrimaryColor,
                  text: "Shop Map",
                  icon: "assets/icons/Location point.svg",
                  press: () {
                    Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.fade,
                        duration: Duration(milliseconds: 400),
                        reverseDuration: Duration(milliseconds: 300),
                        child: MapScreen()));
                  },
                ),
                SizedBox(
                  width: 10.w,
                ),
                NavigateButton(
                  color: PrimaryColor,
                  text: "Pay Bill",
                  icon: "assets/icons/Bill Icon.svg",
                  press: () {},
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  categories.length,
                  (index) => CategoryCard(
                    icon: categories[index]['icon'],
                    text: categories[index]['text'],
                    color: categories[index]['color'],
                    textColor: categories[index]['textColor'],
                    press: () {},
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
