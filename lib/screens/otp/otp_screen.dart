import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/getwidget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce/components/simmer.dart';
import 'package:shop_ecommerce/components/simmerContainer.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/main.dart';
import 'package:shop_ecommerce/models/tickets.dart';
import 'package:shop_ecommerce/models/user_model.dart';
import 'package:shop_ecommerce/provider/stream_user_tickets.dart';
import 'package:shop_ecommerce/provider/user_provider.dart';
import 'package:shop_ecommerce/screens/all_view/all_view.dart';
import 'package:shop_ecommerce/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_ecommerce/screens/main_page/main_page.dart';
import 'package:shop_ecommerce/screens/splash_screen/splash_screen.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/service/get_user_data/get_user_data.dart';
import 'package:shop_ecommerce/service/secure/shared_preferences_service.dart';
import 'package:shop_ecommerce/size_config.dart';

class OTPScreen extends StatefulWidget {
  final String? phone;

  OTPScreen(this.phone);

  static String routeName = "/otp";
  DateTime? currentBackPressTime;

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final ServicePreferences _servicePreferences = ServicePreferences();

  int start = 30;
  bool wait = true;
  String buttonName = "Resend Otp in";

  int? userFormFilled;

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode;
  int? _resendToken;

  final TextEditingController _pinPutController = TextEditingController();

  final controller = TextEditingController();
  final focusNode = FocusNode();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: getProportionateScreenHeight(50),
      height: getProportionateScreenHeight(52),
      textStyle: text23DarkFw700,
      decoration: BoxDecoration(
        color: MuchLightGray.withOpacity(.78),
        borderRadius: borderRadius10,
      ),
    );

    final cursor = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: getProportionateScreenHeight(26),
        height: getProportionateScreenHeight(3),
        margin: EdgeInsets.only(bottom: getProportionateScreenHeight(8)),
        decoration: BoxDecoration(
          color: DarkPurple,
          borderRadius: borderRadius10,
        ),
      ),
    );

    return WillPopScope(
      onWillPop: (() async {
        DateTime now = DateTime.now();

        if (widget.currentBackPressTime == null ||
            now.difference(widget.currentBackPressTime!) >
                defaultDuration2sec) {
          widget.currentBackPressTime = now;
          Fluttertoast.showToast(
              msg: "Press again to exit",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: DarkPurple,
              textColor: aWhite,
              fontSize: 16.0);
          return Future.value(false);
        }
        exit(0);
      }),
      child: AllView(
        body: Scaffold(
          backgroundColor: backgroundColor,
          key: _scaffoldkey,
          body: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight! * 0.14),
              Text(
                "OTP Verification",
                style: headingStyle,
              ),
              Text("We sent your code to"),
              Text(
                "+91 ${widget.phone}",
                style: TextStyle(color: PrimaryColor),
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.15),
              Padding(
                  padding: paddingMarginAll20,
                  child: _verificationCode != null
                      ? Pinput(
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp("[0-9a-zA-Z]")),
                          ],
                          // Only numbers can be entered
                          autofocus: true,
                          enabled: _verificationCode != null ? true : false,
                          androidSmsAutofillMethod:
                              AndroidSmsAutofillMethod.smsRetrieverApi,
                          length: 6,
                          controller: controller,
                          focusNode: focusNode,
                          cursor: cursor,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: defaultPinTheme.copyWith(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: borderRadius10,
                              boxShadow: [
                                BoxShadow(
                                  color: DarkPurple.withOpacity(.2),
                                  offset: Offset(0, 3),
                                  blurRadius: 16,
                                )
                              ],
                            ),
                          ),
                          separator: SizedBox(width: 8.w),
                          showCursor: true,

                          onCompleted: (pin) async {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithCredential(
                                      PhoneAuthProvider.credential(
                                          verificationId: _verificationCode!,
                                          smsCode: pin))
                                  .then((value) async {
                                if (value.user != null) {
                                  EasyLoading.showSuccess("  Success  ");
                                  if (mounted) {
                                    setState(() {
                                      start = 0;
                                      wait = false;
                                      buttonName = "Logged In Successfully";
                                    });
                                  }

                                  _servicePreferences
                                      .createCache(auth.currentUser!.uid)
                                      .whenComplete(() => {
                                            if (auth.currentUser!.email !=
                                                    null ||
                                                auth.currentUser!.phoneNumber !=
                                                        null &&
                                                    auth.currentUser!.uid !=
                                                        null)
                                              {
                                                FirebaseFirestore.instance
                                                    .collection("users")
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .collection("user_info")
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .get()
                                                    .then((value) async {
                                                  if (value.data() == null) {
                                                    _servicePreferences
                                                        .createCompletedProfile(
                                                            false);

                                                    Navigator.of(context)
                                                        .pushReplacement(PageTransition(
                                                            type:
                                                                PageTransitionType
                                                                    .theme,
                                                            duration:
                                                                defaultDuration,
                                                            reverseDuration:
                                                                defaultDuration,
                                                            child:
                                                                CompleteProfileScreen()));
                                                  } else {
                                          
                                                    _servicePreferences
                                                        .createCompletedProfile(
                                                            true);
                                                    Navigator.of(context)
                                                        .pushReplacement(PageTransition(
                                                            type:
                                                                PageTransitionType
                                                                    .fade,
                                                            child:
                                                                MainSplashScreen()));
                                                  }
                                                  ;
                                                }),
                                                print(
                                                    userFormFilled.toString()),
                                              }
                                          });
                                  // Navigator.of(context).pushReplacement(PageTransition(
                                  //     type: PageTransitionType.fade,
                                  //     duration: Duration(milliseconds: 550),
                                  //     reverseDuration: Duration(milliseconds: 550),
                                  //     childCurrent: widget,
                                  //     child: CompleteProfileScreen()));
                                }
                              });
                            } catch (e) {
                              //  ScaffoldMessenger.of(context).showSnackBar(
                              //      SnackBar(content: Text(e.toString())));
                              EasyLoading.showError("Entered OTP is invalid");
                            }
                          },
                        )
                      : SizedBox(
                          height: getProportionateScreenHeight(70),
                          width: double.infinity,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: DarkPurple,
                            ),
                          ))),
              SizedBox(height: SizeConfig.screenHeight! * 0.1),
              TextButton(
                onPressed:
                    // Resend OTP
                    wait
                        ? null
                        : () async {
                            if (mounted) {
                              setState(() {
                                start = 30;
                                wait = true;
                                buttonName = "Resend OTP in";
                              });
                            }

                            _resendOTP();
                          },
                child: Text(
                  wait ? "${buttonName} ${start}" : buttonName,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: wait ? aBlack.withOpacity(0.4) : PrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _resendOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${widget.phone?.trim().toString()}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) async {
        _verificationCode = verificationId;
        _resendToken = resendToken;
      },
      timeout: const Duration(seconds: 30),
      forceResendingToken: _resendToken,
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = _verificationCode.toString();
      },
    );
    debugPrint("_verificationCode: $_verificationCode");
    return true;
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone?.trim().toString()}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CompleteProfileScreen()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 90));
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);

    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        if (mounted) {
          setState(() {
            buttonName = "Resend OTP";
            wait = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            start--;
          });
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    startTimer();

    _verifyPhone();
    super.initState();
  }
}
