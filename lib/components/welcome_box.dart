import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/provider/user_provider.dart';
import 'package:shop_ecommerce/service/get_user_data/get_user_data.dart';
import 'package:shop_ecommerce/service/secure/shared_preferences_service.dart';

class WelcomeBox extends StatefulWidget {
  const WelcomeBox({super.key});

  @override
  State<WelcomeBox> createState() => _WelcomeBoxState();
}

class _WelcomeBoxState extends State<WelcomeBox> {
  String? firstName;

  @override
  Widget build(BuildContext context) {
    //Userprovider? userData = Provider.of<Userprovider>(context)!=null?Provider.of<Userprovider>(context):null;
    getIt() async {
      final firstname1 = await GetUserData().getUserInfoAsString("firstName");

      setState(() {
        firstName = firstname1!;
      });
    }

    getIt();
    return Container(
      alignment: Alignment.centerLeft,
      padding: paddingMarginLR15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            firstName!=null
                ? "Hello ${firstName}!"
                : "Hello There!",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: text23DarkFw700,
          ),
          Text(
            "Grab your chance to win a product now!",
            style: text15DarkGrayFw400,
          ),
          
        ],
      ),
    );
  }
}
