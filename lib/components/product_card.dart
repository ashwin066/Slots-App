import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_ecommerce/constants.dart';
  import 'package:shop_ecommerce/service/controllers/product_controller.dart';
 import 'package:shop_ecommerce/size_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetion = 1.02,
    required this.press,
    required this.index,
  }) : super(key: key);

  final double width, aspectRetion;

  final GestureTapCallback press;
  final int index;
  final ProductController productController = Get.find();
 
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: aWhite,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(width),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: aspectRetion,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(7)),
                  decoration: BoxDecoration(
                    color: aWhite,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Image.network(
                      productController.products[index].images[0]),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "${productController.products[index].product_name.toString()}",
                style: const TextStyle(
                  color: Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Text(
                    "${productController.products[index].rating.toString()}",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: aBlack),
                  ),
                  SizedBox(width: 5.w),
                  SvgPicture.asset(
                    "assets/icons/Star Icon.svg",
                    height: 14.h,
                    width: 14.w,
                    color: Color.fromARGB(255, 255, 196, 0),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "\₹${productController.products[index].current_price.toString()}",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: PrimaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        "${productController.products[index].mrp.toString()}",
                        style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: kTextColor,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                     
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: SvgPicture.asset(
                            
                            "assets/icons/Plus Icon.svg",
                            color: PrimaryColor,
                            height: 12.h,
                            width: 12.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
