import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_ecommerce/size_config.dart';

const Color PrimaryColor = Color(0xFF343434);
const Color SecondaryColor = Color(0xFF00AEFF);
const Color LightSecondaryColor = Color.fromARGB(255, 208, 240, 255);

const Color GlowBlue = Color(0xFF00C8FF);
const Color YellowColor = Color.fromARGB(255, 255, 174, 0);
const Color kPrimaryLightColor = Color(0xFFFFECDF);
const Color DarkGray = Color.fromARGB(255, 31, 31, 31);
const Color LightGray = Color.fromARGB(255, 136, 136, 136);
const Color MuchLightGray = Color.fromARGB(255, 242, 242, 242);

const Color kTextColor = Color.fromARGB(255, 185, 185, 185);
const Color aWhite = Color(0xFFFFFFFF);
const Color tWhite = Color(0xFFFFFFFF);
const Color aBlack = Color(0xFF000000);
const Color tBlack = Color(0xFF000000);
const Color Success = Color.fromARGB(255, 126, 210, 0);
const Color TomatoRed = Color.fromARGB(255, 255, 111, 111);
const Color LightRed = Color(0xFFFFE6E6);
const Color backgroundColor = Color.fromARGB(255, 255, 208, 235);
const Color backgroundColorLight = Color(0xFFF2FAFF);

const LinearGradient kPrimaryGradientColor = LinearGradient(
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  colors: [
    backgroundColorLight,
    SecondaryColor,
  ],
);
const LinearGradient k1GradientColor = LinearGradient(
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  colors: [
    SecondaryColor,
    backgroundColorLight,
  ],
);
const LinearGradient kBlackGradientColor = LinearGradient(
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  colors: [
    aBlack,
    aBlack,
  ],
);
const String google_api_key = "AIzaSyD63a3gVLviNVW1RTMQgCG4OwaV2ZYakxE";

 final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
 


const Duration kAnimationDuration = Duration(milliseconds: 200);

final TextStyle headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kShortPhoneNumberError = "Please enter a valid Phone Number";
const String kAddressNullError = "Please Enter your address";

final InputDecoration otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: kTextColor),
  );
}
