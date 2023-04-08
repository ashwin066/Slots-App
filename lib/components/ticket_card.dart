import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:shop_ecommerce/components/bg_box.dart';
import 'package:shop_ecommerce/components/icon_button.dart';
import 'package:shop_ecommerce/components/my_progress_bar.dart';
import 'package:shop_ecommerce/components/ticket_bg.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/size_config.dart';

class TicketCard extends StatelessWidget {
  const TicketCard(
      {super.key,
      required this.mainTitle,
      required this.subTitle,
      required this.remainingSlots,
      required this.imageURL,
      required this.slotPrice,
        this.soldOutSlots,   this.totalSlots});

  final String mainTitle;
  final String subTitle;
  final int remainingSlots;
  final String imageURL;
  final int slotPrice;
   final int? soldOutSlots;
  final int? totalSlots;
  @override
  Widget build(BuildContext context) {
    return  BgBox(margin: paddingMarginTLR15,padding: paddingMarginLR20,
          bgColor: MuchDarkPurple,borderRadius: borderRadius18,
          linearGradient: linearGradient5,
          child: Row( 
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   title1,
                    //   style: text10DarkGrayFw400,
                    //   overflow: TextOverflow.fade,
                    //   maxLines: 1,
                    // ),
                    Text(
                      mainTitle,
                      style: text20lightFw500,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(2),
                    ),
                    Text(
                      "Win ${subTitle}",
                      style: text12LightGrayFw400,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(7),
                    ),
                    Text(
                      "ONLY ${remainingSlots} SLOTS REMAINING",
                      style: text9LightGrayFw400,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(5),
                    ),
                    MyProgressBar(progressBarColor: MediumPinkPurple, needText: false, soldOutSlots: soldOutSlots!, centerText: false, totalSlots: totalSlots!),
               
                    SizedBox(
                      height: getProportionateScreenHeight(6),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/ticket_filled.svg",
                              height: getProportionateScreenHeight(21),
                              width: getProportionateScreenHeight(21),
                              color: MediumPinkPurple,
                            ),
                            SizedBox(width: getProportionateScreenHeight(4)),
                            Text(
                              slotPrice.toString(),
                              style: text13LightFw500,
                            ),
                            SizedBox(width: getProportionateScreenHeight(4)),
                            Text(
                              "${slotPrice == 1 ? "Ticket" : "Tickets"}",
                              style: text13LightFw500,
                            ),
                          ],
                        ),
                        IconButtonCustom(
                          icon: "assets/icons/arrow_right.svg",
                          height: 13,
                          width: 13,
                          color: MuchDarkPurple,
                          bgColor: lightDarkPurple,
                          customPadding: 8,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: getProportionateScreenHeight(8),
              ),
              Expanded(
                flex: 4,
                child:  
                   CachedNetworkImage(
                    height: getProportionateScreenHeight(155),
                    width: getProportionateScreenHeight(119),
                        imageUrl: imageURL,fit: BoxFit.contain,
                       
                     
                ),
               
              ),
              
            ],
          ),
        );
  }
}
