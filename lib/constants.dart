import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_ecommerce/size_config.dart';

const Color PrimaryColor = Color(0xFF343434);
const Color SecondaryColor = Color.fromARGB(255, 1, 213, 255);
const Color LightSecondaryColor = Color.fromARGB(255, 208, 240, 255);
const Color Transparent = Colors.transparent;
const Color GlowBlue = Color(0xFF00C8FF);
const Color DarkPurple = Color(0xFF2A0064);
const Color transparentDarkPurple = Color(0x6C2A0064);
const Color lightDarkPurple = Color(0xFFE5DAF1);
const Color MuchDarkPurple = Color(0xFF14002F);
const Color MediumPinkPurple = Color(0xFFDA9BFF);
const Color MuchLightMediumPinkPurple = Color.fromARGB(255, 246, 229, 255);
const Color MediumPinkPurple2 = Color.fromARGB(255, 89, 0, 141);

const Color YellowColor = Color.fromARGB(255, 255, 166, 0);
const Color kPrimaryLightColor = Color(0xFFFFECDF);
const Color DarkGray = Color.fromARGB(255, 121, 121, 121);
const Color MuchDarkGray = Color.fromARGB(255, 73, 73, 73);
const Color LightGray = Color.fromARGB(255, 200, 200, 200);
const Color MuchLightGray = Color.fromARGB(255, 235, 235, 235);

const Color kTextColor = Color.fromARGB(255, 185, 185, 185);
const Color aWhite = Color(0xFFFFFFFF);
const Color tWhite = Color(0xFFFFFFFF);
const Color aBlack = Color(0xFF000000);
const Color transparentBlack = Color.fromARGB(11, 0, 0, 0);
const Color transparentWhite = Color.fromARGB(173, 255, 255, 255);
const Color tBlack = Color(0xFF000000);
const Color Success = Color.fromARGB(255, 126, 210, 0);
const Color YellowGreen = Color.fromARGB(255, 102, 169, 0);
const Color ProffesionalGreen = Color(0xFF00af54);
const Color DarkProffesionalGreen = Color.fromARGB(255, 0, 133, 64);
const Color TomatoRed = Color.fromARGB(255, 255, 111, 111);
const Color PureRed = Colors.red;
const Color LightRed = Color(0xFFFFE6E6);
const Color backgroundColor = Color.fromARGB(255, 255, 255, 255);
const Color backgroundColorLight = Color(0xFFF2FAFF);

const LinearGradient kPrimaryGradientColor = LinearGradient(
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  colors: [
    backgroundColorLight,
    SecondaryColor,
  ],
);
LinearGradient linearGradient2 = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    DarkPurple,
    aBlack,
  ],
);
LinearGradient linearGradient3 = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Transparent,
    MediumPinkPurple.withOpacity(.34),
  ],
);
LinearGradient linearGradient4 = LinearGradient(
  begin: Alignment.centerRight,
  end: Alignment.centerLeft,
  colors: [
    aBlack.withOpacity(.8),
    MediumPinkPurple,
  ],
);
LinearGradient linearGradient5 = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    MuchDarkPurple,
    DarkPurple,
    MuchDarkPurple,
  ],
);

LinearGradient linearGradient8 = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    DarkPurple,
    aBlack,
  ],
);

const LinearGradient k1GradientColor = LinearGradient(
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  colors: [
    DarkPurple,
    aBlack,
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
  fontSize: getProportionateScreenHeight(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

final TextStyle text20lightFw500 = TextStyle(
  fontSize: getProportionateScreenHeight(20),
  fontWeight: FontWeight.w500,
  color: aWhite,
);
final TextStyle text20DarkGrayFw400 = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w400,
  color: DarkGray,
);
final TextStyle text18lightFw400 = TextStyle(
  fontSize: getProportionateScreenHeight(18),
  fontWeight: FontWeight.w400,
  color: aWhite,
);
final TextStyle text18lightFw500 = TextStyle(
  fontSize: getProportionateScreenHeight(18),
  fontWeight: FontWeight.w500,
  color: aWhite,
);
final TextStyle text18DarkFw500 = TextStyle(
  fontSize: getProportionateScreenHeight(18),
  fontWeight: FontWeight.w500,
  color: aBlack,
);
final TextStyle text20LightGrayFw500 = TextStyle(
  fontSize: getProportionateScreenHeight(20),
  fontWeight: FontWeight.w500,
  color: LightGray,
);
final TextStyle text16LightGrayFw400 = TextStyle(
  fontSize: getProportionateScreenHeight(16),
  fontWeight: FontWeight.w400,
  color: LightGray,
);
final TextStyle text16LightFw400 = TextStyle(
  fontSize: getProportionateScreenHeight(16),
  fontWeight: FontWeight.w400,
  color: aWhite,
);
final TextStyle text16LightFw500 = TextStyle(
  fontSize: getProportionateScreenHeight(16),
  fontWeight: FontWeight.w500,
  color: aWhite,
);
final TextStyle text15RedFw500 = TextStyle(
  fontSize: getProportionateScreenHeight(15),
  fontWeight: FontWeight.w500,
  color: PureRed,
);
final TextStyle text18DarkFw700 = TextStyle(
  fontSize: getProportionateScreenHeight(18),
  fontWeight: FontWeight.w700,
  color: aBlack,
);
final TextStyle text30DarkGrayFw800 = TextStyle(
  fontSize: getProportionateScreenHeight(30),
  fontWeight: FontWeight.w800,
  color: DarkGray.withOpacity(0.6),
);
final TextStyle text30DarkFw800 = TextStyle(
  fontSize: getProportionateScreenHeight(30),
  fontWeight: FontWeight.w900,
  color: aBlack,
);
final TextStyle text20DarkFw500 = TextStyle(
  fontSize: getProportionateScreenHeight(20),
  fontWeight: FontWeight.w500,
  color: aBlack,
);
final TextStyle text20DarkFw700 = TextStyle(
  fontSize: getProportionateScreenHeight(20),
  fontWeight: FontWeight.w700,
  color: aBlack,
);
final TextStyle text20DarkGreyFw700 = TextStyle(
  fontSize: getProportionateScreenHeight(20),
  fontWeight: FontWeight.w700,
  color: DarkGray,
);

final TextStyle text23DarkFw700 = TextStyle(
  fontSize: getProportionateScreenHeight(23),
  fontWeight: FontWeight.w700,
  color: aBlack,
);
final TextStyle text21DarkFw700 = TextStyle(
  fontSize: getProportionateScreenHeight(21),
  fontWeight: FontWeight.w700,
  color: aBlack,
);
final TextStyle text23LightFw700 = TextStyle(
  fontSize: getProportionateScreenHeight(23),
  fontWeight: FontWeight.w700,
  color: aWhite,
);
final TextStyle text15DarkFw500 = TextStyle(
  fontSize: getProportionateScreenHeight(15),
  fontWeight: FontWeight.w300,
  color: aBlack,
);
final TextStyle text15DarkFw800 = TextStyle(
  fontSize: getProportionateScreenHeight(15),
  fontWeight: FontWeight.w800,
  color: aBlack,
);
final TextStyle text15MediumPinkPurpleFw800 = TextStyle(
  fontSize: getProportionateScreenHeight(15),
  fontWeight: FontWeight.w800,
  color: MediumPinkPurple,
);
final TextStyle text16DarkFw500 = TextStyle(
  fontSize: getProportionateScreenHeight(16),
  fontWeight: FontWeight.w300,
  color: aBlack,
);
final TextStyle text16LightFw800 = TextStyle(
  fontSize: getProportionateScreenHeight(16),
  fontWeight: FontWeight.w800,
  color: aWhite,
);
final TextStyle text17DarkFw500 = TextStyle(
  fontSize: getProportionateScreenHeight(17),
  fontWeight: FontWeight.w300,
  color: aBlack,
);
final TextStyle text16DarkGrayFw400 = TextStyle(
  fontSize: getProportionateScreenHeight(16),
  fontWeight: FontWeight.w400,
  color: DarkGray,
);
final TextStyle text25DarkFw500 = TextStyle(
  fontSize: getProportionateScreenHeight(25),
  fontWeight: FontWeight.w500,
  color: aBlack,
);
final TextStyle text11DarkGrayFw400 = TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w400,
  color: DarkGray,
);
final TextStyle text11DarkFw600 = TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w600,
  color: aBlack,
);
final TextStyle text12DarkGrayFw400 = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: DarkGray,
);
final TextStyle text12DarkFw400 = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: aBlack,
);
final TextStyle text12DarkFw600 = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w600,
  color: aBlack,
);
final TextStyle text12LightGrayFw400 = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: LightGray,
);
final TextStyle text9LightGrayFw400 = TextStyle(
  fontSize: 9,
  fontWeight: FontWeight.w400,
  color: LightGray,
);
final TextStyle text13DarkFw500 = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w500,
  color: aBlack,
);
final TextStyle text13RedFw500 = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w500,
  color: PureRed,
);
final TextStyle text13GreenFw500 = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w500,
  color: DarkProffesionalGreen,
);
final TextStyle text13LightFw500 = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w500,
  color: aWhite,
);
final TextStyle text13DarkGrayFw500 = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w500,
  color: DarkGray,
);
final TextStyle text13DarkFw400 = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w400,
  color: aBlack,
);
final TextStyle text15DarkGrayFw400 = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w400,
  color: DarkGray,
);
final TextStyle text13PinkPurpleFw800 = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w900, color: MediumPinkPurple);
final TextStyle text15PurpleFw800 =
    TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: DarkPurple);

const defaultDuration = Duration(milliseconds: 250);
const defaultDuration350 = Duration(milliseconds: 350);
const defaultDurationLate = Duration(milliseconds: 500);
const defaultDuration1sec = Duration(seconds: 1);
const defaultDuration2sec = Duration(seconds: 2);
const defaultDuration1500MilliSec = Duration(milliseconds: 1500);

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
      EdgeInsets.symmetric(vertical: getProportionateScreenHeight(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

EdgeInsets paddingMarginAll20 =
    EdgeInsets.all(getProportionateScreenHeight(20));
EdgeInsets paddingMarginAll15 =
    EdgeInsets.all(getProportionateScreenHeight(15));
EdgeInsets paddingMarginTLR15 = EdgeInsets.only(
    top: getProportionateScreenHeight(15),
    right: getProportionateScreenHeight(15),
    left: getProportionateScreenHeight(15));
EdgeInsets paddingMarginB12LR12 = EdgeInsets.only(
    bottom: getProportionateScreenHeight(12),
    right: getProportionateScreenHeight(12),
    left: getProportionateScreenHeight(12));
EdgeInsets paddingMarginL15 =
    EdgeInsets.only(left: getProportionateScreenHeight(15));
EdgeInsets paddingMarginR5 =
    EdgeInsets.only(right: getProportionateScreenHeight(15));
EdgeInsets paddingMarginTB15 = EdgeInsets.symmetric(
  vertical: getProportionateScreenHeight(15),
);
EdgeInsets paddingMarginT12 = EdgeInsets.only(
  top: getProportionateScreenHeight(12),
);

EdgeInsets paddingMarginAll8 = EdgeInsets.all(getProportionateScreenHeight(8));
EdgeInsets paddingMarginAll3 = EdgeInsets.all(getProportionateScreenHeight(3));
EdgeInsets paddingMarginLR20 =
    EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(20));
EdgeInsets paddingMarginLR15 =
    EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(15));
EdgeInsets paddingMarginLR11 =
    EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(11));
EdgeInsets paddingMarginLR11TB3 = EdgeInsets.symmetric(
    horizontal: getProportionateScreenHeight(11),
    vertical: getProportionateScreenHeight(3));
EdgeInsets paddingMarginLR8 =
    EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(8));

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenHeight(15)),
    borderSide: const BorderSide(color: kTextColor),
  );
}

BorderRadius borderRadius50 = BorderRadius.circular(50);
BorderRadius borderRadius19 = BorderRadius.circular(19);
BorderRadius borderRadius150 = BorderRadius.circular(150);
BorderRadius borderRadius18 = BorderRadius.circular(18);
BorderRadius borderRadiusLR18 = BorderRadius.only(
  topLeft: Radius.circular(18),
  topRight: Radius.circular(18),
);
BorderRadius borderRadiusLR15 = BorderRadius.only(
  bottomLeft: Radius.circular(15),
  bottomRight: Radius.circular(15),
);

BorderRadius borderRadius13 = BorderRadius.circular(13);
BorderRadius borderRadius6 = BorderRadius.circular(6);
BorderRadius borderRadius2 = BorderRadius.circular(2);
BorderRadius borderRadius8 = BorderRadius.circular(8);
BorderRadius borderRadius10 = BorderRadius.circular(10);

Border border0by8lightGray = Border.all(width: .65, color: LightGray);
Border borderBottom0by8lightGray = Border(
  bottom: BorderSide(width: .65, color: LightGray),
);
Border borderBottomTop0by8lightGray = Border(
  bottom: BorderSide(width: .65, color: LightGray),
  top: BorderSide(width: .65, color: LightGray),
);
