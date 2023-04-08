import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:shop_ecommerce/components/custom_app_bar.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/product_model.dart';
import 'package:shop_ecommerce/models/user_purchased_slots_model.dart';
import 'package:shop_ecommerce/screens/all_view/all_view.dart';
import 'package:shop_ecommerce/screens/see_all_screen/components/body.dart';
import 'package:shop_ecommerce/size_config.dart';

class SeeAllScreen extends StatelessWidget {
  const SeeAllScreen({
    Key? key,
  }) : super(key: key);

  static String routeName = "/see_all_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        child: SafeArea(
            child: CustomAppBar(
           viewTicketCount: true,
        )),
        preferredSize: Size.fromHeight(getProportionateScreenHeight(77.3)),
      ),
      body: AllView(
        body: Body(),
      ),
     );
  }
}
