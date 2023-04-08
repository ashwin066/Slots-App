import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_ecommerce/components/simmer.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/size_config.dart';

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    this.borderRadius,
    this.fontSize,
    this.needSubtext,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;
  final double? borderRadius;
  final double? fontSize;
  final bool? needSubtext;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(180.w),
        height: getProportionateScreenWidth(85.h),
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(borderRadius == null ? 0 : borderRadius!),
          child: Container(
            color: PrimaryColor,
            child: Stack(
              alignment: AlignmentDirectional.centerStart,
              children: [
                Container(
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                        colors: [
                          SecondaryColor.withOpacity(.1),
                          SecondaryColor.withOpacity(.4),
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CachedNetworkImage(
                          imageUrl: image,
                          placeholder: (context, url) => Simmer(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: aWhite),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(
                                fontSize == null ? 18.sp : fontSize!.sp),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (needSubtext != false)
                          TextSpan(text: "$numOfBrands Brands"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
