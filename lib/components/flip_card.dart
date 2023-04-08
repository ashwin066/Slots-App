import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_ecommerce/constants.dart';

class FlipCardController {
  _FlipCardState? _state;
  Future flipCard() async => _state?.flipCard();
}

class FlipCard extends StatefulWidget {
  const FlipCard(
      {super.key,
      required this.front,
      required this.back,
      required this.controller});
  final Widget front;
  final Widget back;
  final FlipCardController controller;
  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard> with TickerProviderStateMixin {
  late AnimationController controller;

  Future flipCard() async {
    if (controller.isAnimating) return;
    isFront = !isFront;
    await controller.forward(from: 0).then((value) => anglePlus=pi);
  }

  double anglePlus = 0;
  bool isFront = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: defaultDurationLate);
    widget.controller._state = this;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          double angle = controller.value * -pi;
          if (isFront) angle += anglePlus;
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle);
          return Transform(
            transform: transform,
            alignment: Alignment.center,
            child: isFrontImage(angle.abs())
                ? widget.front
                : Transform(
                    transform: Matrix4.identity()..rotateY(pi),
                    alignment: Alignment.center,
                    child: widget.back,
                  ),
          );
        });
  }

  bool isFrontImage(double angle) {
    final degrees90 = pi / 2;
    final degrees270 = 3 * pi / 2;
    return angle <= degrees90 || angle >= degrees270;
  }
}
