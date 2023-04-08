import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shop_ecommerce/components/progress_segmented.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/size_config.dart';

class MyProgressBar extends StatelessWidget {
  const MyProgressBar(
      {super.key,
      required this.soldOutSlots,
      required this.centerText,
      required this.totalSlots,
      this.leadingText,
      this.needProgressBar,
      this.needTextLight, this.progressBarColor, this.needText, this.animationColor});

  final int soldOutSlots;
  final Color? animationColor;

  final int totalSlots;
  final bool centerText;
  final bool? needProgressBar;
  final String? leadingText;
  final bool? needTextLight;
  final bool? needText;

  final Color? progressBarColor;
  @override
  Widget build(BuildContext context) {
    FirebaseService _service = FirebaseService();
    String slotsLeft =
        _service.ticketsLeft(soldOutSlots, totalSlots).toString();
    return Column(
      children: [if(needText!=false)
        Row(
          mainAxisAlignment: centerText == true
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            if (leadingText != null)
              Text(
                leadingText!,
                style: text15DarkFw500,
              ),
            if (leadingText != null)
              SizedBox(
                width: getProportionateScreenHeight(5),
              ),
            Text(
              slotsLeft,
              style: text15RedFw500,
            ),
            SizedBox(
              width: getProportionateScreenHeight(5),
            ),
            Text(
              "${slotsLeft == "1" ? "Slot" : "Slots"} Left",
              style:
                  needTextLight != true ? text15DarkFw500 : text15DarkGrayFw400,
            ),
          ],
        ),
        SizedBox(
          height: getProportionateScreenHeight(2),
        ),
        if (needProgressBar != false)
        if(totalSlots<40)
        ProgressBarSegmented(animationColor: animationColor,progressColor: progressBarColor,
            sold: soldOutSlots,
            total: totalSlots,
          ) 
          else
          ClipRRect(
            borderRadius:borderRadius2,
            child: GFProgressBar(
              margin: EdgeInsets.zero,  
              animation: true, 
              progressHeadType:GFProgressHeadType.square,
              backgroundColor: MuchLightGray,
              lineHeight:11,radius: 2,
              percentage:
                  _service.percentageConverter(soldOutSlots, totalSlots),
              //linearGradient: linearGradient4,
              progressBarColor:progressBarColor ?? DarkPurple,
            ),
          ),
        SizedBox(
          height: getProportionateScreenHeight(2),
        ),
      ],
    );
  }
}
