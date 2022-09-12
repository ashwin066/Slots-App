import 'package:flutter/material.dart';
import 'package:shop_ecommerce/screens/sign_in_with_email/components/body.dart';

class SignInWithEmailScreen extends StatelessWidget {
  const SignInWithEmailScreen({Key? key}) : super(key: key);

  static String routeName = "/sign_in_with_email";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: const Body(),
    );
  }
}
