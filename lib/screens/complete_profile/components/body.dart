import 'package:flutter/material.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/complete_profile/components/complete_profile_form.dart';
import 'package:shop_ecommerce/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
     return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight! * 0.12),
              Text(
                "Complete Profile",
                style: headingStyle,
              ),
              const Text(
                "Complete your details & continue\nto explore",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.05),
              const CompleteProfileForm(),
              SizedBox(height: getProportionateScreenHeight(30)),
              const Text(
                "By continuing you confirm that your agree\nwith our Term(s) and Condition(s)",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
