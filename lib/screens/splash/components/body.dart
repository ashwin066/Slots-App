import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_ecommerce/components/default_button.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/splash.dart';
import 'package:shop_ecommerce/routes.dart';
import 'package:shop_ecommerce/screens/sign_in/sign_in_screen.dart';
import 'package:shop_ecommerce/screens/splash/components/splash_content.dart';
import 'package:shop_ecommerce/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                pageSnapping: true,
                itemCount: splashData.length,
                itemBuilder: (context,index) => SplashContent(
                  text: splashData[index].text,
                  image: splashData[index].image,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                ),
                child: Column(
                  children: [
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    const Spacer(flex: 2),
                    
                    
                    DefaultButton(
                      text: "Continue",
                      button_color: PrimaryColor,
                      press: () {
                         Navigator.of(context).pushReplacement(PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            duration: Duration(milliseconds: 650),
                         
                            childCurrent: widget,
                            child: SignInScreen()));
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? PrimaryColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
