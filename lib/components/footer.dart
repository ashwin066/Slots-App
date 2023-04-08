import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/size_config.dart';

class Footer extends StatelessWidget {
  const Footer({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(
      //     horizontal: getProportionateScreenWidth(20),
      //     vertical: getProportionateScreenHeight(10)),
      // decoration: BoxDecoration(
      //    color: DarkPurple.withOpacity(.05),
      //     image: DecorationImage(
      //         opacity: .05,
      //         fit: BoxFit.cover,
      //         image: AssetImage(
      //           "assets/images/ticket_design.jpg",
      //         ))),
      height: getProportionateScreenHeight(height),
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Column(
      //           children: [
      //             Text(
      //               "Slots",
      //               style: headingStyle,
      //             ),
      //             Text(
      //               "Brand tag line here",
      //               style: text12DarkFw400,
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}
