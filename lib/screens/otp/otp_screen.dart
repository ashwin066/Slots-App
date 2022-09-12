import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pinput/pinput.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_ecommerce/screens/home/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_ecommerce/service/secure/shared_preferences_service.dart';
import 'package:shop_ecommerce/size_config.dart';

class OTPScreen extends StatefulWidget {
  final String? phone;
  const OTPScreen(this.phone);
  static String routeName = "/otp";

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
        width: 60.w,
        height: 60.h,
        textStyle:
            TextStyle(fontSize: 20.sp, color: Color.fromRGBO(70, 69, 66, 1)),
        decoration: BoxDecoration(
          color: PrimaryColor.withOpacity(0.14),
          borderRadius: BorderRadius.circular(15.r),
        ));

    final cursor = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 21.w,
        height: 2.h,
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: PrimaryColor,
          borderRadius: BorderRadius.circular(18.r),
        ),
      ),
    );
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight! * 0.05),
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
              padding: const EdgeInsets.all(30.0),
              child: Pinput(
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsRetrieverApi,
                length: 6,
                controller: controller,
                focusNode: focusNode,
                cursor: cursor,
                defaultPinTheme: defaultPinTheme,
                separator: SizedBox(width: 8.w),
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13.r),
                    boxShadow: [
                      BoxShadow(
                        color: aBlack.withOpacity(0.1),
                        offset: Offset(0, 3),
                        blurRadius: 16.r,
                      )
                    ],
                  ),
                ),
                onCompleted: (pin) async {
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: _verificationCode!, smsCode: pin))
                        .then((value) async {
                      if (value.user != null) {
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
                                  if (auth.currentUser!.email != null ||
                                      auth.currentUser!.phoneNumber != null &&
                                          auth.currentUser!.uid != null)
                                    {
                                      FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .collection("users-form-data")
                                          .get()
                                          .then((value) {
                                        setState(() {
                                          if (value.docs.length == 0) {
                                            Navigator.of(context)
                                                .pushReplacement(PageTransition(
                                                    type: PageTransitionType
                                                        .theme,
                                                    duration: Duration(
                                                        milliseconds: 600),
                                                    reverseDuration: Duration(
                                                        milliseconds: 600),
                                                    childCurrent: widget,
                                                    child:
                                                        CompleteProfileScreen()));
                                          } else {
                                            Navigator.of(context)
                                                .pushReplacement(PageTransition(
                                                    type: PageTransitionType
                                                        .theme,
                                                    duration: Duration(
                                                        milliseconds: 600),
                                                    reverseDuration: Duration(
                                                        milliseconds: 600),
                                                    childCurrent: widget,
                                                    child: HomeScreen()));
                                          }
                                        });
                                      }),
                                      print(userFormFilled.toString()),
                                      print("userFormFilled.toString()"),
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
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
              )),
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
        timeout: Duration(seconds: 120));
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
    super.initState();
    startTimer();

    _verifyPhone();
  }
}
