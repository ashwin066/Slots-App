import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:shop_ecommerce/components/custom_app_bar.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/minimum_product_model.dart';
import 'package:shop_ecommerce/models/user_model.dart';
import 'package:shop_ecommerce/models/user_purchased_slots_model.dart';
import 'package:shop_ecommerce/screens/bg_animation/bg_animation.dart';
import 'package:shop_ecommerce/screens/universal_winner_screen/components/body.dart';
import 'package:shop_ecommerce/size_config.dart';

class UniversalWinnerScreen extends StatelessWidget {
  const UniversalWinnerScreen(
      {super.key,
      required this.product,
      required this.id, required this.user,
     });
  final MinimumProduct product;
  final String id;
 final FirestoreQueryBuilderSnapshot<UserModel> user;


  @override
  Widget build(BuildContext context) {
    return  Body(
         product: product,
        id: id,user:user
       
    );
  }
}
