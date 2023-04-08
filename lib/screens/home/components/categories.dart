import 'package:flutter/material.dart';
import 'package:shop_ecommerce/components/category_card.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/size_config.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        "icon": "assets/icons/Flash Icon.svg",
        "text": "YoDeals",
      },
      {
        "icon": "assets/icons/Gift Icon.svg",
        "text": "Daily Gift",
      },
      {
        "icon": "assets/icons/Discover.svg",
        "text": "More",
      },
    ];
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(10)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(
                categories.length,
                (index) => Expanded(
                  child: CategoryCard(
                    icon: categories[index]['icon'],
                    text: categories[index]['text'],
                    color: backgroundColor,
                    textColor: aBlack,
                    press: () {},
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
