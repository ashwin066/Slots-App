import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
 import 'package:shop_ecommerce/components/product_item_card.dart';
import 'package:shop_ecommerce/get_put_data/fetch_data.dart';
import 'package:shop_ecommerce/screens/details/details_screen.dart';
import 'package:shop_ecommerce/service/controllers/wishlist_controller.dart';

import '../../../size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
   
  @override
  Widget build(BuildContext context) {
    return fetchData("users_wishlisted_items", "wishlist");
  }
}
