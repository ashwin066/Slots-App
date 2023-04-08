import 'package:flutter/material.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shop_ecommerce/constants.dart';

class SimmerContainer extends StatelessWidget {
  const SimmerContainer(
      {super.key,
      required this.child,
      this.linearGradient,
      this.shimmerEffectCount,
      this.bgColor,
      required this.duration});

  final Widget child;
  final LinearGradient? linearGradient;
  final int? shimmerEffectCount;
  final Color? bgColor;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      child,
      Container(
        decoration:
            BoxDecoration(color: bgColor == null ? Transparent : bgColor),
        child: GFShimmer(
            shimmerEffectCount:
                shimmerEffectCount != null ? shimmerEffectCount! : 0,
            duration: duration,
            showGradient: true,
            gradient: linearGradient != null ? linearGradient : linearGradient5,
            showShimmerEffect: true,
            mainColor: aWhite.withOpacity(1),
            secondaryColor: aWhite.withOpacity(.0),
            child: child),
      ),
    ]);
  }
}
