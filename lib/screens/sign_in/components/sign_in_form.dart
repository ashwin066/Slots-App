import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_ecommerce/components/custom_suffix_icon.dart';
import 'package:shop_ecommerce/components/default_button.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/otp/otp_screen.dart';
//import 'package:shop_ecommerce/screens/home/home_screen.dart';
//import 'package:shop_ecommerce/screens/login_success/login_success_screen.dart';
import 'package:shop_ecommerce/size_config.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? phone;
  String? password;
  bool remember = false;
  final List<String> errors = [];

  TextEditingController _phoneController = TextEditingController();

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),

          //FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            button_color: PrimaryColor,
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // If all are valid then go to success screen
                //  signIn();
                Navigator.of(context).pushReplacement(PageTransition(
                    type: PageTransitionType.fade,
                    duration: Duration(milliseconds: 550),
                    reverseDuration: Duration(milliseconds: 550),
                    childCurrent: widget,
                    child: OTPScreen(_phoneController.text)));
                // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
      ],
      // Only numbers can be entered
      autofocus: true,
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phone == newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        return;
      },
      maxLength: 10,

      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return kPhoneNumberNullError;
        } else if (value.trim().toString().length != 10) {
          addError(error: kShortPhoneNumberError);
          return kShortPhoneNumberError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone",
        labelStyle: TextStyle(color: kTextColor),
        hintText: "Enter your Phone Number",
        // If you are using latest version of flutter then lable text and hint text shown like
        // If you are using flutter less then 1.20.* then maybe this is not working properly
        // If we are define our floatingLabelBehevior in our theme then it's not applied
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // REMOVE if declaring in the theme for general use
        // contentPadding: const EdgeInsets.symmetric(
        //   horizontal: 42,
        //   vertical: 20,
        // ),
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(28),
        //   borderSide: const BorderSide(color: kTextColor),
        //   gapPadding: 10,
        // ),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(28),
        //   borderSide: const BorderSide(color: kTextColor),
        //   gapPadding: 10,
        // ),
        prefixIcon:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("+91",
              style: TextStyle(color: aBlack.withOpacity(0.5), fontSize: 14.sp))
        ]),
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Call.svg",
        ),
      ),
    );
  }
}
