import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_ecommerce/components/buy_ticket_bottom_sheet.dart';
import 'package:shop_ecommerce/components/custom_app_bar.dart';
import 'package:shop_ecommerce/components/default_button.dart';
import 'package:shop_ecommerce/components/footer.dart';
import 'package:shop_ecommerce/components/gradient_button.dart';
import 'package:shop_ecommerce/components/simmerContainer.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/user_purchased_slots_model.dart';
import 'package:shop_ecommerce/screens/bg_animation/bg_animation.dart';
import 'package:shop_ecommerce/screens/details/components/product_description.dart';
import 'package:shop_ecommerce/screens/details/components/product_image.dart';
import 'package:shop_ecommerce/screens/details/components/top_rounded_container.dart';
import 'package:shop_ecommerce/size_config.dart';

class Body extends StatelessWidget {
  Body({
    Key? key,
    required this.product,
    required this.id, 
  }) : super(key: key);
  final product;
  final String id;
   @override
  Widget build(BuildContext context) {
    //  final controller = Get.put(CartController());
    //  final cartIDController = Get.put(CartIdController());

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getProportionateScreenHeight(77.3)),
        child: CustomAppBar(
          viewTicketCount: true,
        ),
      ),
      body: 
           BgAnimation(opacity: .26,
        child: ListView(
              physics: const AlwaysScrollableScrollPhysics(), // new
          
              children: [
                ProductImages(product: product),
                TopRoundedContainer(
                  color: Transparent,
                  child: Column(
                    children: [
                      ProductDescription(
                         product: product,
                        pressOnSeeMore: () {},
                      ),
                    ],
                  ),
                ),
                const Footer(height: 170)
              ],
             
                ),
          ),
      bottomSheet: Padding(
        padding: EdgeInsets.only(
          bottom: getProportionateScreenWidth(15),
        ),
        child: Container(
          padding: paddingMarginLR15,
          child: GradientButton( 
            bgColor: product.reservedSlots.length != product.totalSlots
                  ?MuchDarkPurple: MuchDarkGray,
              text1: product.reservedSlots.length != product.totalSlots
                  ? "Get 1 slot"
                  : "Return home",
              text2: product.reservedSlots.length != product.totalSlots
                  ? "${product.slotPrice} tickets"
                  : null,
               press: () {
                product.reservedSlots.length != product.totalSlots
                    ? showBuyTicketBottomSheet(context, id)
                    : Navigator.pop(context);
              }),
        ),
      ),
    );
  }
}
