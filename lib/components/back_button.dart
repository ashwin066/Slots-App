import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/enum.dart';
import 'package:shop_ecommerce/screens/home/home_screen.dart';
import 'package:shop_ecommerce/screens/profile/profile_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_ecommerce/size_config.dart';

class BackButtton extends StatelessWidget {
  const BackButtton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      borderRadius: BorderRadius.circular(50).r,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(12)),
            height: getProportionateScreenWidth(46.h),
            width: getProportionateScreenWidth(46.w),
            decoration: BoxDecoration(
              color: aWhite,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              "assets/icons/Back ICon.svg",
              height: 30.h,
              width: 30.w,
              color: LightGray,
            ),
          ),
        ],
      ),
    );
  }
}
