import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/cart/cart_screen.dart';
import 'package:shop_ecommerce/screens/home/components/icon_btn_with_counter.dart';
import 'package:shop_ecommerce/screens/home/components/search_field.dart';
import 'package:shop_ecommerce/size_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeaderBottom extends StatelessWidget {
  const HomeHeaderBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {}),
      child: Container(
        decoration: BoxDecoration(color: aWhite, gradient: kPrimaryGradientColor
            //  border: Border(
            //     top: BorderSide(width: 13.0, color: SecondaryColor),
            //     //bottom: BorderSide(width: 13.0, color: Success),
            //   ),

            ),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: getProportionateScreenWidth(7.5),
                    right: getProportionateScreenWidth(15),
                    left: getProportionateScreenWidth(15),
                    bottom: getProportionateScreenWidth(9)),
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,

                  // decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //         image: AssetImage('assets/icons/location3d.png'),
                  //         fit: BoxFit.cover,
                  //         alignment: Alignment.centerRight,
                  //         scale: 0.5
                  //         )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 5),
                          //   child: SvgPicture.asset(
                          //     "assets/icons/Location point.svg",
                          //   ),
                          // ),
                          Container(
                              padding: EdgeInsets.only(
                                right: 14,
                              ),
                              decoration: BoxDecoration(
                                  color: PrimaryColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(25),
                                      bottomLeft: Radius.circular(50),
                                      bottomRight: Radius.circular(25))),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: 10,
                                    ),
                                    padding: const EdgeInsets.all(6.0),
                                    decoration: BoxDecoration(
                                        color: DarkGray,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    child: SvgPicture.asset(
                                      "assets/icons/Foundyo_icon.svg",
                                      height: 20.h,
                                      width: 20.w,
                                    ),
                                  ),
                                  Text(
                                    "You are at",
                                    style: TextStyle(
                                      color: aWhite,
                                      fontSize: 19.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "Surathkal, Hosabettu, Mangaluru, Karnataka ...",
                            style: TextStyle(
                              color: aBlack,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SvgPicture.asset(
                            "assets/icons/Down_icon.svg",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
