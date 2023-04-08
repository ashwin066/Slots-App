import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/size_config.dart';

class IconButtonCustom extends StatelessWidget {
  const IconButtonCustom({
    Key? key,
    this.icon,
    this.press,
    required this.height,
    required this.width,
    required this.color,
    required this.bgColor,
    this.customPadding, this.customMargin,
    //  required this.bgColor,
  }) : super(key: key);

  final String? icon;
  final GestureTapCallback? press;
  final double height;
  final double width;
  final Color color;
  final Color bgColor;
  final double? customPadding;
  final double? customMargin;

  // final Color bgColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press != null ? press : null,
      child: Container(
        height: getProportionateScreenHeight(height * 2.3),
        width: getProportionateScreenHeight(width * 2.3),
        padding: customPadding != null
            ? EdgeInsets.all(customPadding!)
            : paddingMarginAll15,margin: customMargin==null? null:EdgeInsets.all(getProportionateScreenHeight(customMargin!)),
        decoration: BoxDecoration(color: bgColor, borderRadius: borderRadius50),
        child: icon != null
            ? SvgPicture.asset(
                icon!,
                height: height.h,
                width: width.w,
                color: color,
              )
            : null,
      ),
    );
  }
}
