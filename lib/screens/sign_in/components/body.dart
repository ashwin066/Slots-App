import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/sign_in/components/sign_in_form.dart';
import 'package:shop_ecommerce/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                    height: SizeConfig.screenHeight! *
                        getProportionateScreenHeight(.1)),
                Text(
                  "Welcome",
                  style: headingStyle,
                ),
                const Text(
                  "Sign in with your phone number",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight! * 0.08.h),
                const SignForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
