import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce/components/bg_box.dart';
import 'package:shop_ecommerce/components/default_button.dart';
import 'package:shop_ecommerce/components/gradient_button.dart';
import 'package:shop_ecommerce/components/icon_button.dart';
import 'package:shop_ecommerce/components/info_bottom_sheet.dart';
import 'package:shop_ecommerce/components/my_progress_bar.dart';
import 'package:shop_ecommerce/components/simmerContainer.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/minimum_product_model.dart';
import 'package:shop_ecommerce/models/tickets.dart';
import 'package:shop_ecommerce/models/user_model.dart';
 import 'package:shop_ecommerce/screens/my_tickets/my_tickets.dart';
import 'package:shop_ecommerce/screens/slot_selection/slot_selection.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/size_config.dart';

FirebaseService _service = FirebaseService();

Iterable<int> get positiveIntegers sync* {
  int i = 1;
  while (true) yield i++;
}

void showBuyTicketBottomSheet(
  context,
  id,
) {
  int quantity = 1;
  int? totalTicketsRequired;
  int? ticketsQuantity = 0;
  double? rupeesRequired;
  Tickets? tickets = Provider.of<Tickets?>(context, listen: false);

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return   
              FirestoreQueryBuilder<MinimumProduct>(
                query: muchMinimumProductQuery(true, id!),
                builder: (context, snapshot, _) {
                  if (snapshot.isFetching) {
                    return Center(child: const CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Text('Something went wrong! ${snapshot.error}');
                  }

                  late MinimumProduct product = snapshot.docs[0].data();


                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    void setPrice() {
                  if (tickets != null)
                      if (totalTicketsRequired == null ||
                          rupeesRequired == null) {
                        setState(() {
                          if (tickets.ticketCount! >= product.slotPrice! * quantity) {
                            ticketsQuantity = 1;
                          }
                          totalTicketsRequired =
                              product.slotPrice! * ticketsQuantity!;
                          rupeesRequired = product.slotPriceInRs!;
                        });
                      } else if (tickets.ticketCount !>=
                          product.slotPrice! * quantity) {
                        setState(() {
                          totalTicketsRequired = product.slotPrice! * quantity;
                        });
                        setState(() {
                          ticketsQuantity = quantity;
                        });
                      }
                  if (tickets != null)
                      if (tickets.ticketCount! <= product.slotPrice! * quantity)
                        setState(() {
                          rupeesRequired = product.slotPriceInRs! *
                              (quantity - ticketsQuantity!);
                        });
                    }

                    setPrice();
                    void incrementQuantity() {
                      if (quantity <=
                          _service.ticketsLeft(product.reservedSlots!.length,
                              product.totalSlots!)) {
                        HapticFeedback.lightImpact();
                        setState(() {
                          quantity++;
                        });
                        setPrice();
                      }
                    }

                    void decrementQuantity() {
                      if (quantity > 1) {
                        HapticFeedback.lightImpact();
                        setState(() {
                          quantity--;
                        });
                        setPrice();
                      }
                    }

                    if (quantity >
                        _service.ticketsLeft(product.reservedSlots!.length,
                            product.totalSlots!)) {
                      setState(
                        () {
                          quantity = _service.ticketsLeft(
                              product.reservedSlots!.length,
                              product.totalSlots!);
                        },
                      );
                      setPrice();
                    }
                    var list = positiveIntegers
                        .skip(product.reservedSlots!.length) // don't use 0
                        .take(quantity) // take 10 numbers
                        .toList();
                    return Container(
                      padding: paddingMarginAll15,
                      height: getProportionateScreenHeight(390),
                      decoration: BoxDecoration(
                        color: aWhite,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BgBox(
                                child: Row(
                                  children: [
                                    Visibility(
                                        child: Container(
                                      width: getProportionateScreenHeight(13),
                                      height: getProportionateScreenHeight(13),
                                      decoration: BoxDecoration(
                                          color:
                                              product.reservedSlots!.length ==
                                                      product.totalSlots
                                                  ? DarkGray
                                                  : TomatoRed,
                                          shape: BoxShape.circle),
                                    )),
                                    SizedBox(
                                      width: getProportionateScreenHeight(5),
                                    ),
                                    Text(
                                      "${product.reservedSlots!.length == product.totalSlots ? "Ended" : "Live"}",
                                      style: text18DarkFw500,
                                    ),
                                  ],
                                ),
                                bgColor: transparentBlack,
                              ),
                              SizedBox(
                                width: getProportionateScreenHeight(120),
                              ),
                              if (product.reservedSlots!.length != null)
                                if (product.totalSlots != null)
                                  Expanded(
                                    child: MyProgressBar(
                                      centerText: true,
                                      soldOutSlots:
                                          product.reservedSlots!.length,
                                      totalSlots: product.totalSlots!,
                                    ),
                                  )
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          product.reservedSlots!.length != product.totalSlots
                              ? Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            "Win ${product.productName}",
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: text20DarkFw500,
                                          ),
                                          SizedBox(
                                            height:
                                                getProportionateScreenHeight(6),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/ticket_filled.svg",
                                                height:
                                                    getProportionateScreenHeight(
                                                        21),
                                                width:
                                                    getProportionateScreenHeight(
                                                        21),
                                                color: transparentDarkPurple,
                                              ),
                                              Text(
                                                " ${product.slotPrice.toString()}",
                                                style: text18DarkFw500,
                                              ),
                                              SizedBox(
                                                  width:
                                                      getProportionateScreenHeight(
                                                          4)),
                                              Text(
                                                "Tickets",
                                                style: text16DarkFw500,
                                              ),
                                              Text(
                                                " / slot",
                                                style: text16DarkGrayFw400,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      4)),
                                          Text(
                                            "Your chances of winning is ${_service.crossMultiplication(100, 1, product.totalSlots!.toDouble(), quantity).toStringAsFixed(1)}% with ${quantity} slot",
                                            style: text15DarkGrayFw400,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButtonCustom(
                                            icon: "assets/icons/minus_icon.svg",
                                            press: () {
                                              decrementQuantity();
                                            },
                                            height:
                                                getProportionateScreenHeight(
                                                    28),
                                            width: getProportionateScreenHeight(
                                                28),
                                            color: DarkPurple,
                                            bgColor: MuchLightGray,
                                          ),
                                          SizedBox(
                                            width: getProportionateScreenHeight(
                                                70),
                                            child: Text(
                                              "${quantity}",
                                              textAlign: TextAlign.center,
                                              style: headingStyle,
                                            ),
                                          ),
                                          IconButtonCustom(
                                            icon: "assets/icons/Plus Icon.svg",
                                            press: () {
                                              incrementQuantity();
                                            },
                                            height:
                                                getProportionateScreenHeight(
                                                    28),
                                            width: getProportionateScreenHeight(
                                                28),
                                            color: DarkPurple,
                                            bgColor: MuchLightGray,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                      if (tickets != null)
                                          Text(
                                            "${tickets.ticketCount! >= product.slotPrice! * quantity ? "" : "Insufficient tickets"}",
                                            style: text13DarkFw500,
                                          ),
                                          SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    10),
                                          ),
                                          DefaultButton(
                                            //  tickets.ticketCount! >=
                                            //  product.slotPrice! *
                                            //   quantity
                                            //             ?
                                            text:
                                                "Get ${quantity} ${quantity == 1 ? "slot" : "slots"}",
                                            button_color: aBlack,
                                            press: () {
                                               if (tickets != null)
                                              Navigator.of(context).push(
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      duration: defaultDuration,
                                                      reverseDuration:
                                                          defaultDuration,
                                                      child: SlotSelection(
                                                        id: id,
                                                        quantity: quantity,
                                                        totalTicketsRequired:
                                                            totalTicketsRequired!,
                                                        rupeesRequired: tickets
                                                                      .ticketCount! <
                                                                product.slotPrice! *
                                                                    quantity
                                                            ? rupeesRequired!
                                                            : 0,
                                                        productTitle:
                                                            product.productName,
                                                      )));
                                            },
                                          ),
                                          SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      10)),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${totalTicketsRequired} tickets ",
                                                style: text15DarkFw800,
                                              ),
                                              SvgPicture.asset(
                                                "assets/icons/ticket_filled.svg",
                                                height:
                                                    getProportionateScreenHeight(
                                                        18),
                                                width:
                                                    getProportionateScreenHeight(
                                                        18),
                                                color: transparentDarkPurple,
                                              ),
                                          if (tickets != null)
                                              if (tickets.ticketCount! <
                                                  product.slotPrice! * quantity)
                                                Text(
                                                  " + ₹${rupeesRequired!.round()}",
                                                  style: text15DarkFw800,
                                                ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              : Expanded(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(),
                                        Column(
                                          children: [
                                            Text(
                                              "Slots are full",
                                              style: headingStyle,
                                            ),
                                            Text(
                                              "Winner will be announced soon",
                                              style: text16DarkGrayFw400,
                                            ),
                                          ],
                                        ),
                                        DefaultButton(
                                            text: "Go Back",
                                            button_color: aBlack,
                                            press: () => Navigator.pop(context))
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    );
                  });
                });
          });
     
}
