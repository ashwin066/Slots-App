import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce/components/custom_app_bar.dart';
 import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/provider/internet_check_provider.dart';
import 'package:shop_ecommerce/provider/user_provider.dart';
import 'package:shop_ecommerce/screens/all_view/U_M_view.dart';
import 'package:shop_ecommerce/screens/all_view/all_view.dart';
import 'package:shop_ecommerce/screens/bg_animation/bg_animation.dart';
import 'package:shop_ecommerce/screens/home/components/body.dart';
import 'package:shop_ecommerce/size_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        debugPrint("onMessage:");
        log("onMessage: $message");
        final snackBar =
            SnackBar(content: Text(message.notification?.title ?? ""));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
 
    return 
   Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: backgroundColor,
          appBar: PreferredSize(
            child: SafeArea(
                child: CustomAppBar(
              viewLogo: true,
              viewTicketCount: true,
            )),
            preferredSize: Size.fromHeight(getProportionateScreenHeight(77.3)),
          ),
          body:   AllView(body: Body() ),
           
          
     
    );
  }
}
