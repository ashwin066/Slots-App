import 'package:flutter/material.dart';
import 'package:shop_ecommerce/components/custom_app_bar.dart';
import 'package:shop_ecommerce/components/custom_bottom_nav_bar.dart';
import 'package:shop_ecommerce/enum.dart';
import 'package:shop_ecommerce/models/cart.dart';
import 'package:shop_ecommerce/screens/wishlist/components/body.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);

  static String routeName = "/wishlist";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomMainAppBar(
            title: "Wishlist", subtitle: "Items", type: "wishlist"),
        preferredSize: Size.fromHeight(73.h),
      ),
      body: Body(),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
