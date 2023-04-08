import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce/components/custom_suffix_icon.dart';
import 'package:shop_ecommerce/components/default_button.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/main.dart';
import 'package:shop_ecommerce/models/tickets.dart';
import 'package:shop_ecommerce/models/user_model.dart';
import 'package:shop_ecommerce/provider/stream_user_tickets.dart';
import 'package:shop_ecommerce/provider/user_provider.dart';
import 'package:shop_ecommerce/screens/splash_screen/splash_screen.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/service/get_user_data/get_user_data.dart';
import 'package:shop_ecommerce/service/secure/shared_preferences_service.dart';
import 'package:shop_ecommerce/size_config.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({Key? key, this.typeIsEdit}) : super(key: key);
  final bool? typeIsEdit;
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? address;
  String? countryValue;
  String? cityValue;
  String? stateValue;
  final List<String> errors = [];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  String  firstname1="";
  String  lastname1 = "";
  String  phonenumber1 = "";
  String  email1 = "";
  
  @override
  void initState() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    // TODO: implement initState
    super.initState();
    getIt() async {
      final firstname = await GetUserData().getUserInfoAsString("firstName");
      final lastname = await GetUserData().getUserInfoAsString("lastName");
      final phonenumber11 = await GetUserData().getUserInfoAsString("phonenumber");
      final email11 = await GetUserData().getUserInfoAsString("email");

      setState(() {
        firstname1 = firstname!;
      });
      setState(() {
        lastname1 = lastname!;
      });
      setState(() {
        phonenumber1 = phonenumber11!;
      });
      setState(() {
        email1 = email11!;
      });
    }

    if (widget.typeIsEdit == true) getIt();
    // Step 2 <- SEE HERE
    _emailController.text =
        currentUser!.email == null ? "" : currentUser.email.toString();
    _phoneNumberController.text = currentUser.phoneNumber == null
        ? ""
        : currentUser.phoneNumber.toString();
  }

  final ServicePreferences _servicePreferences = ServicePreferences();

  FirebaseService _service = FirebaseService();
  sendUserDataToDB() async {
    var currentUser = _auth.currentUser;

    if (widget.typeIsEdit == true) {
      _service.users
          .doc(currentUser!.uid)
          .collection("user_info")
          .doc(currentUser.uid)
          .update({
        "firstname": _firstNameController.text,
        "lastname": _lastNameController.text,
        //  "state": stateValue,
        //   "city": cityValue,
      }).then((value) {
        GetUserData().loadUserData(context);
          Navigator.of(context).pushReplacement(PageTransition(
            type: PageTransitionType.fade, child: MainSplashScreen()));
      });
    } else {
      _service.users
          .doc(currentUser!.uid)
          .collection("user_info")
          .doc(currentUser.uid)
          .set({
        "firstname": _firstNameController.text,
        "lastname": _lastNameController.text,
        "email": _emailController.text,
        "phonenumber": _phoneNumberController.text.replaceAll("+91", ""),
        "state": stateValue,
        "city": cityValue,
        "country": countryValue,
        "joined_on": Timestamp.now(),
        "tickets": FieldValue.increment(10),
      }).then((value) {
        GetUserData().loadUserData(context);
        _servicePreferences.createCompletedProfile(true);
           Navigator.of(context).pushReplacement(PageTransition(
            type: PageTransitionType.fade, child: MainSplashScreen()));
      });
    }
  }

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    TextFormField buildPhoneNumberFormField() {
      //from firebase

      return TextFormField(
        readOnly: widget.typeIsEdit == true ? true : false,
        controller: _phoneNumberController
          ..text = widget.typeIsEdit == true
              ? phonenumber1
              : _phoneNumberController.text,
        keyboardType: TextInputType.phone,
        onSaved: (newValue) => phoneNumber == newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPhoneNumberNullError);
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kPhoneNumberNullError);
            return kPhoneNumberNullError;
          } else if (value.length != 10) {
            addError(error: kShortPhoneNumberError);
            return kShortPhoneNumberError;
          }
          return null;
        },
        maxLength: 10,
        decoration: InputDecoration(
          labelText: "Phone Number",
          counterText: "",
          labelStyle: TextStyle(color: kTextColor),
          hintText: "Enter your phone number",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon:
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("+91",
                style:
                    TextStyle(color: aBlack.withOpacity(0.5), fontSize: 14.sp))
          ]),
          suffixIcon: CustomSuffixIcon(
            svgIcon: "assets/icons/Phone.svg",
          ),
        ),
      );
    }

    TextFormField buildEmailFormField() {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      var currentUser = _auth.currentUser;

      return TextFormField(
        readOnly: widget.typeIsEdit == true ? true : false,
        controller: _emailController
          ..text = widget.typeIsEdit == true
              ? email1!
              : _emailController.text,
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => email == newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kEmailNullError);
          } else if (emailValidatorRegExp.hasMatch(value)) {
            removeError(error: kInvalidEmailError);
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kEmailNullError);
            return kEmailNullError;
          } else if (!emailValidatorRegExp.hasMatch(value)) {
            addError(error: kInvalidEmailError);
            return kInvalidEmailError;
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Email",
          labelStyle: TextStyle(color: kTextColor),
          hintText: "Enter your email address",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: "assets/icons/Mail.svg",
          ),
        ),
      );
    }

    TextFormField buildLastNameFormField() {
      return TextFormField(
        controller: _lastNameController
          ..text = widget.typeIsEdit == true
              ? lastname1!
              : _lastNameController.text,
        onSaved: (newValue) => lastName == newValue,
        decoration: const InputDecoration(
          labelText: "Last Name",
          labelStyle: TextStyle(color: kTextColor),
          hintText: "Enter your last name",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: "assets/icons/User Icon.svg",
          ),
        ),
      );
    }

    TextFormField buildFirstNameFormField() {
      return TextFormField(
        controller: _firstNameController
          ..text = widget.typeIsEdit == true
              ? firstname1!
              : _firstNameController.text,
        onSaved: (newValue) => firstName == newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kNamelNullError);
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kNamelNullError);
            return kNamelNullError;
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "First Name",
          labelStyle: TextStyle(color: kTextColor),
          hintText: "Enter your first name",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: "assets/icons/User Icon.svg",
          ),
        ),
      );
    }

    CSCPicker buildAddressDropDowns() {
      return CSCPicker(
        showStates: true,
        layout: Layout.horizontal,
        dropdownDialogRadius: 14,
        showCities: true,
        flagState: CountryFlag.ENABLE,
        dropdownDecoration: BoxDecoration(
            borderRadius: borderRadius19,
            color: aWhite,
            border: Border.all(color: LightGray, width: 1.1)),
        disabledDropdownDecoration: BoxDecoration(
            borderRadius: borderRadius19,
            color: MuchLightGray,
            border: Border.all(color: MuchLightGray, width: 1.1)),
        countrySearchPlaceholder: "Country",
        stateSearchPlaceholder: "State",
        citySearchPlaceholder: "City",
        countryDropdownLabel: "*India only",
        stateDropdownLabel: "Select State",
        cityDropdownLabel: "Select City",
        defaultCountry: DefaultCountry.India,
        disableCountry: true,
        selectedItemStyle: const TextStyle(
          color: aBlack,
          fontSize: 14,
        ),
        dropdownHeadingStyle: const TextStyle(
            color: aBlack, fontSize: 17, fontWeight: FontWeight.bold),
        dropdownItemStyle: const TextStyle(
          color: aBlack,
          fontSize: 14,
        ),
        searchBarRadius: 27.0,
        onCountryChanged: (value) {
          setState(() {
            countryValue = value;
          });
        },
        onStateChanged: (value) {
          setState(() {
            stateValue = value;
          });
        },
        onCityChanged: (value) {
          setState(() {
            cityValue = value;
          });
        },
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          if (currentUser!.phoneNumber == null) buildPhoneNumberFormField(),
          if (widget.typeIsEdit == true)
            SizedBox(height: getProportionateScreenHeight(30)),
          if (widget.typeIsEdit == true) buildPhoneNumberFormField(),

          if (widget.typeIsEdit != true)
            SizedBox(height: getProportionateScreenHeight(15)),
          if (widget.typeIsEdit != true) Text("*You are from"),
          if (widget.typeIsEdit != true)
            SizedBox(height: getProportionateScreenHeight(5)),

          if (widget.typeIsEdit != true) buildAddressDropDowns(),

          //FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(25)),
          DefaultButton(
            text: "Continue",
            button_color: PrimaryColor,
            press: () {
              if (_formKey.currentState!.validate()) {
                // Go to OTP screen
                //Navigator.pushNamed(context, OTPScreen.routeName);
                sendUserDataToDB();
              }
            },
          ),
        ],
      ),
    );
  }
}
