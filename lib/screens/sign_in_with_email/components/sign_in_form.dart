import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import 'package:page_transition/page_transition.dart';
import 'package:shop_ecommerce/components/custom_suffix_icon.dart';
import 'package:shop_ecommerce/components/default_button.dart';
import 'package:shop_ecommerce/components/form_error.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_ecommerce/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_ecommerce/screens/home/home_screen.dart';
import 'package:shop_ecommerce/service/secure/shared_preferences_service.dart';
//import 'package:shop_ecommerce/screens/home/home_screen.dart';
//import 'package:shop_ecommerce/screens/login_success/login_success_screen.dart';
import 'package:shop_ecommerce/size_config.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final ServicePreferences _servicePreferences = ServicePreferences();
  final FirebaseAuth auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool remember = false;
  final List<String> errors = [];

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

 
  signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);

      var authCredential = userCredential.user;
      if (authCredential!.uid.isNotEmpty) {
        _servicePreferences
            .createCache(auth.currentUser!.uid)
            .whenComplete(() => {
                  if (auth.currentUser!.email != null ||
                      auth.currentUser!.phoneNumber != null &&
                          auth.currentUser!.uid != null)
                    {
                      Navigator.of(context).pushReplacement(PageTransition(
                          type: PageTransitionType.theme,
                          duration: Duration(milliseconds: 600),
                          reverseDuration: Duration(milliseconds: 600),
                          childCurrent: widget,
                          child: HomeScreen()))
                    }
                });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Something is wrong"),
        ));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No user found for that email.'),
        ));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Oops wrong password provided for that user.'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

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
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: PrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value!;
                  });
                },
              ),
              const Text("Remember me"),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
          //FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            button_color: PrimaryColor,
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // If all are valid then go to success screen
                signIn();
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
      decoration: const InputDecoration(
        labelText: "Email",
        labelStyle: TextStyle(color: kTextColor),
        hintText: "Enter your email",
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
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Mail.svg",
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      onSaved: (newValue) => password == newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 6) {
          removeError(error: kShortPassError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return kPassNullError;
        } else if (value.length < 6) {
          addError(error: kShortPassError);
          return kShortPassError;
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(color: kTextColor),
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
    );
  }
}
