import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce/components/back_button.dart';
import 'package:shop_ecommerce/components/icon_btn_with_counter.dart';
import 'package:shop_ecommerce/components/simmer.dart';
import 'package:shop_ecommerce/components/simmerContainer.dart';
import 'package:shop_ecommerce/components/ticket_bg.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/tickets.dart';
import 'package:shop_ecommerce/models/user_model.dart';
import 'package:shop_ecommerce/provider/user_provider.dart';
import 'package:shop_ecommerce/screens/main_page/main_page.dart';
import 'package:shop_ecommerce/screens/my_tickets/my_tickets.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/size_config.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    this.child,
    this.viewLogo,
    this.viewTicketCount,
    this.text,
    this.needBackBtn,
  }) : super(key: key);

  final Widget? child;
  final String? text;
  final bool? viewLogo;
  final bool? viewTicketCount;
  final bool? needBackBtn;

  @override
  Widget build(BuildContext context) {
    Tickets? tickets = Provider.of<Tickets?>(context);

    return SafeArea(
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  aWhite,
                  transparentWhite,
                  transparentWhite.withOpacity(.3),
                ],
              ),
            ),
            //margin: EdgeInsets.only(top: getProportionateScreenHeight(10)),
            padding: paddingMarginAll15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (viewLogo == true)
                      Image.asset(
                        "assets/images/foreground_logo.png",
                        height: getProportionateScreenHeight(35),
                      ),
                    if (viewLogo != true)
                      if (needBackBtn != false) BackButtton(),
                    if (needBackBtn != false)
                      if (text != null)
                        SizedBox(
                          width: getProportionateScreenHeight(15),
                        ),
                    if (text != null)
                      Text(
                        text!,
                        style: text18DarkFw500,
                      ),
                  ],
                ),
                if (viewTicketCount == true)
                  if (tickets == null)
                    SizedBox(
                      width: getProportionateScreenHeight(90),
                      child: Simmer(
                        borderRadius: borderRadius10,
                        height: double.infinity,
                      ),
                    ),
                if (tickets != null)
                  if (viewTicketCount == true)
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageTransition(
                            type: PageTransitionType.fade,
                            duration: defaultDuration,
                            reverseDuration: defaultDuration,
                            child: MyTickets(
                              current: 1,
                            )));
                      },
                      child: Container(
                          //  width: getProportionateScreenHeight(90),
                          padding: paddingMarginLR15,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: transparentDarkPurple.withOpacity(.1),
                              borderRadius: borderRadius10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${tickets.ticketCount}",
                                style: text20DarkFw700,
                              ),
                              SizedBox(
                                width: getProportionateScreenHeight(7),
                              ),
                              SvgPicture.asset(
                                "assets/icons/ticket_filled.svg",
                                height: getProportionateScreenHeight(23),
                                width: getProportionateScreenHeight(23),
                                color: DarkPurple,
                              ),
                            ],
                          )),
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
