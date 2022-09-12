import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_ecommerce/components/category_card.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EarningCard extends StatelessWidget {
  const EarningCard({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> yoCoinsOptions = [
      {
        "icon": "assets/icons/Flash Icon.svg",
        "text": "YoDeals",
        "color": DarkGray,
        "textColor": kTextColor
      },
      {
        "icon": "assets/icons/Gift Icon.svg",
        "text": "Redeem",
        "color": DarkGray,
        "textColor": kTextColor
      },
      {
        "icon": "assets/icons/Game Icon.svg",
        "text": "Game",
        "color": DarkGray,
        "textColor": kTextColor
      },
      {
        "icon": "assets/icons/Heart outline.svg",
        "text": "Earn",
        "color": DarkGray,
        "textColor": kTextColor
      },
    ];
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Container(
          decoration: BoxDecoration(
              color: PrimaryColor,
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/coin_vector_art.png',
                  ),
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomRight,
                  opacity: 0.2)),
          child: Column(
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: press,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "YoCoins Available:",
                          style: TextStyle(
                              color: aWhite,
                              fontWeight: FontWeight.w400,
                              fontSize: 18.sp),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          "300",
                          style: TextStyle(
                              color: aWhite,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 7.h),
                    Row(
                      children: [
                        Text(
                          "Unlocking soon:",
                          style: TextStyle(
                              color: aWhite,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          "150",
                          style: TextStyle(
                              color: aWhite,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...List.generate(
                          yoCoinsOptions.length,
                          (index) => CategoryCard(
                            icon: yoCoinsOptions[index]['icon'],
                            text: yoCoinsOptions[index]['text'],
                            color: yoCoinsOptions[index]['color'],
                            textColor: yoCoinsOptions[index]['textColor'],
                            press: () {},
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
