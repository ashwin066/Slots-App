import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/size_config.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.symmetric(horizontal: BorderSide(width: .3, color: MuchLightGray), )),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(paddingMarginAll15),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
     )
  )
),
        onPressed: press,
        child: Row(
          children: [
            SizedBox(width: getProportionateScreenHeight(3)),

            SvgPicture.asset(
              icon,
              height: getProportionateScreenHeight(25) ,
              width:  getProportionateScreenHeight(25)  ,
              color: DarkGray,
            ),
            SizedBox(width:  getProportionateScreenHeight(15)),
            Expanded(
              child: Text(
                text,
                style: text15DarkGrayFw400,
              ),
            ),
            SvgPicture.asset(
              "assets/icons/arrow_right.svg",
              color: LightGray,
              height: getProportionateScreenHeight(15),
              width: getProportionateScreenHeight(15),
            ),
            SizedBox(width: getProportionateScreenHeight(3)),

          ],
        ),
      ),
    );
  }
}
