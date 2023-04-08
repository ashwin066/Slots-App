import 'package:flutter/material.dart';
import 'package:shop_ecommerce/components/custom_app_bar.dart';
import 'package:shop_ecommerce/screens/all_view/all_view.dart';
import 'package:shop_ecommerce/screens/purchase_successful/components/body.dart';
import 'package:shop_ecommerce/size_config.dart';

class PurchaseSuccessful extends StatelessWidget {
  const PurchaseSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(
          viewTicketCount: false,
        ),
        preferredSize: Size.fromHeight(getProportionateScreenHeight(77.3)),
      ),
      body: AllView(
        body: Body(),
      ),
    );
  }
}
