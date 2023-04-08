import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shop_ecommerce/constants.dart';

class FadeIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;
  final Duration duration;

  const FadeIndexedStack({
    Key? key,
    required this.index,
    required this.children,
    this.duration = defaultDuration,
  }) : super(key: key);

  @override
  _FadeIndexedStackState createState() => _FadeIndexedStackState();
}

class _FadeIndexedStackState extends State<FadeIndexedStack>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<Offset>? offsetAnimation;
  @override
  void didUpdateWidget(FadeIndexedStack oldWidget) {
    if (widget.index != oldWidget.index) {
      _controller.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);
    offsetAnimation = Tween<Offset>(begin:Offset(0, .08), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.fastLinearToSlowEaseIn));
    _controller.forward(from: 0.0);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: offsetAnimation!,
        child: Visibility(child: widget.children[widget.index]),
      ),
    );
  }
}
