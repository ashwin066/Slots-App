import 'package:flutter/material.dart';
import 'package:shop_ecommerce/size_config.dart';

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.only(
        top: getProportionateScreenWidth(15),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        // borderRadius: const BorderRadius.only(
        //   topLeft: Radius.circular(0),
        //   topRight: Radius.circular(0),
        // ),
      ),
      child: child,
    );
  }
}
