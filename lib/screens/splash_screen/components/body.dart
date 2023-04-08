import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce/components/bg_box.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/tickets.dart';
import 'package:shop_ecommerce/models/user_model.dart';
import 'package:shop_ecommerce/provider/stream_user_tickets.dart';
import 'package:shop_ecommerce/provider/user_provider.dart';
import 'package:shop_ecommerce/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_ecommerce/screens/home/home_screen.dart';
import 'package:shop_ecommerce/screens/main_page/main_page.dart';
import 'package:shop_ecommerce/screens/sign_in/sign_in_screen.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/service/get_user_data/get_user_data.dart';
import 'package:shop_ecommerce/service/secure/shared_preferences_service.dart';
import 'package:shop_ecommerce/size_config.dart';
import 'package:getwidget/getwidget.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  final ServicePreferences _servicePreferences = ServicePreferences();
  late AnimationController _controller;
  Animation<Offset>? offsetAnimation;
  bool animationCompleted = false;

  Widget? goTo;
 
  @override
  void initState() {
    _controller = AnimationController(vsync: this);

    _servicePreferences.readCache("fireBaseUID").then((value) {
      if (value != null) {
        final FirebaseService _service = FirebaseService();

        if (FirebaseAuth.instance.currentUser !=
            null) if (_servicePreferences.readCompletedProfile() == false) {
          setState(() {
            goTo = CompleteProfileScreen();
          });
        } else {
          setState(() {
            goTo = MainScreen();
          });
        }
        ;
      } else {
        setState(() {
          goTo = SignInScreen();
        });
      }
    });
  }

  Widget build(BuildContext context) {
    GetUserData().loadUserData(context);
 
    // _servicePreferences.readUserDataCache("firstname").then((value) {
    //   if (value != null) {

    //   } else {
    //     GetUserData().loadUserData(context);
    //     getData();
    //   }
    // });

    //Provider.of<Userprovider>(context).getUserData();

    return Center(
      child: 
            Lottie.asset(
            "assets/lottie/splash2.json",
            fit: BoxFit.cover,
            controller: _controller,
            onLoaded: (composition) {
              _controller
                ..duration = composition.duration
                ..forward().whenComplete(() {
                  Future<Object> run() async {
                    if (goTo != null) {
                      return Navigator.of(context).pushReplacement(PageTransition(
                          type: PageTransitionType.fade, child: await goTo!));
                    }
                    return run();
                  }

                  run();
                });
            },
            alignment: Alignment.center,
            frameRate: FrameRate.max,
          
      ),
    );
  }
}
