import 'package:flutter/material.dart';
import 'package:shop_ecommerce/components/custom_app_bar.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/minimum_product_model.dart';
import 'package:shop_ecommerce/models/user_purchased_slots_model.dart';
import 'package:shop_ecommerce/screens/winner_screen/components/body.dart';
import 'package:shop_ecommerce/size_config.dart';

class WinnerScreen extends StatelessWidget {
  const WinnerScreen(
      {super.key,
      required this.product,
      required this.id,
      required this.userPurchased});
  final MinimumProduct product;
  final String id;
  final UserPurchasedSlotsModel userPurchased;

  @override
  Widget build(BuildContext context) {
    return  Body(
        userPurchased: userPurchased,
        product: product,
        id: id,
      
    );
  }
}
