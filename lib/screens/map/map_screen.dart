import 'package:flutter/material.dart';
import 'package:shop_ecommerce/components/custom_app_bar.dart';
import 'package:shop_ecommerce/components/custom_bottom_nav_bar.dart';
import 'package:shop_ecommerce/enum.dart';
import 'package:shop_ecommerce/screens/home/components/home_header_Top.dart';
import 'package:shop_ecommerce/screens/map/components/body.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  static String routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomMainAppBar(
                title: "Shop Map", subtitle: "18 stores nearby", type: "Settings"),
                HomeHeaderTop()
          ],
        ),
        preferredSize: Size.fromHeight(134.5.h),
      ),
      body: const Body(),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.favourite),
    );
  }
}
