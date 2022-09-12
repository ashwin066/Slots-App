import 'package:flutter/material.dart';
import 'package:shop_ecommerce/components/custom_app_bar.dart';
import 'package:shop_ecommerce/screens/cart/components/check_our_card.dart';
import 'package:shop_ecommerce/models/Cart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/body.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomMainAppBar(title: "Cart", subtitle: "Items", type: "cart"),
        preferredSize: Size.fromHeight(73.h),
      ),
      body: Body(),
      bottomNavigationBar: CheckOurCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "1",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
