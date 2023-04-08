import 'package:flutter/material.dart';
import 'package:shop_ecommerce/components/custom_app_bar.dart';
import 'package:shop_ecommerce/screens/all_view/all_view.dart';
import 'package:shop_ecommerce/screens/user_transactions/components/body.dart';
 import 'package:shop_ecommerce/size_config.dart';

class Transactions extends StatelessWidget {
  const Transactions({Key? key}) : super(key: key);

  static String routeName = "/sign_in";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: SafeArea(
            child: CustomAppBar(
          viewTicketCount: true,
        )),
        preferredSize: Size.fromHeight(getProportionateScreenHeight(77.3)),
      ),
      body:   AllView(
        body: Body(),
      ),
    );
  }
}
