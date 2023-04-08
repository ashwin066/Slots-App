import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_ecommerce/components/bg_box.dart';
import 'package:shop_ecommerce/components/default_button.dart';
import 'package:shop_ecommerce/components/gradient_button.dart';
import 'package:shop_ecommerce/components/icon_button.dart';
import 'package:shop_ecommerce/components/my_progress_bar.dart';
import 'package:shop_ecommerce/components/simmer.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/minimum_product_model.dart';
import 'package:shop_ecommerce/models/user_model.dart';
import 'package:shop_ecommerce/models/user_purchased_slots_model.dart';
import 'package:shop_ecommerce/screens/details/details_screen.dart';
import 'package:shop_ecommerce/screens/winner_screen/winner_screen.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/size_config.dart';

class ProductCard2 extends StatelessWidget {
  const ProductCard2({
    Key? key,
    required this.product,
    required this.user,
    required this.id,
    this.width = 140,
    this.aspectRetion = 1.02,
  }) : super(key: key);
  final double width, aspectRetion;
  final MinimumProduct product;
  final UserPurchasedSlotsModel user;
  final String id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageTransition(
            type: PageTransitionType.fade,
            duration: defaultDuration350,
            reverseDuration: Duration(milliseconds: 250),
            child: product.reservedSlots!.length != product.totalSlots
                ? DetailsScreen(
                    id: id,
                  )
                : WinnerScreen(
                    id: id,
                    userPurchased: user,
                    product: product,
                  )));
      },
      child: Container(
        margin: EdgeInsets.only(top: 22),
        padding: paddingMarginAll15,
        decoration: BoxDecoration(
            color: aWhite,
            boxShadow: [
              BoxShadow(
                color: DarkPurple.withOpacity(.25),
                blurRadius: 15,
                offset: Offset(0, 3),
              ),
            ],
            borderRadius: borderRadius13,
            border: border0by8lightGray),
        child: SizedBox(
          width: getProportionateScreenWidth(double.infinity),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.productName!,
                          style: text16DarkFw500,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: getProportionateScreenHeight(4)),
                        Text(
                          "You bought ${user.slotNo!.length} ${user.slotNo!.length == 1 ? "slot" : "slots"}",
                          style: text13DarkGrayFw500,
                        ),
                        SizedBox(height: getProportionateScreenHeight(18)),
                        if (product.reservedSlots != null)
                          if (product.totalSlots != null)
                            // if (product.reservedSlots!.length !=
                            //     product.totalSlots)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      BgBox(
                                        child: Row(
                                          children: [
                                            Visibility(
                                                child: Container(
                                              width:
                                                  getProportionateScreenHeight(
                                                      13),
                                              height:
                                                  getProportionateScreenHeight(
                                                      13),
                                              decoration: BoxDecoration(
                                                  color: product.reservedSlots!
                                                              .length ==
                                                          product.totalSlots
                                                      ? DarkGray
                                                      : TomatoRed,
                                                  shape: BoxShape.circle),
                                            )),
                                            SizedBox(
                                              width:
                                                  getProportionateScreenHeight(
                                                      5),
                                            ),
                                            Text(
                                              "${product.reservedSlots!.length == product.totalSlots ? "Ended" : "Live"}",
                                              style: text18DarkFw500,
                                            ),
                                          ],
                                        ),
                                        bgColor: transparentBlack,
                                      ),
                                    ],
                                  ),
                                if (product.reservedSlots!.length !=
                                    product.totalSlots)
                                  SizedBox(
                                    width: getProportionateScreenHeight(15),
                                  ),   if (product.reservedSlots!.length !=
                                     product.totalSlots)
                                  Flexible(
                                    child: MyProgressBar(
                                      needTextLight: false,
                                      centerText: false,
                                      soldOutSlots:
                                          product.reservedSlots!.length,
                                      totalSlots: product.totalSlots!,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenHeight(10),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: getProportionateScreenHeight(95),
                      padding: EdgeInsets.all(getProportionateScreenWidth(6)),
                      decoration: BoxDecoration(
                        color: aWhite,
                        borderRadius: borderRadius6,
                      ),
                      child: CachedNetworkImage(
                        height: getProportionateScreenHeight(95),
                        imageUrl: product.imageURLs![0],
                        placeholder: (context, url) => Simmer(
                          borderRadius: borderRadius13,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(6)),
              Divider(
                color: DarkGray,
              ),
              product.reservedSlots!.length == product.totalSlots
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: defaultDuration350,
                                    reverseDuration:
                                        Duration(milliseconds: 250),
                                    child: WinnerScreen(
                                      id: id,
                                      userPurchased: user,
                                      product: product,
                                    )));
                              },
                              child:
                                  Text("View winner", style: text13DarkFw500),
                            ),
                            IconButtonCustom(
                              icon: "assets/icons/arrow_right.svg",
                              height: 13,
                              width: 13,
                              color: aWhite,
                              bgColor: DarkPurple,
                              customPadding: 8,
                            ),
                          ],
                        ),
                        Text("Winner has been announced!",
                            style: text13DarkGrayFw500),
                      ],
                    )
                  : DefaultButton(
                      text: "View Booked Slots",
                      button_color: MuchLightGray,text_color: aBlack,
                      press: () {
                        Navigator.of(context).push(PageTransition(
                            type: PageTransitionType.fade,
                            duration: defaultDuration350,
                            reverseDuration: Duration(milliseconds: 250),
                            child: WinnerScreen(
                              id: id,
                              userPurchased: user,
                              product: product,
                            )));
                      }),

              // GradientButton(text_color:aWhite,
              //   bgGradientColor: linearGradient3,
              //   text2:
              //       "${product.reservedSlots!.length == product.totalSlots ? "View winner  " : "Get more slots   "}",
              //   press: () {
              //     product.reservedSlots!.length == product.totalSlots
              //         ? Navigator.of(context).push(PageTransition(
              //             type: PageTransitionType.rightToLeftWithFade,
              //             duration: Duration(milliseconds: 350),
              //             reverseDuration: Duration(milliseconds: 250),
              //             child: WinnerScreen(
              //               id: id,
              //               userPurchased: user,
              //               product: product,
              //             )))
              //         : Navigator.of(context).push(PageTransition(
              //             type: PageTransitionType.rightToLeftWithFade,
              //             duration: Duration(milliseconds: 350),
              //             reverseDuration: Duration(milliseconds: 250),
              //             child: DetailsScreen(
              //               id: id,
              //             )));
              //   },
              //   child:
              //       SvgPicture.asset(
              //         "assets/icons/arrow_right.svg",
              //         height: getProportionateScreenHeight(14),
              //         width: getProportionateScreenHeight(14),
              //         color: aWhite,
              //       ),

              // ),
              if (product.reservedSlots!.length != product.totalSlots)
                SizedBox(
                  height: getProportionateScreenHeight(6),
                ),
              if (product.reservedSlots!.length != product.totalSlots)
                Text("Winner will be announced once the slots are full.",
                    style: text12DarkGrayFw400),
            ],
          ),
        ),
      ),
    );
  }
}
