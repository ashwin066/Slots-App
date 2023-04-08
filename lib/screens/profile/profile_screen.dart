import 'package:flutter/material.dart';
import 'package:shop_ecommerce/components/custom_app_bar.dart';
 import 'package:shop_ecommerce/screens/all_view/all_view.dart';
import 'package:shop_ecommerce/screens/profile/components/body.dart';
import 'package:shop_ecommerce/size_config.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static String routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(needBackBtn: false,
          text: "Profile & Settings",
        ),
        preferredSize: Size.fromHeight(getProportionateScreenHeight(77.3)),
      ),
      body:   Body(),
     
     );
  }
}
