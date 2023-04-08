import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce/components/default_button.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/provider/user_provider.dart';
import 'package:shop_ecommerce/screens/home/home_screen.dart';
import 'package:shop_ecommerce/screens/main_page/main_page.dart';
import 'package:shop_ecommerce/screens/my_slots/my_slots.dart';
import 'package:shop_ecommerce/service/get_user_data/get_user_data.dart';
import 'package:shop_ecommerce/size_config.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  String? firstName;
  @override
  void initState() {
    getIt() async {
      final firstname1 = await GetUserData().getUserInfoAsString("firstName");

      setState(() {
        firstName = firstname1!;
      });
    }

    getIt();
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 4), vsync: this);

    // controller.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {

    //   }
    // });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: .45,
          child: RotatedBox(
            quarterTurns: 2,
            child: Lottie.asset(
              "assets/lottie/confetti.json",
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Container(
          width: SizeConfig.screenWidth,
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight! * 0.04),
              Lottie.asset(
                "assets/lottie/success.json",
                reverse: true,

                height: SizeConfig.screenHeight! * 0.28,
                width: SizeConfig.screenHeight! * 0.32, // 40%
                fit: BoxFit.cover,
              ),
              Text(
                "Best of luck",
                style: text25DarkFw500,
                textAlign: TextAlign.center,
              ),
              Text(
                "${firstName??"🙂"}",
                style: text23DarkFw700,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.01),
              Text(
                "Slot(s) Booked Successfully",
                style: text15DarkGrayFw400,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              SizedBox(
                width: SizeConfig.screenWidth! * 0.8,
                child: DefaultButton(
                  text: "Go To My Slots",
                  button_color: PrimaryColor,
                  press: () =>
                      Navigator.of(context).pushReplacement(PageTransition(
                          type: PageTransitionType.fade,
                          duration: defaultDuration,
                          reverseDuration: defaultDuration,
                          child: MainScreen(
                            selectedMenu: 2,
                          ))),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
