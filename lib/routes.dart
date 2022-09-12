import 'package:flutter/material.dart';
import 'package:shop_ecommerce/screens/cart/cart_screen.dart';
import 'package:shop_ecommerce/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_ecommerce/screens/details/details_screen.dart';
import 'package:shop_ecommerce/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_ecommerce/screens/home/home_screen.dart';
import 'package:shop_ecommerce/screens/login_success/login_success_screen.dart';
import 'package:shop_ecommerce/screens/otp/otp_screen.dart';
import 'package:shop_ecommerce/screens/profile/profile_screen.dart';
import 'package:shop_ecommerce/screens/search/search_screen.dart';
import 'package:shop_ecommerce/screens/sign_in/sign_in_screen.dart';
import 'package:shop_ecommerce/screens/sign_up/sign_up_screen.dart';
import 'package:shop_ecommerce/screens/splash/splash_screen.dart';
import 'package:shop_ecommerce/screens/splash_screen/splash_screen.dart';
import 'package:shop_ecommerce/screens/wishlist/wishlist_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  MainSplashScreen.routeName: (context) => const MainSplashScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  OTPScreen.routeName: (context) =>  const OTPScreen(""),
  HomeScreen.routeName: (context) => const HomeScreen(),
  SearchScreen.routeName: (context) => const SearchScreen(),
  DetailsScreen.routeName: (context) => const DetailsScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
  WishListScreen.routeName: (context) => const WishListScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
};
