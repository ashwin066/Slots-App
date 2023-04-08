import 'package:flutter/material.dart';
import 'package:shop_ecommerce/constants.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.text,
    required this.press,
    this.needSeeMore,
    this.padding,
    this.textCenter, this.makeDark,
  }) : super(key: key);

  final String text;
  final GestureTapCallback press;
  final bool? needSeeMore;
  final EdgeInsets? padding;
  final bool? textCenter;
  final bool? makeDark;
  @override
  Widget build(BuildContext context) {
    return   Container(
      color: makeDark==true?MuchDarkPurple:null,
      child: Padding(
          padding: padding == null ? paddingMarginLR15:padding!,
          child: Row(
            mainAxisAlignment: textCenter == true
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style:makeDark==true?text16LightFw400 :text16DarkFw500,
              ),
              if (needSeeMore == true)
                TextButton(
                  onPressed: press,
                  child: Text(
                    "See More",
                    style: text13DarkGrayFw500,
                  ),
                )
            ],
          ),
         
      ),
    );
  }
}
