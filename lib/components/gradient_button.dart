import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/size_config.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    Key? key,
    this.press,
    this.height,
    this.width,
      this.bgGradientColor,
    this.customPadding,
    this.text_color,
    this.text1,
    this.text2,
    this.child, this.bgColor,

    //  required this.bgColor,
  }) : super(key: key);
  final Color? bgColor;
  final String? text1;
  final String? text2;
  final GestureTapCallback? press;
  final double? height;
  final double? width;
  final LinearGradient? bgGradientColor;
  final double? customPadding;
  final Color? text_color;
  final Widget? child;
  // final Color bgColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press != null ? press : null,
      child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: height != null
              ? getProportionateScreenHeight(height!)
              : getProportionateScreenHeight(53),
          padding: customPadding != null
              ? EdgeInsets.all(customPadding!)
              : paddingMarginAll15,
          decoration: BoxDecoration(
            borderRadius: borderRadius13,
            gradient: bgGradientColor,
            color: bgColor,
          ),
          child: Row(
            mainAxisAlignment: text2 != null && text1 == null && child != null
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceEvenly,
            children: [
              if (text1 != null)
                Text(
                  text1!,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.bold,
                      color: text_color == null ? aWhite : text_color),
                ),
              if (text2 != null && text1 != null)
                Container(
                  height: double.infinity,
                  width: 2,
                  color: LightGray,
                ),
              if (text2 != null)
                Text(
                  text2!,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      color: text_color == null ? aWhite : text_color),
                ),
              if (child != null) child!
            ],
          )),
    );
  }
}
