import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_ecommerce/components/custom_suffix_icon.dart';
import 'package:shop_ecommerce/components/default_button.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_ecommerce/screens/home/home_screen.dart';
import 'package:shop_ecommerce/size_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({Key? key}) : super(key: key);

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
  final List<String> errors = [];

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  sendUserDataToDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users");
    return _collectionRef.doc(currentUser!.uid).collection("users-form-data").doc().set({
      "firstname": _firstNameController.text,
      "lastname": _lastNameController.text,
      "email": _emailController.text,
      "phonenumber": _phoneNumberController.text,
      "address": _addressController.text,
      "joined_on": Timestamp.now(),
    }).then((value) => Navigator.of(context)
        .pushReplacement(PageTransition(
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 550),
            reverseDuration: Duration(milliseconds: 550),
            childCurrent: widget,
            child: HomeScreen()))
        .catchError((error) => print("Something is wrong")));
  }

  @override
  void initState() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    // TODO: implement initState
    super.initState();
    // Step 2 <- SEE HERE
    _emailController.text =
        currentUser!.email == null ? "" : currentUser.email.toString();
    _phoneNumberController.text = 
    currentUser.phoneNumber == null ? "" : currentUser.phoneNumber.toString();
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

    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          currentUser!.email == null
              ? buildEmailFormField()
              : buildPhoneNumberFormField(),

          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          //FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
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

  TextFormField buildAddressFormField() {
    return TextFormField(
      controller: _addressController,
      onSaved: (newValue) => address == newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return kAddressNullError;
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Address",
        labelStyle: TextStyle(color: kTextColor),
        hintText: "Enter your address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Location point simple.svg",
        ),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    //from firebase

    return TextFormField(
      controller: _phoneNumberController,
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
              style: TextStyle(color: aBlack.withOpacity(0.5), fontSize: 14.sp))
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
      controller: _emailController,
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
      controller: _lastNameController,
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
      controller: _firstNameController,
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
}
