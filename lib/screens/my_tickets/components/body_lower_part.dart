import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce/components/fade_indexed_stack.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/tickets.dart';
import 'package:shop_ecommerce/screens/my_tickets/components/earn_tickets.dart';
import 'package:shop_ecommerce/screens/my_tickets/components/purchase_tickets.dart';
import 'package:shop_ecommerce/service/ads/admobHelper.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/size_config.dart';

class BodyLower extends StatefulWidget {
  BodyLower({super.key, required this.current});

  @override
  State<BodyLower> createState() => _BodyLowerState();
  int current;
}

class _BodyLowerState extends State<BodyLower> {
  FirebaseService _service = FirebaseService();
  final admodHelper = AdmobHelper();
  List<String> items = [
    "Purchase tickets",
    "Earn tickets",
  ];
  List<Widget> pages = [PurchaseTickets(), EarnTickets()];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        //tabbar
        SizedBox(
          width: double.infinity,
          height: getProportionateScreenHeight(54),
          child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        setState(() {
                          widget.current = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: defaultDuration,
                        margin: EdgeInsets.only(
                            left: getProportionateScreenHeight(15)),
                        // width: getProportionateScreenHeight(100),
                        height: getProportionateScreenHeight(40),
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenHeight(8)),
                        decoration: BoxDecoration( gradient: widget.current == index ? linearGradient5:null,
                          color: widget.current == index ? MuchDarkPurple : aWhite,
                          borderRadius: borderRadius13,
                          border: Border.all(color: MuchDarkPurple, width: 2),
                        ),
                        child: Center(
                          child: Text(
                            items[index],
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: widget.current == index
                                    ? aWhite
                                    : DarkPurple),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),

        FadeIndexedStack(
          children: pages,
          index: widget.current,
        ),
      ],
    );
  }
}
