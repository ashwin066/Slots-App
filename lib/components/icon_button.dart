import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/size_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconButtonCustom extends StatelessWidget {
  const IconButtonCustom({
    Key? key,
    required this.icon,
    required this.press,
    required this.height,
    required this.width,
    required this.color,
  //  required this.bgColor,
  }) : super(key: key);

  final String icon;
  final GestureTapCallback press;
  final double height;
  final double width;
  final Color color;
 // final Color bgColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: PrimaryColor,
          borderRadius: BorderRadius.circular(4)
        ),
        child: SvgPicture.asset(
          icon,
          height: height.h,
          width: width.w,
          color: color,
        ),
      ),
    );
  }
}
