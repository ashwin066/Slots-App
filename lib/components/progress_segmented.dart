import 'package:flutter/material.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/size_config.dart';

class ProgressBarSegmented extends StatefulWidget {
  const ProgressBarSegmented(
      {super.key, required this.total, required this.sold, this.progressColor, this.animationColor});
  final int total;
  final int sold;
  final Color? progressColor;
  final Color? animationColor;

  @override
  State<ProgressBarSegmented> createState() => _ProgressBarSegmentedState();
}

class _ProgressBarSegmentedState extends State<ProgressBarSegmented> {
  bool startAnimation = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Row(
          children:
              // ListView.builder(
              //   primary: false,
              //   shrinkWrap: true,
              //   itemCount: widget.total,
              //   itemBuilder: (context, index) {
              //     return Container(child: Text("1"),);
              // Flexible(
              //   child: Container(
              //     margin:
              //         EdgeInsets.only(right: getProportionateScreenHeight(1.6)),
              //     height: getProportionateScreenHeight(11),
              //     decoration: BoxDecoration(
              //         color: index < widget.sold ? DarkPurple : LightGray,
              //         borderRadius: borderRadius2),
              //   ),
              // );
              //   },
              // ),

              List.generate(widget.total, (index) {
            return Flexible(
              child: AnimatedContainer(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: Duration(milliseconds: 300 + (index * 200)),
                transform: Matrix4.translationValues(0,
                    startAnimation ? 0 : getProportionateScreenHeight(10), 0),
                margin:
                    EdgeInsets.only(right: getProportionateScreenHeight(1.6)),
                height: getProportionateScreenHeight(11),
                decoration: BoxDecoration(
                    color: !startAnimation
                        ?widget.animationColor?? MediumPinkPurple
                        : index < widget.sold
                            ?widget.progressColor?? DarkPurple
                            : LightGray ,
                    borderRadius: borderRadius2),
              ),
            );
          }),
        ));
  }
}
