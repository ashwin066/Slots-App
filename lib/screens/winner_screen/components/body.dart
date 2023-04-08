import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce/components/bg_box.dart';
import 'package:shop_ecommerce/components/custom_app_bar.dart';
import 'package:shop_ecommerce/components/default_button.dart';
import 'package:shop_ecommerce/components/footer.dart';
import 'package:shop_ecommerce/components/gradient_button.dart';
import 'package:shop_ecommerce/components/icon_button.dart';
import 'package:shop_ecommerce/components/product_card.dart';
import 'package:shop_ecommerce/components/simmer.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/minimum_product_model.dart';
import 'package:shop_ecommerce/models/user_purchased_slots_model.dart';
import 'package:shop_ecommerce/provider/user_provider.dart';
import 'package:shop_ecommerce/screens/bg_animation/bg_animation.dart';
import 'package:shop_ecommerce/screens/complete_profile/components/body.dart';
import 'package:shop_ecommerce/screens/details/components/top_rounded_container.dart';
import 'package:shop_ecommerce/screens/details/details_screen.dart';
import 'package:shop_ecommerce/screens/slot_selection/components/selection_box.dart';
import 'package:shop_ecommerce/service/get_user_data/get_user_data.dart';
import 'package:shop_ecommerce/size_config.dart';

class Body extends StatefulWidget {
  const Body(
      {super.key,
      required this.product,
      required this.id,
      required this.userPurchased});
  final MinimumProduct product;
  final String id;
  final UserPurchasedSlotsModel userPurchased;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  bool visibility = true;
  String? firstName;
  @override
  void initState() {
    // TODO: implement initState
    getIt() async {
      final firstname1 = await GetUserData().getUserInfoAsString("firstName");

      setState(() {
        firstName = firstname1!;
      });
    }

    getIt();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.product.totalSlots == widget.product.reservedSlots!.length) {
      if (widget.userPurchased.slotNo!.contains(widget.product.winningSlot) &&
          widget.product.totalSlots == widget.product.reservedSlots!.length) {
      } else {
        setState(() {
          visibility = false;
        });
      }
    }

    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: backgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(getProportionateScreenHeight(77.3)),
          child: CustomAppBar(
            viewTicketCount: true,
          ),
        ),
        body: Stack(alignment: Alignment.topCenter,
          children: [
            BgAnimation(
              opacity: visibility ? 0.2 : 0,
              needBgAnimation: widget.userPurchased.slotNo!
                          .contains(widget.product.winningSlot) &&
                      widget.product.totalSlots ==
                          widget.product.reservedSlots!.length
                  ? true
                  : false,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(108),
                    ),
                    if (widget.product.totalSlots ==
                        widget.product.reservedSlots!.length)
                      Column(
                        children: [
                          if (widget.userPurchased.slotNo!
                                  .contains(widget.product.winningSlot) &&
                              widget.product.totalSlots ==
                                  widget.product.reservedSlots!.length)
                            Column(
                              children: [
                                Text(
                                  "Congratulations",
                                  style: text23DarkFw700,
                                ),
                                Text(
                                  "${firstName ?? "Winner"}",
                                  style: text20DarkGreyFw700,
                                ),
                                Text(
                                  "Your slot number ${widget.product.winningSlot ?? ""} have won",
                                  style: text16DarkGrayFw400,
                                ),
                              ],
                            ),
                          // Lottie.network(
                          //     "https://assets1.lottiefiles.com/packages/lf20_4fQThB5Yfz.json",
                          //     fit: BoxFit.cover,
                          //     width: getProportionateScreenHeight(210),
                          //     height: getProportionateScreenHeight(190),
                          //     repeat: true,
                          //     frameRate: FrameRate.max),
                          if (!widget.userPurchased.slotNo!
                                  .contains(widget.product.winningSlot) &&
                              widget.product.totalSlots !=
                                  widget.product.reservedSlots!.length)
                            Text(
                              "Better Luck\nNext Time",
                              style: text20DarkFw700,
                              textAlign: TextAlign.center,
                            ),
                        ],
                      ),
                    if (widget.product.totalSlots !=
                        widget.product.reservedSlots!.length)
                      BgBox(
                        bgColor: transparentBlack,
                        borderRadius: BorderRadius.zero,
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Text(
                                "Best of luck 👍",
                                style: text25DarkFw500,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: SizeConfig.screenHeight! * 0.005),
                              Text(
                                "Winner will be announced once all slots are booked",
                                style: text13DarkGrayFw500,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (widget.product.totalSlots !=
                        widget.product.reservedSlots!.length)
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                    InteractiveViewer(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              margin: paddingMarginAll15,
                              decoration: BoxDecoration(
                                color: aWhite,
                                borderRadius: borderRadius18,
                                // border: border0by8lightGray,
                                boxShadow: [
                                  BoxShadow(
                                    color: DarkPurple.withOpacity(.25),
                                    blurRadius: 15,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              padding: paddingMarginAll15,
                              child: Wrap(
                                children: List.generate(widget.product.totalSlots!,
                                    (index) {
                                  return SelectionBox(
                                    hasWon: widget.product.totalSlots ==
                                            widget.product.reservedSlots!.length
                                        ? index + 1 == widget.product.winningSlot
                                            ? true
                                            : false
                                        : false,
                                    isReserved: widget.product.reservedSlots!
                                            .contains(index + 1)
                                        ? true
                                        : false,
                                    isSelected: widget.userPurchased.slotNo!
                                                .contains(index + 1) ==
                                            false
                                        ? false
                                        : true,
                                    slotNumber: "${index + 1}",
                                  );
                                }),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            BgBox(
                              bgColor: transparentBlack,
                              borderRadius: BorderRadius.zero,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SelectionBox(
                                    isSelected: true,
                                  ),
                                  Text(
                                    "Your slots",
                                    style: text12DarkFw400,
                                  ),
                                  SizedBox(
                                    width: getProportionateScreenHeight(5),
                                  ),
                                  SelectionBox(
                                    isReserved: true,
                                  ),
                                  Text(
                                    "Oponents",
                                    style: text12DarkFw400,
                                  ),
                                  if (widget.product.totalSlots !=
                                      widget.product.reservedSlots!.length)
                                    SizedBox(
                                      width: getProportionateScreenHeight(5),
                                    ),
                                  if (widget.product.totalSlots !=
                                      widget.product.reservedSlots!.length)
                                    SelectionBox(),
                                  if (widget.product.totalSlots !=
                                      widget.product.reservedSlots!.length)
                                    Text(
                                      "Not sold",
                                      style: text12DarkFw400,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            duration: defaultDuration,
                            reverseDuration: defaultDuration,
                            child: DetailsScreen(
                              id: widget.id,
                            )));
                      },
                      child: BgBox(
                        margin: paddingMarginLR15,
                        bgColor: transparentDarkPurple,
                        borderRadius: borderRadius18,
                        padding: paddingMarginAll8,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: SizeConfig.screenWidth! * 0.35,
                                  child: ClipRRect(
                                    borderRadius: borderRadius13,
                                    child: CachedNetworkImage(
                                      imageUrl: widget.product.imageURLs![0],
                                      placeholder: (context, url) => Simmer(
                                        borderRadius: borderRadius13,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionateScreenHeight(10),
                                ),
                                Flexible(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.product.productName!,
                                      style: text13LightFw500,
                                    ),
                                    SizedBox(
                                      height: getProportionateScreenHeight(7),
                                    ),
                                    Text(
                                      "Product worth ₹${widget.product.regularPrice!.toString()}",
                                      style: text15PurpleFw800,
                                    ),
                                    SizedBox(
                                      height: getProportionateScreenHeight(10),
                                    ),
                                    BgBox(
                                      bgColor: MuchLightGray,
                                      borderRadius: borderRadius13,
                                      padding: paddingMarginAll3,
                                      child: Row(
                                        children: [
                                          widget.product.totalSlots ==
                                                  widget
                                                      .product.reservedSlots!.length
                                              ? SelectionBox(
                                                  isBold: true,
                                                  borderRadius: borderRadius10,
                                                  height: 45,
                                                  fontSize: 22,
                                                  slotNumber:
                                                      "${widget.product.winningSlot}",
                                                  isReserved: !widget
                                                      .userPurchased.slotNo!
                                                      .contains(widget
                                                          .product.winningSlot),
                                                  isSelected: widget
                                                      .userPurchased.slotNo!
                                                      .contains(widget
                                                          .product.winningSlot),
                                                )
                                              : IconButtonCustom(
                                                  customMargin: 4,
                                                  color: aWhite,
                                                  icon:
                                                      "assets/icons/arrow_right.svg",
                                                  height: 16,
                                                  width: 16,
                                                  customPadding: 11,
                                                  bgColor: DarkPurple),
                                          SizedBox(
                                            width: getProportionateScreenHeight(5),
                                          ),
                                          Flexible(
                                            child: Text(
                                              widget.product.totalSlots ==
                                                      widget.product.reservedSlots!
                                                          .length
                                                  ? "is the winning slot & ${widget.userPurchased.slotNo!.contains(widget.product.winningSlot) ? "you own it. 🥳" : "you don't own it."}"
                                                  : "Get more slots",
                                              style: text13DarkFw500,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ))
                              ],
                            ),
                            if (widget.userPurchased.slotNo!
                                    .contains(widget.product.winningSlot) &&
                                widget.product.totalSlots ==
                                    widget.product.reservedSlots!.length)
                              Row(
                                children: [
                                  Flexible(
                                    child: Lottie.network(
                                        "https://assets7.lottiefiles.com/packages/lf20_4yFUiEDCvg.json",
                                        fit: BoxFit.contain,alignment:Alignment.bottomRight,
                                        height: getProportionateScreenHeight(150),
                                        width: double.infinity,  
                                        errorBuilder: (context, exception, stackTrace) {
                                      return const Text('');
                                    },
                                        onWarning: (warning) {},
                                        frameRate: FrameRate.max,
                                        repeat: true,
                                      ),
                                  ),SizedBox(width: getProportionateScreenHeight(110),)
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (widget.product.totalSlots ==
                        widget.product.reservedSlots!.length)
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                    if (widget.product.totalSlots ==
                        widget.product.reservedSlots!.length)
                      Container(
                        width: double.infinity,
                        margin: paddingMarginAll15,
                        decoration: BoxDecoration(
                          color: aWhite,
                          borderRadius: borderRadius18,
                          // border: border0by8lightGray,
                          boxShadow: [
                            BoxShadow(
                              color: DarkPurple.withOpacity(.25),
                              blurRadius: 15,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: paddingMarginAll15,
                        child: Text(
                          "${widget.userPurchased.slotNo!.contains(widget.product.winningSlot) && widget.product.totalSlots == widget.product.reservedSlots!.length ? "Hi ${firstName ?? "Winner"}👑, We are happy to inform you that your slot number ${widget.product.winningSlot ?? ""} has won ${widget.product.productName!.characters.take(40)}... \n\nClick on Claim Reward Button\nbelow to claim your reward." : widget.product.totalSlots == widget.product.reservedSlots!.length ? "Don't worry! you may win next time 😊." : ""}",
                          textAlign: TextAlign.center,
                          style: text13DarkGrayFw500,
                        ),
                      ),
                    Footer(height: 150)
                  ],
                ),
              ),
            ),
            if (widget.userPurchased.slotNo!
                    .contains(widget.product.winningSlot) &&
                widget.product.totalSlots ==
                    widget.product.reservedSlots!.length)
            Lottie.asset("assets/lottie/yellow_confetti.json",
                fit: BoxFit.contain,
               
                width: double.infinity,
                errorBuilder: (context, exception, stackTrace) {
              return const Text('');
            },repeat: false,
                onWarning: (warning) {},
                frameRate: FrameRate.max,
                alignment: Alignment.bottomCenter)
          ],
        ),
        bottomSheet:
            widget.userPurchased.slotNo!.contains(widget.product.winningSlot) &&
                    widget.product.totalSlots ==
                        widget.product.reservedSlots!.length
                ? TopRoundedContainer(
                    color: Transparent,
                    child: Padding(
                      padding: paddingMarginAll15,
                      child: GradientButton(
                        bgGradientColor: linearGradient8,
                        text1:
                            "${widget.product.reservedSlots!.contains(widget.product.winningSlot) && widget.product.totalSlots == widget.product.reservedSlots!.length ? "Claim Reward" : "Claim 1 Free ticket"}",
                        text2: "Continue",
                      ),
                    ),
                  )
                : TopRoundedContainer(
                    color: transparentWhite,
                    child: Padding(
                      padding: paddingMarginAll15,
                      child: GradientButton(
                        text_color: aWhite,
                        bgGradientColor: linearGradient8,
                        text1: "Go Back",
                        press: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ));
  }
}
