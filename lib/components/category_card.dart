import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/size_config.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
    required this.color,
    required this.textColor,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.all(getProportionateScreenHeight(5)),
        padding: EdgeInsets.all(getProportionateScreenWidth(5)),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(13.r),
            border: border0by8lightGray),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  icon,
                  color: DarkPurple,
                  height: 25.h,
                  width: 25.w,
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(3)),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: textColor),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
