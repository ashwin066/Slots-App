import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shop_ecommerce/components/bg_box.dart';
import 'package:shop_ecommerce/components/default_button.dart';
import 'package:shop_ecommerce/components/gradient_button.dart';
import 'package:shop_ecommerce/components/info_bottom_sheet.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/tickets_combo.dart';
import 'package:shop_ecommerce/provider/user_provider.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/service/get_user_data/get_user_data.dart';
import 'package:shop_ecommerce/size_config.dart';

class TicketPriceCard extends StatefulWidget {
  const TicketPriceCard({
    super.key,
    required this.ticket,
  });

  final TicketsCombo ticket;

  @override
  State<TicketPriceCard> createState() => _TicketPriceCardState();
}
FirebaseService _service = FirebaseService();

class _TicketPriceCardState extends State<TicketPriceCard> {
  var _razorpay = Razorpay();

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
   _service.addRemoveTickets(
        ticketData: {"tickets": FieldValue.increment(widget.ticket.tickets??5)}).then((value) {
         

      showInfoBottomSheet(
          context,
          "Purchase successful! 🥳\n${widget.ticket.tickets??"5"} tickets added",
          "${widget.ticket.combo_name??"5 tickets"} added to your account.",
          null);
        });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    // clearTempReservedSlots();

    EasyLoading.showError("Payment Failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
  String firstname1 = "";
  String lastname1 = "";
  String email1 = "";

  @override
  void initState() {
    // TODO: implement initState
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getIt() async {
      final firstname = await GetUserData().getUserInfoAsString("firstName");
      final lastname = await GetUserData().getUserInfoAsString("lastName");
      final email = await GetUserData().getUserInfoAsString("email");

      setState(() {
        firstname1 = firstname!;
      });
      setState(() {
        lastname1 = lastname!;
      });
      setState(() {
        email1 = email!;
      });
    }

    getIt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseService _service = FirebaseService();
    var options = {
      'key': 'rzp_test_9Fo1Ps9Lpl3eTg',
      'amount': ((widget.ticket.price ?? 10) * 100)
          .toString(), //in the smallest currency sub-unit.
      'name': 'Slots',
      'description': 'For purchase of ticket: ${widget.ticket.combo_name}',
      'timeout': 180, // in seconds
      'prefill': {
        'contact': _service.user!.phoneNumber.toString(),
        'email': "${email1}"
      },
      "customer": {
        "name": "${firstname1} ${lastname1}",
        "contact": _service.user!.phoneNumber.toString(),
        "email": "${email1}"
      },
      "notify": {"sms": true, "email": true},
    };
    return Container(
      margin: paddingMarginB12LR12,
      width: double.infinity, 
      decoration: BoxDecoration(
          border: border0by8lightGray,  color: aWhite, borderRadius: borderRadius13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13),
                    topRight: Radius.circular(13),
                  ),
                ),
                child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: DarkProffesionalGreen,
                          boxShadow: [
                            BoxShadow(
                              color: DarkPurple.withOpacity(.25),
                              blurRadius: 15,
                              offset: Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(13),
                            bottomLeft: Radius.circular(13),
                          ),
                        ),
                        child: Padding(
                            padding: paddingMarginLR11TB3,
                            child: Text(
                              "${widget.ticket.value_type ?? "Best Value!"}",
                              style: text13LightFw500,
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                         
                              BgBox(
                                  bgColor: DarkPurple,
                                  borderRadius: borderRadius13,
                                  margin: EdgeInsets.only(
                                      top: getProportionateScreenHeight(8),
                                      right: getProportionateScreenHeight(10),
                                      left: getProportionateScreenHeight(8),
                                      bottom: 0),
                                  padding: EdgeInsets.all(
                                      getProportionateScreenHeight(10)),
                                  child: SizedBox(
                                    height: getProportionateScreenHeight(30),
                                    width: getProportionateScreenHeight(30),
                                    child: SvgPicture.asset(
                                      "assets/icons/ticket_filled.svg",
                                      color: MediumPinkPurple,
                                    ),
                                  )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.ticket.combo_name ?? "",
                                    style: text15DarkFw800,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "Never Expires",
                                    style: text12DarkGrayFw400,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                    ],
                  ),
                ),
                
                 
              
              Padding(
                padding: paddingMarginAll15,
                child: Row(
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'This combo costs \n',
                        style: text13DarkFw400, 
                        children: <TextSpan>[
                          new TextSpan(
                              text: '\₹${widget.ticket.price ?? "10"} ',
                              style: text18DarkFw700),
                          new TextSpan(
                            text: '\₹${widget.ticket.regular_price ?? "10"}',
                            style: new TextStyle(fontWeight: FontWeight.w700,
                              color: Colors.grey,fontSize: getProportionateScreenHeight(18),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenHeight(45),
                    ),
                    Flexible(
                        child: DefaultButton(
                            text_color: aWhite,
                            text: "Buy now",
                            button_color: DarkPurple,
                            press: () {
                              try {
                                _razorpay.open(options);
                              } catch (e) {
                                EasyLoading.showError(e.toString());
                              }
                            }))
                  ],
                ),
              ),
            ],
          ),
        ],
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
