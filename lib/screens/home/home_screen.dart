import 'package:flutter/material.dart';
import 'package:shop_ecommerce/components/custom_bottom_nav_bar.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/enum.dart';
import 'package:shop_ecommerce/screens/home/components/body.dart';
import 'package:shop_ecommerce/screens/home/components/home_header_Top.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorLight,
      appBar: PreferredSize(child: SafeArea(child: HomeHeaderTop()),
       preferredSize: Size.fromHeight(73.h),
      ), 
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
