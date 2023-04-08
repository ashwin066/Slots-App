import 'package:flutter/material.dart';
import 'package:shop_ecommerce/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_ecommerce/screens/details/details_screen.dart';
import 'package:shop_ecommerce/screens/home/home_screen.dart';
import 'package:shop_ecommerce/screens/main_page/main_page.dart';
import 'package:shop_ecommerce/screens/my_tickets/my_tickets.dart';
import 'package:shop_ecommerce/screens/otp/otp_screen.dart';
import 'package:shop_ecommerce/screens/profile/profile_screen.dart';
import 'package:shop_ecommerce/screens/see_all_screen/see_all_screen.dart';
 import 'package:shop_ecommerce/screens/sign_in/sign_in_screen.dart';
import 'package:shop_ecommerce/screens/slot_selection/slot_selection.dart';
import 'package:shop_ecommerce/screens/splash_screen/splash_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  MainScreen.routeName: (context) =>   MainScreen(),

  HomeScreen.routeName: (context) => const HomeScreen(),
  MainSplashScreen.routeName: (context) =>   MainSplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  OTPScreen.routeName: (context) =>   OTPScreen(""),
  DetailsScreen.routeName: (context) => const DetailsScreen(
        id: "",
      ),
  MyTickets.routeName: (context) => const MyTickets(),
  SeeAllScreen.routeName: (context) => const SeeAllScreen(),
  SlotSelection.routeName: (context) => const SlotSelection(id: "",quantity: 0,
        totalTicketsRequired: 0,rupeesRequired: 0,),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
};
