import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/size_config.dart';

class BackButtton extends StatelessWidget {
  const BackButtton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HapticFeedbackType.mediumImpact;
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(50).r,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(8)),
            height: getProportionateScreenWidth(46.h),
            width: getProportionateScreenWidth(46.w),
            decoration: BoxDecoration(
              color: aBlack,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              "assets/icons/Back ICon.svg",
              height: 30.h,
              width: 30.w,
              color: aWhite,
            ),
          ),
        ],
      ),
    );
  }
}
