import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/provider/user_provider.dart';
import 'package:shop_ecommerce/screens/all_view/all_view.dart';
import 'package:shop_ecommerce/screens/splash_screen/components/body.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/service/get_user_data/get_user_data.dart';
import 'package:shop_ecommerce/service/secure/shared_preferences_service.dart';
import 'package:shop_ecommerce/size_config.dart';

class MainSplashScreen extends StatelessWidget {
    MainSplashScreen({Key? key}) : super(key: key);
  static String routeName = "/splash_screen";
 
  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
   
    return const Scaffold(
      backgroundColor: backgroundColor,
      body: AllView(
        body: Body(),
      ),
    );
  }
}
