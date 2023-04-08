import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/size_config.dart';

class BgAnimation extends StatelessWidget {
  const BgAnimation({super.key, required this.child, this.needBgAnimation, this.opacity});
  final Widget child;
  final bool? needBgAnimation;
  final double? opacity;
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topCenter,
      children: [
        if (needBgAnimation != false)
          Opacity(
              opacity: opacity ??  .3,
              child: Lottie.asset("assets/lottie/confetti.json",
                  fit: BoxFit.cover,
                  height: SizeConfig.screenHeight,
                  width: double.infinity,frameRate: FrameRate.max,
                  alignment: Alignment.bottomCenter)),
        child
      ],
    );
  }
}
