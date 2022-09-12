import 'package:flutter/material.dart';
import 'package:shop_ecommerce/components/default_button.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/home/home_screen.dart';
import 'package:shop_ecommerce/size_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        SizedBox(height: SizeConfig.screenHeight! * 0.04.h),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight! * 0.4.h, // 40%
        ),
        SizedBox(height: SizeConfig.screenHeight! * 0.08.h),
        Text(
          "Login Success",
          style: headingStyle,
        ),
        const Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth! * 0.6.w,
          child: DefaultButton(
            text: "Back to home",
            button_color: PrimaryColor,
            press: () => Navigator.pushNamed(context, HomeScreen.routeName),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
