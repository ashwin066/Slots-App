import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce/components/bg_box.dart';
import 'package:shop_ecommerce/components/icon_button.dart';
import 'package:shop_ecommerce/components/simmer.dart';
import 'package:shop_ecommerce/components/ticket_bg.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/tickets.dart';
 import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/size_config.dart';

class TicketInfo extends StatelessWidget {
  const TicketInfo({super.key, required this.onClickFlip, required this.typeIsTicketMoreInfo});
  final Function onClickFlip;
  final bool typeIsTicketMoreInfo;
  @override
  Widget build(BuildContext context) {
    Tickets? tickets = Provider.of<Tickets?>(context);

    FirebaseService _service = FirebaseService();
    return Padding(
      padding: paddingMarginAll15,
      child: SizedBox(
          height: getProportionateScreenHeight(160),
          child:
              // CustomPaint(
              //   size: Size(double.infinity,
              //       getProportionateScreenHeight(170)),
              //   painter: TicketBG(DarkPurple),
              // ),
               tickets==null?
              Simmer(
                        height: getProportionateScreenHeight(176),
                      ):Stack( 
                        children: [
                         
                          Container(
                                decoration: BoxDecoration(
                                    gradient: linearGradient5,
                                    color: MuchDarkPurple,
                                    borderRadius: borderRadius18),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          if (tickets.ticketCount != null)
                                            BgBox( 
                                              borderRadius: borderRadius10,
                                              padding: paddingMarginAll8,
                                              child: SizedBox(
                                                width: SizeConfig.screenWidth! / 3,
                                                child:typeIsTicketMoreInfo!=true? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Tickets:",
                                                      style: text16LightGrayFw400,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                      children: [
                                                        SvgPicture.asset(
                                                          "assets/icons/ticket_filled.svg",
                                                          height:
                                                              getProportionateScreenHeight(
                                                                  30),
                                                          width:
                                                              getProportionateScreenHeight(
                                                                  30),
                                                          color: MediumPinkPurple,
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                getProportionateScreenWidth(
                                                                    5)),
                                                        Expanded(
                                                          child:
                                                              SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            child: Text(
                                                              _service
                                                                  .formattedNumber(
                                                                     tickets.ticketCount),
                                                              softWrap: false,
                                                              overflow:
                                                                  TextOverflow.fade,
                                                              style:
                                                                  text23LightFw700,
                                                              textAlign:
                                                                  TextAlign.start,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      "Never Expires",
                                                      style: text12LightGrayFw400,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ): 
                                                 Column(crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Active Slots: 0",
                                                maxLines: 2,
                                                style: text12LightGrayFw400,
                                              ),
                                              SizedBox(
                                                  height: getProportionateScreenWidth(5)),
                                              Text(
                                                "Winning Slots: 0",
                                                maxLines: 2,
                                                style: text12LightGrayFw400,
                                              ),
                                              SizedBox(
                                                  height: getProportionateScreenWidth(5)),
                                              Text(
                                                "Earned Tickets: 0",
                                                maxLines: 2,
                                                style: text12LightGrayFw400,
                                              ),
                                              SizedBox(
                                                  height: getProportionateScreenWidth(5)),
                                              Text(
                                                "Purchased Tickets: 0",
                                                maxLines: 2,
                                                style: text12LightGrayFw400,
                                              ),
                                            ],
                                          ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Center(
                                          child: IconButtonCustom(
                                              customPadding: 10,
                                              press: () {
                                                onClickFlip();
                                              },
                                              icon: "assets/icons/flip.svg",
                                              height:
                                                  getProportionateScreenHeight(22),
                                              width:
                                                  getProportionateScreenHeight(22),
                                              color: aBlack,
                                              bgColor: MediumPinkPurple)),
                                    )
                                  ],
                                ),
                          ),
                          if (tickets.ticketCount != null)
                          if (tickets.ticketCount != 0)
                          if(!typeIsTicketMoreInfo)
                        Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [ 
                            SizedBox(width: getProportionateScreenHeight(33)),
                                Lottie.asset(
                                      "assets/lottie/yellow_confetti.json",
                                      fit: BoxFit.cover,
                                     errorBuilder:
                                          (context, exception, stackTrace) {
                                    return const Text('');
                                  },repeat: false,
                                      onWarning: (warning) {},
                                       width: getProportionateScreenHeight(150),
                                      alignment: Alignment.bottomCenter),
                          ],
                        ),
                        ],
                      )
 
              ),
    );
  }
}
