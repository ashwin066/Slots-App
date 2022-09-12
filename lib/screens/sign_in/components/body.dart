import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_ecommerce/components/no_account_text.dart';
import 'package:shop_ecommerce/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_ecommerce/screens/sign_in/components/sign_in_form.dart';
import 'package:shop_ecommerce/components/social_card.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/sign_in_with_email/sign_in_screen.dart';
import 'package:shop_ecommerce/size_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return  SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight! * 0.04.h),
                Text(
                  "Welcome",
                  style: headingStyle,
                ),
                const Text(
                  "Sign in with your phone number\nor continue with social media / email",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight! * 0.08.h),
                const SignForm(),
                SizedBox(height: SizeConfig.screenHeight! * 0.08.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(
                      icon: "assets/icons/Mail.svg",
                      press: () {
                        Navigator.of(context).push(PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                            //childCurrent: widget,
                            child: SignInWithEmailScreen()));
                      },
                    ),
                    SocialCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () {},
                    ),
                    // SocialCard(
                    //   icon: "assets/icons/facebook-2.svg",
                    //   press: () {},
                    // ),
                    // SocialCard(
                    //   icon: "assets/icons/twitter.svg",
                    //   press: () {},
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
