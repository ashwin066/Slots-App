import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_ecommerce/constants.dart';

class NavigateButton extends StatelessWidget {
  const NavigateButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
    required this.color,
    this.iconColor,
  }) : super(key: key);

  final String icon;
  final String text;
  final GestureTapCallback press;
  final Color? iconColor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.all(6),
        height: 50.h,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6.0),
              child: SvgPicture.asset(
                icon,
                color: iconColor,
                height: 26.h,
                width: 26.w,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                color: kTextColor,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
