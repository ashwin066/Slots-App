import 'package:flutter/material.dart';
import 'package:shop_ecommerce/components/custom_app_bar.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/all_view/all_view.dart';
import 'package:shop_ecommerce/screens/bg_animation/bg_animation.dart';
import 'package:shop_ecommerce/screens/my_tickets/components/body.dart';
import 'package:shop_ecommerce/size_config.dart';

 

class MyTickets extends StatelessWidget {
  const MyTickets({super.key,   this.current, });
  final int? current;
  static String routeName = "/my_tickets";

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return Scaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        child: CustomAppBar(
          text: "My tickets",
          needBackBtn: false,
        ),
        preferredSize: Size.fromHeight(getProportionateScreenHeight(77.3)),
      ),
      body: AllView(
          body:
              Body(current: arguments !=null?  arguments['current']  :current??0)),
    );
  }
}
