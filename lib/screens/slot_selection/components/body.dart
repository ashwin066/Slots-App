import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shop_ecommerce/components/custom_app_bar.dart';
import 'package:shop_ecommerce/components/default_button.dart';
import 'package:shop_ecommerce/components/gradient_button.dart';
import 'package:shop_ecommerce/components/my_progress_bar.dart';
import 'package:shop_ecommerce/components/simmer.dart';
import 'package:shop_ecommerce/components/simmerContainer.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/minimum_product_model.dart';
import 'package:shop_ecommerce/models/user_model.dart';
import 'package:shop_ecommerce/provider/temp_selected_slots.dart';
import 'package:shop_ecommerce/provider/user_provider.dart';
import 'package:shop_ecommerce/provider/user_temp_selected_slots_provider.dart';
import 'package:shop_ecommerce/screens/details/components/top_rounded_container.dart';
import 'package:shop_ecommerce/screens/my_tickets/my_tickets.dart';
import 'package:shop_ecommerce/screens/purchase_successful/purchase_successful.dart';
import 'package:shop_ecommerce/screens/slot_selection/components/selection_box.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/service/get_user_data/get_user_data.dart';
import 'package:shop_ecommerce/size_config.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
    required this.id,
    required this.quantity,
    required this.totalTicketsRequired,
    required this.rupeesRequired,
    this.productTitle, required this.email1,
  });
  final String id;
  final String email1;
  final int quantity;
  final int totalTicketsRequired;
  final double rupeesRequired;
  final String? productTitle;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var _razorpay = Razorpay();
  FirebaseService _service = FirebaseService();
  bool validated = false;
  int? winningSlot;

  MinimumProduct? product;
  Future<void> tempReserveSlots() {
    return _service.bookSlot(
        collection: _service.product,
        userTicketCollection: _service.user_temp_selected_slots,
        productID: widget.id,
        reservedSlots: {
          "tempReservedSlots": FieldValue.arrayUnion(
              context.read<TempReservedSlots>().selectedSlots),
        },
        ticketDetails: {
          "tempSlotNo": FieldValue.arrayUnion(
              context.read<TempReservedSlots>().selectedSlots),
          "productId": widget.id,
          "boughtOn": Timestamp.now(),
        });
  }

  Future<bool> clearTempReservedSlots() {
    return _service.bookSlot(
      deleteTempReservedSlotsfromUserCollection: true,
      collection: _service.product,
      userTicketCollection: _service.user_temp_selected_slots,
      productID: widget.id,
      reservedSlots: {
        "tempReservedSlots": FieldValue.arrayRemove(
            context.read<TempReservedSlots>().selectedSlots)
      },
    )
        //.then((value) => context.read<TempReservedSlots>().selectedSlots.clear())
        .then((value) => true);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    removeTicketsFromDB();
    clearTempReservedSlots();
    context.read<TempReservedSlots>().selectedSlots.clear();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    clearTempReservedSlots();

    EasyLoading.showError("Payment Failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
  String firstname1 = "";
  String lastname1 = "";
  
  @override
  void initState() {
    // TODO: implement initState
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    super.initState();
    getIt() async {
 
      final firstname = await GetUserData().getUserInfoAsString("firstName");
      final lastname = await GetUserData().getUserInfoAsString("lastName");
     

      setState(() {
        firstname1 = firstname!;
      });
      setState(() {
        lastname1 = lastname!;
      });
    
    }
  }

  Future<void> removeTicketsFromDB() {
    return _service
        .bookSlot(
            collection: _service.product,
            userTicketCollection: _service.user_purchased_slots,
            productID: widget.id,
            reservedSlots: {
              "reservedSlots": FieldValue.arrayUnion(
                  context.read<TempReservedSlots>().selectedSlots),
              if (context
                  .read<TempReservedSlots>()
                  .selectedSlots
                  .contains(winningSlot))
                "winnerUid": _service.user!.uid,
            },
            ticketDetails: {
              "slotNo": FieldValue.arrayUnion(
                  context.read<TempReservedSlots>().selectedSlots),
              "productId": widget.id,
              "boughtOn": Timestamp.now(),
            })
        .then((value) {
          if (widget.totalTicketsRequired > 0)
            _service.addRemoveTickets(ticketData: {
              "tickets": FieldValue.increment(-widget.totalTicketsRequired)
            });
        })
        .then((value) => _service.showLocalNotification(
            "Slot${widget.quantity == 1 ? "" : "s"} booked successfully 😃",
            "Best of luck 👍"))
        .then((value) {
           Navigator.pop(context);
          Navigator.of(context).pushReplacement(PageTransition(
              type: PageTransitionType.fade,
              duration: defaultDuration,
              reverseDuration: defaultDuration,
              child: PurchaseSuccessful()));
         });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserTempSelectedSlotsProvider>(context)
        .getUserTempSelectedSlotsProviderData(widget.id);
    
    var options = {
      'key': 'rzp_test_9Fo1Ps9Lpl3eTg',
      'amount': ((widget.rupeesRequired) * 100)
          .toString(), //in the smallest currency sub-unit.
      'name': 'Slots',
      'description': 'Win ${widget.productTitle}',
      'timeout': 120, // in seconds
      'prefill': {
        'contact': _service.user!.phoneNumber.toString(),
        'email': "${widget.email1}"
      },
      "customer": {
        "name":
            "${firstname1} ${lastname1}",
        "contact": _service.user!.phoneNumber.toString(),
        "email": "${widget.email1}"
      },
      "notify": {"sms": true, "email": true},
    };
    if (context.read<TempReservedSlots>().selectedSlots.length ==
        widget.quantity) {
      setState(() {
        validated = true;
      });
    } else {
      setState(() {
        validated = false;
      });
    }
    Future<bool> clearSelectedSlots() {
      context.read<TempReservedSlots>().clear();
      clearTempReservedSlots();
      return Future.value(true);
    }

    return WillPopScope(
      onWillPop: () {
        return clearSelectedSlots();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(getProportionateScreenHeight(77.3)),
          child: CustomAppBar(
            viewTicketCount: false,
          ),
        ),
        body: SingleChildScrollView(
          child: FirestoreQueryBuilder<MinimumProduct>(
              query: muchMinimumProductQuery(true, widget.id),
              builder: (context, snapshot, _) {
                if (snapshot.isFetching && !snapshot.hasData) {
                  return Padding(
                    padding: paddingMarginTLR15,
                    child: Simmer(
                      height: getProportionateScreenHeight(230),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  EasyLoading.showError("Something went wrong!");
                  return Center(
                      child: Text(
                    "Something went wrong!",
                    style: text13DarkGrayFw500,
                  ));
                }
                if (snapshot.hasData) {
                  EasyLoading.dismiss();
                }
                product = snapshot.docs[0].data();

                context.read<TempReservedSlots>().selectedSlots.removeWhere(
                  (slotNo) {
                    bool slotExists = false;

                    if ((context).read<UserTempSelectedSlotsProvider>().user !=
                        null) {
                      if ((context)
                          .read<UserTempSelectedSlotsProvider>()
                          .user!
                          .tempSlotNo!
                          .contains(slotNo)) {
                        slotExists = false;
                      }
                    } else if (product!.tempReservedSlots!.contains(slotNo)) {
                      if (product!.tempReservedSlots!.contains((context)
                              .read<UserTempSelectedSlotsProvider>()
                              .user !=
                          null)) {
                        if (product!.tempReservedSlots!.contains((context)
                                .read<UserTempSelectedSlotsProvider>()
                                .user!
                                .tempSlotNo) ==
                            false) {
                          slotExists = false;
                        } else
                          slotExists = true;
                      }
                      // else slotExists = true;
                    }
                    if (product!.reservedSlots!.contains(slotNo)) {
                      slotExists = true;
                    }

                    return slotExists;
                  },
                );

                return product != null
                    ? Column(
                        children: [
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          //if((context).read<UserTempSelectedSlotsProvider>().user!=null)

                          Text(
                            "Select any ${widget.quantity} lucky ${widget.quantity == 1 ? "slot" : "slots"} 🤞",
                            style: text18DarkFw500,
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(15),
                          ),
                          if (product!.totalSlots != null &&
                              product!.reservedSlots != null)
                            InteractiveViewer(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Wrap(
                                      children: List.generate(
                                          product!.totalSlots!, (index) {
                                        return InkWell(
                                          onTap: () {
                                            HapticFeedback.vibrate();
                                            setState(() {
                                              if (winningSlot == null) {
                                                winningSlot =
                                                    product!.winningSlot;
                                              }

                                              if (context
                                                          .read<
                                                              TempReservedSlots>()
                                                          .selectedSlots
                                                          .contains(
                                                              index + 1) ==
                                                      false &&
                                                  product!.reservedSlots!
                                                          .contains(
                                                              index + 1) ==
                                                      false &&
                                                  product!.tempReservedSlots!
                                                          .contains(
                                                              index + 1) ==
                                                      false) {
                                                if (context
                                                        .read<
                                                            TempReservedSlots>()
                                                        .selectedSlots
                                                        .length <
                                                    widget.quantity) {
                                                  context
                                                      .read<TempReservedSlots>()
                                                      .addItem(index + 1);
                                                } else {
                                                  context
                                                      .read<TempReservedSlots>()
                                                      .removeAt(0);

                                                  context
                                                      .read<TempReservedSlots>()
                                                      .addItem(index + 1);
                                                }
                                              } else if (context
                                                  .read<TempReservedSlots>()
                                                  .selectedSlots
                                                  .contains(index + 1)) {
                                                context
                                                    .read<TempReservedSlots>()
                                                    .selectedSlots
                                                    .remove(index + 1);
                                              }
                                            });
                                          },
                                          child: SelectionBox(
                                            isReserved: product!.reservedSlots!
                                                        .contains(index + 1) ||
                                                    product!.tempReservedSlots!
                                                        .contains(index + 1)
                                                ? true
                                                : false,
                                            isSelected: context
                                                        .read<
                                                            TempReservedSlots>()
                                                        .selectedSlots
                                                        .contains(index + 1) ==
                                                    false
                                                ? false
                                                : true,
                                            slotNumber: "${index + 1}",
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          Padding(
                            padding: paddingMarginLR15,
                            child: Text(
                              "One among the above slots has a winning slot.\nIf you choose the winning slot then you will be the winner.\nBest of luck.",
                              style: text12DarkGrayFw400,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(25),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SelectionBox(
                                isReserved: true,
                              ),
                              Text(
                                "Oponents",
                                style: text12DarkGrayFw400,
                              ),
                              SizedBox(
                                width: getProportionateScreenHeight(5),
                              ),
                              SelectionBox(),
                              Text(
                                "Available",
                                style: text12DarkGrayFw400,
                              ),
                              SizedBox(
                                width: getProportionateScreenHeight(5),
                              ),
                              SelectionBox(
                                isSelected: true,
                              ),
                              Text(
                                "Selected",
                                style: text12DarkGrayFw400,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(25),
                          ),
                          if (product!.totalSlots != null &&
                              product!.reservedSlots != null)
                            SizedBox(
                              width: SizeConfig.screenWidth! / 1.5,
                              child: MyProgressBar(
                                needProgressBar: false,
                                centerText: true,
                                soldOutSlots: product!.reservedSlots!.length,
                                totalSlots: product!.totalSlots!,
                                leadingText: "Hurry!",
                              ),
                            ),
                        ],
                      )
                    : CircularProgressIndicator(
                        color: DarkPurple,
                      );
              }),
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.only(
            bottom: getProportionateScreenWidth(15),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: validated == true
                ? GradientButton(
                    text1: widget.rupeesRequired > 0
                        ? "Pay ₹${widget.rupeesRequired.round()} & continue"
                        : "Let's Go",
                    bgGradientColor: linearGradient8,
                    press: () {
                      // EasyLoading.show(status: "Please wait...");

                      _service.product
                          .where(FieldPath.documentId, isEqualTo: widget.id)
                          .where('tempReservedSlots',
                              arrayContainsAny: context
                                  .read<TempReservedSlots>()
                                  .selectedSlots)
                          .get()
                          .then((snapshot) {
                        if (snapshot.docs.isEmpty &&
                            !product!.tempReservedSlots!.contains(context
                                .read<TempReservedSlots>()
                                .selectedSlots)) {
                          if (widget.rupeesRequired > 0 &&
                              !product!.tempReservedSlots!.contains(context
                                  .read<TempReservedSlots>()
                                  .selectedSlots)) {
                            EasyLoading.dismiss();
                            try {
                              tempReserveSlots();
                              _razorpay.open(options);
                            } catch (e) {
                              EasyLoading.showError(e.toString());
                            }
                          } else {
                            removeTicketsFromDB();
                          }
                        } else {
                          EasyLoading.dismiss();
                          EasyLoading.showInfo(
                              "Some slot(s) you selected\nhas been sold out.${snapshot.docs[0]["tempReservedSlots"]}");
                          context
                              .read<TempReservedSlots>()
                              .selectedSlots
                              .remove(snapshot.docs[0]["tempReservedSlots"]);
                          //return Promise.reject('Seats already taken');
                        }
                      });

                      // if (!product!.tempReservedSlots!.contains(
                      //     context.read<TempReservedSlots>().selectedSlots)) {
                      //   tempReserveSlots();
                      //   if (widget.rupeesRequired > 0 &&
                      //       !product!.tempReservedSlots!.contains(context
                      //           .read<TempReservedSlots>()
                      //           .selectedSlots)) {
                      //     EasyLoading.dismiss();
                      //     try {
                      //       _razorpay.open(options);
                      //     } catch (e) {
                      //       EasyLoading.showError(e.toString());
                      //     }
                      //   } else if (!product!.tempReservedSlots!.contains(
                      //       context.read<TempReservedSlots>().selectedSlots)) {
                      //     EasyLoading.dismiss();
                      //     removeTicketsFromDB();
                      //   }
                      // } else {
                      //   EasyLoading.dismiss();
                      //   EasyLoading.showInfo(
                      //       "Some slot(s) you selected\nhas been sold out.");
                      // }
                    })
                : DefaultButton(
                    text: "Select ${widget.quantity} slots",
                    button_color: DarkGray,
                    press: () {}),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear();
    super.dispose();
  }
}
