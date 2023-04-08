import 'package:flutter/material.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/size_config.dart';

class BgBox extends StatelessWidget {
  const BgBox(
      {super.key,
      required this.child,
      this.bgColor,
      this.padding,
      this.borderRadius,
      this.margin,   this.linearGradient});

  final Widget child;
  final Color? bgColor;
  final LinearGradient? linearGradient;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
  @override
  Widget build(BuildContext context) {
    return Container( 
        padding: padding != null
            ? padding
            : EdgeInsets.symmetric(
                horizontal: getProportionateScreenHeight(8),
                vertical: getProportionateScreenHeight(2),
              ),
        margin: margin != null ? margin : EdgeInsets.zero,
        decoration: BoxDecoration(
          color: bgColor == null ? aWhite.withOpacity(.20) : bgColor,
          gradient: linearGradient == null ? null : linearGradient,
          borderRadius: borderRadius != null ? borderRadius : borderRadius6,
        ),
        child: child);
  }
}
