import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_ecommerce/components/default_button.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/service/controllers/cart_controller.dart';
import 'package:shop_ecommerce/size_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckOurCard extends StatelessWidget {
    CheckOurCard({
    Key? key,
  }) : super(key: key);
 // final CartController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return  
      Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(15),
          horizontal: getProportionateScreenWidth(15),
        ),
        // height: 174,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -15),
              blurRadius: 20,
              color: const Color(0xFFDAFAFA).withOpacity(0.15),
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: getProportionateScreenWidth(40),
                    width: getProportionateScreenWidth(40),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/receipt.svg",
                      height: 25.h,
                      width: 25.w,
                    ),
                  ),
                  const Spacer(),
                  const Text("Add voucher code"),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: kTextColor,
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      style: TextStyle(fontSize: 14.sp, color: LightGray),
                      children: [
                        TextSpan(
                          text: "₹ l ",
                          style: TextStyle(fontSize: 18.sp, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(190),
                    child: DefaultButton(
                      text: "Check Out",
                      button_color: PrimaryColor,
                      press: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
       
    );
  }
}
