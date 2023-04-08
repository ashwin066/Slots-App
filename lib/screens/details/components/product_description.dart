import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce/components/bg_box.dart';
import 'package:shop_ecommerce/components/default_button.dart';
import 'package:shop_ecommerce/components/my_progress_bar.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/minimum_product_model.dart';
import 'package:shop_ecommerce/models/user_purchased_slots_model.dart';
import 'package:shop_ecommerce/screens/my_tickets/my_tickets.dart';
import 'package:shop_ecommerce/screens/slot_selection/components/selection_box.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/size_config.dart';

class ProductDescription extends StatelessWidget {
  ProductDescription({
    Key? key,
    required this.product,
    required this.pressOnSeeMore,
  }) : super(key: key);

  final product;
  final GestureTapCallback pressOnSeeMore;
  @override
  Widget build(BuildContext context) {
    FirebaseService _service = FirebaseService();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: paddingMarginLR20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  "${product.productName.toString()}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              Text(
                "Product worth ₹${product.regularPrice.toString()}",
                style: text15DarkGrayFw400,
              ),
            ],
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        Container(
          margin: paddingMarginLR15,
          padding: paddingMarginAll15,
          decoration: BoxDecoration(
            color: aWhite,
            borderRadius: borderRadius13,
            boxShadow: [
              BoxShadow(
                color: DarkPurple.withOpacity(.25),
                blurRadius: 15,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/ticket_filled.svg",
                            height: getProportionateScreenHeight(24),
                            width: getProportionateScreenHeight(24),
                            color: MediumPinkPurple,
                          ),
                          SizedBox(width: getProportionateScreenHeight(6)),
                          Text(
                            "${product.slotPrice.toString()} Tickets / slot",
                            style: text18DarkFw700,
                          ),
                        ],
                      ),
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
                        child: Row(  
                          children: [
                           
                            Text(
                              "Earn tickets ",
                              style: text13DarkGrayFw500,
                            ),
                            SvgPicture.asset(
                              "assets/icons/arrow_right.svg",
                              height: getProportionateScreenHeight(10),
                              width: getProportionateScreenHeight(10),
                              color: DarkGray,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  if (product.reservedSlots != null)
                    if (product.totalSlots != null)
                      BgBox(padding: paddingMarginAll8,
                        bgColor: MuchLightGray.withOpacity(.5),
                        child: MyProgressBar(
                          centerText: true,
                          soldOutSlots: product.reservedSlots!.length,
                          totalSlots: product.totalSlots!,
                        ),
                      ),
                  SizedBox(height: getProportionateScreenHeight(1)),
                  Text(
                    "Out of ${product.totalSlots.toString()}",
                    style: text13DarkFw500,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(15),
        ),
        Container(
          width: double.infinity,
          padding: paddingMarginAll20,
          decoration: BoxDecoration(color: MuchLightGray),
          child: Text(
            "Product Description:\n${product.description.toString()}",
            maxLines: 100,
            style: text13DarkFw400,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  "See More Detail",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: PrimaryColor,
                  ),
                ),
                SizedBox(width: 5.w),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: PrimaryColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
