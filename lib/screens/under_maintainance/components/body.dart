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
  const Body({
    super.key,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return   Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [Image.asset("assets/images/full_logo_dark.png",width: SizeConfig.screenWidth!/2 ,),
          SizedBox(height: SizeConfig.screenHeight!/29),
          Text(
            "We are undergoing some\nsheduled server maintainence.",
            style: text16LightGrayFw400,
            textAlign: TextAlign.center,
          ),
          Text(
            "We will be back soon.",
            style: text16DarkGrayFw400,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ) ;
  }
}
