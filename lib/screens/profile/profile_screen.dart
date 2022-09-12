import 'package:flutter/material.dart';
import 'package:shop_ecommerce/components/custom_app_bar.dart';
import 'package:shop_ecommerce/components/custom_bottom_nav_bar.dart';
import 'package:shop_ecommerce/enum.dart';
import 'package:shop_ecommerce/screens/profile/components/body.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static String routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomMainAppBar(
            title: "Settings", subtitle: "Profile", type: "Settings"),
        preferredSize: Size.fromHeight(73.h),
      ),
      body: const Body(),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
