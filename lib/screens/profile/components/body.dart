import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce/components/default_button.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/main.dart';
import 'package:shop_ecommerce/models/tickets.dart';
import 'package:shop_ecommerce/screens/customer_support/customer_support.dart';
import 'package:shop_ecommerce/screens/profile/components/profile_card.dart';
import 'package:shop_ecommerce/screens/profile/components/profile_menu.dart';
import 'package:shop_ecommerce/screens/sign_in/sign_in_screen.dart';
import 'package:shop_ecommerce/screens/splash_screen/splash_screen.dart';
 import 'package:shop_ecommerce/screens/user_transactions/transactions.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/service/secure/shared_preferences_service.dart';
import 'package:shop_ecommerce/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final ServicePreferences _servicePreferences = ServicePreferences();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    FirebaseService _service = FirebaseService();

    List<String> icons = [
      "assets/icons/Bill Icon.svg",
      //   "assets/icons/Bell.svg",
      "assets/icons/info icon.svg",
      "assets/icons/Question mark.svg",
      "assets/icons/Log out.svg",
    ];
    List<String> menuName = [
      "Transactions",
      "About us",
      "Support",
      "Sign Out",
    ];
    List<dynamic> onPress = [
      () {
        Navigator.of(context).push(PageTransition(
            type: PageTransitionType.fade, child: Transactions()));
      },
      //  () {},
      () {
       _service.launchMyUrl("https://foundyo-52bc1.web.app/about-us.html",
            LaunchMode.inAppWebView);
      },
      () {
        Navigator.of(context).push(PageTransition(
            type: PageTransitionType.fade, child:  CustomerSupport()));
      },
      () {
        _service.showAlertDialog(
            context,
            "Sign Out",
            "Are you sure want to sign out?",
            "No",
            () {
              Navigator.pop(context);
            },
            "Yes",
            () async {
              await _servicePreferences.removeAllCache().whenComplete(() => {
                    _firebaseAuth.signOut().then((value) {
                      Navigator.of(context).pushReplacement(PageTransition(
                          type: PageTransitionType.fade,
                          child: SignInScreen()));
                    }),
                  });
            });
      },
    ];
    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenHeight(5),
        ),
        ProfileCard(
          text: "EarningCard",
          press: () {},
        ),
        SizedBox(
          height: getProportionateScreenHeight(17),
        ),
        ...List.generate(
          menuName.length,
          (index) {
            return ProfileMenu(
              icon: icons[index],
              text: menuName[index],
              press: onPress[index],
            );
          },
        ),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        Column(
          children: [
            Text(
              "Made with ❤️ in India",
              style: text13DarkGrayFw500,
            ),
            SizedBox(
              height: getProportionateScreenHeight(5),
            ),
            TextButton(
              onPressed: () {
               _service.launchMyUrl(
                    "https://play.google.com/store/apps/details?id=com.rapido.passenger",
                    LaunchMode.externalApplication);
              },
              child: Text(
                "   Rate us   ",
                style: text13LightFw500,
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(borderRadius: borderRadius8)),
                backgroundColor: MaterialStateProperty.all(ProffesionalGreen),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(5),
            ),
            Text(
              "ⓒ TheNull Technologies Private Limited",
              style: text12DarkGrayFw400,
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    return Text(
                      'Version: ${snapshot.data!.version} | ${snapshot.data!.appName}',
                      style: text12LightGrayFw400,
                    );
                  default:
                    return const SizedBox();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
