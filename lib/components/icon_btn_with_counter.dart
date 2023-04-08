import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/size_config.dart';

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key? key,
    this.svgSrc,
    this.numOfItems = 1, //check this later
    required this.press,
    this.image,
    this.btnText,
    this.shape,
    this.iconColor,
    this.bgColor,
    this.ticketCount,
    this.borderRadius,
  }) : super(key: key);

  final String? svgSrc;
  final int numOfItems;
  final GestureTapCallback press;
  final String? image;
  final String? btnText;
  final BoxShape? shape;
  final Color? iconColor;
  final Color? bgColor;
  final Widget? ticketCount;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: borderRadius == null
          ? BorderRadius.circular(getProportionateScreenHeight(50))
          : borderRadius!,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(10)),
            height: getProportionateScreenWidth(46.h),
            // width: getProportionateScreenWidth(46.w),
            decoration: BoxDecoration(
                shape: shape == null ? BoxShape.rectangle : shape!,
                color: bgColor == null ? MuchLightGray : bgColor,
                borderRadius: shape == null
                    ? borderRadius == null
                        ? BorderRadius.circular(
                            getProportionateScreenHeight(50))
                        : borderRadius!
                    : null),
            child: Row(
              children: [
                if (svgSrc != null)
                  SvgPicture.asset(
                    svgSrc!,
                    height: getProportionateScreenHeight(30),
                    width: getProportionateScreenHeight(30),
                    color: iconColor == null ? DarkGray : iconColor,
                  ),
                if (ticketCount != null) ticketCount!,
                if (image != null)
                  Image.asset(
                    image!,
                    height: getProportionateScreenHeight(40),
                  ),
                if (btnText != null)
                  SizedBox(
                    width: getProportionateScreenHeight(8),
                  ),
                if (btnText != null)
                  Text(
                    btnText!,
                    style: text15DarkFw500,
                  ),
              ],
            ),
          ),
          if (numOfItems != 0)
            Positioned(
              top: -3,
              right: 0,
              child: Container(
                height: getProportionateScreenWidth(16.h),
                width: getProportionateScreenWidth(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.5.w,
                    color: Colors.white,
                  ),
                ),
                child: Center(
                  child: Text(
                    "$numOfItems",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(10.sp),
                      height: 1.h,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
