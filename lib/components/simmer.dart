import 'package:flutter/material.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/size_config.dart';

class Simmer extends StatelessWidget {
  const Simmer({
    Key? key,
    this.borderRadius,
    this.verticalMargin,
    this.horizontalMargin,
    this.height,
  }) : super(key: key);

  final BorderRadius? borderRadius;
  final double? verticalMargin;
  final double? horizontalMargin;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GFShimmer(
      showShimmerEffect: true,
      mainColor: MuchLightGray,
      secondaryColor: aWhite,
      child: Container(
        height: height != null ? getProportionateScreenHeight(height!) : 10,
        margin: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(
                horizontalMargin == null ? 0 : horizontalMargin!),
            vertical: getProportionateScreenHeight(
                verticalMargin == null ? 0 : verticalMargin!)),
        decoration: BoxDecoration(
            borderRadius: borderRadius == null ? borderRadius18 : borderRadius,
            color: aWhite),
      ),
    );
  }
}
