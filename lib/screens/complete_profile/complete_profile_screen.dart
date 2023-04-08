import 'package:flutter/material.dart';
import 'package:shop_ecommerce/screens/all_view/all_view.dart';
import 'package:shop_ecommerce/screens/complete_profile/components/body.dart';
import 'package:shop_ecommerce/size_config.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  static String routeName = "/complete_profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const AllView(
        body: Body(),
      ),
    );
  }
}
