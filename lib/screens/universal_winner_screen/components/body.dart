import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce/components/custom_app_bar.dart';
import 'package:shop_ecommerce/components/default_button.dart';
import 'package:shop_ecommerce/components/footer.dart';
import 'package:shop_ecommerce/components/gradient_button.dart';
import 'package:shop_ecommerce/components/product_card.dart';
import 'package:shop_ecommerce/components/simmer.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/minimum_product_model.dart';
import 'package:shop_ecommerce/models/user_model.dart';
import 'package:shop_ecommerce/models/user_purchased_slots_model.dart';
import 'package:shop_ecommerce/provider/user_provider.dart';
import 'package:shop_ecommerce/screens/bg_animation/bg_animation.dart';
import 'package:shop_ecommerce/screens/complete_profile/components/body.dart';
import 'package:shop_ecommerce/screens/details/components/top_rounded_container.dart';
import 'package:shop_ecommerce/screens/details/details_screen.dart';
import 'package:shop_ecommerce/screens/home/components/custom_divider.dart';
import 'package:shop_ecommerce/screens/slot_selection/components/selection_box.dart';
import 'package:shop_ecommerce/size_config.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
    required this.product,
    required this.id,
    required this.user,
  });
  final MinimumProduct product;
  final String id;
  final FirestoreQueryBuilderSnapshot<UserModel> user;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: aBlack,
        body:  
            BgAnimation(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(110),
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
                        child: SizedBox(
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
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(5),
                      ),
                      if (widget.product.totalSlots ==
                          widget.product.reservedSlots!.length)
                        Column(
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                          ],
                        ),
                      widget.product.totalSlots ==
                              widget.product.reservedSlots!.length
                          ? Column(
                              children: [],
                            )
                          : Column(
                              children: [
                                Text(
                                  "${widget.user.docs[0].data().firstName!} ${widget.user.docs[0].data().lastName != null ? widget.user.docs[0].data().lastName : ""}",
                                  style: text23LightFw700,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                    height: SizeConfig.screenHeight! * 0.005),
                                Text(
                                  "From ${widget.user.docs[0].data().city}, ${widget.user.docs[0].data().state}",
                                  style: text15DarkGrayFw400,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                    height: SizeConfig.screenHeight! * 0.006),
                                SizedBox(
                                  width: SizeConfig.screenWidth! / 1.3,
                                  child: Text(
                                    "Has won,\n${widget.product.productName}",
                                    style: text12LightGrayFw400,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                CustomDivider(),
                                Text(
                                  "Their Product will be delivered\nwithin 7 working days.",
                                  style: text11DarkGrayFw400,
                                  textAlign: TextAlign.center,
                                ),
                                CustomDivider(),
                                 Text(
                                  "You may be the next winner\nso why wait book a slot now.",
                                  style: text11DarkGrayFw400,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                      Footer(height: 150)
                    ],
                  ),
                ),
              ),
            ),
           
        bottomSheet: TopRoundedContainer(
          color: Transparent,
          child: Padding(
            padding: paddingMarginAll15,
            child: DefaultButton(
              text: "Back",
              button_color: DarkPurple,
              press: () {
                Navigator.pop(context);
              },
            ),
          ),
        ));
  }
}
