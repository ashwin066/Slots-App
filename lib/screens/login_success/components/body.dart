import 'package:flutter/material.dart';
import 'package:shop_ecommerce/components/default_button.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/home/home_screen.dart';
import 'package:shop_ecommerce/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight! * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight! * 0.4, // 40%
        ),
        SizedBox(height: SizeConfig.screenHeight! * 0.08),
        Text(
          "Login Success",
          style: headingStyle,
        ),
        const Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth! * 0.6,
          child: DefaultButton(
            text: "Back to home",
            press: () => Navigator.pushNamed(context, HomeScreen.routeName),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
