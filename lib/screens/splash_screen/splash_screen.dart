import 'package:flutter/material.dart';
import 'package:shop_ecommerce/screens/splash_screen/components/body.dart';
import 'package:shop_ecommerce/size_config.dart';

class MainSplashScreen extends StatefulWidget {
  const MainSplashScreen({Key? key}) : super(key: key);
  static String routeName = "/splash_screen";
  @override
  State<MainSplashScreen> createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: const Body(),
    );
  }
}
