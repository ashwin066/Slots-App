import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/home/home_screen.dart';
import 'package:shop_ecommerce/screens/sign_in/sign_in_screen.dart';
import 'package:shop_ecommerce/screens/splash/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_ecommerce/service/secure/shared_preferences_service.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final ServicePreferences _servicePreferences = ServicePreferences();

  @override
  void initState() {
    _servicePreferences.readCache("fireBaseUID").then((value) {
      if (value != null) {
        return Timer(
            Duration(seconds: 2),
            () => Navigator.of(context).pushReplacement(PageTransition(
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 300),
                reverseDuration: Duration(milliseconds: 300),
                child: HomeScreen())));
      } else {
        return Timer(
            Duration(seconds: 2),
            () => Navigator.of(context).pushReplacement(PageTransition(
                type: PageTransitionType.fade,  
                duration: Duration(milliseconds: 500),
                reverseDuration: Duration(milliseconds:500),
                child: SignInScreen())));
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: aBlack,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(
              color: PrimaryColor,
              minHeight: 3.h,
              backgroundColor: aWhite,
            ),
            SizedBox(
              height: 5.h,
            ),
            Image.asset(
              "assets/images/foreground_logo.png",
              width: 150.w,
              height: 150.h,
            ),
            Text(
              "Foundyo",
              style: TextStyle(
                color: aWhite,
                fontWeight: FontWeight.w900,
                fontSize: 45.sp,
              ),
            ),
            SizedBox(
              height: 34.h,
            ),
            LinearProgressIndicator(
              color: PrimaryColor,
              minHeight: 3.h,
              backgroundColor: aWhite,
            ),
          ],
        ),
      ),
    );
  }
}
