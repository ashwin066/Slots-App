import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_ecommerce/screens/profile/components/earning_card.dart';
import 'package:shop_ecommerce/screens/profile/components/profile_menu.dart';
import 'package:shop_ecommerce/screens/profile/components/profile_pic.dart';
 
import 'package:shop_ecommerce/screens/splash_screen/splash_screen.dart';
import 'package:shop_ecommerce/screens/wishlist/wishlist_screen.dart';
import 'package:shop_ecommerce/service/secure/shared_preferences_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return ListView(children: [
      Column(
        children: [
          SizedBox(height: 20.h,),
          const ProfilePic(),
            SizedBox(height: 20.h),
          EarningCard(
            icon: "assets/icons/Bell.svg",
            text: "EarningCard",
            press: () {},
          ),
          ProfileMenu(
            icon: "assets/icons/User Icon.svg",
            text: "My Account",
            press: () {},
          ),
          ProfileMenu(
            icon: "assets/icons/Heart outline.svg",
            text: "Wishlist",
            press: () {
              Navigator.of(context).push(PageTransition(
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 400),
                  reverseDuration: Duration(milliseconds: 400),
                  childCurrent: widget,
                  child: WishListScreen()));
            },
          ),
          ProfileMenu(
            icon: "assets/icons/Bell.svg",
            text: "Notifications",
            press: () {},
          ),
          ProfileMenu(
            icon: "assets/icons/Settings.svg",
            text: "Settings",
            press: () {},
          ),
          ProfileMenu(
            icon: "assets/icons/Question mark.svg",
            text: "Help Center",
            press: () {},
          ),
          ProfileMenu(
            icon: "assets/icons/Log out.svg",
            text: "Log Out",
            press: () async {
              await _servicePreferences.removeCache("fireBaseUID").whenComplete(
                  () => {
                        _firebaseAuth.signOut(),
                      Navigator.of(context).pushReplacement(PageTransition(
                    type: PageTransitionType.fade,
                    duration: Duration(milliseconds: 550),
                    reverseDuration: Duration(milliseconds: 550),
                    childCurrent: widget,
                    child:MainSplashScreen()))
                      });
            },
          ),
        ],
      ),
    ]);
  }
}
