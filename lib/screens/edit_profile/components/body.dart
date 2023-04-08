import 'package:flutter/material.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/complete_profile/components/complete_profile_form.dart';
import 'package:shop_ecommerce/size_config.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: paddingMarginLR15,
        child: Column(
          children: [
             Text(
              "Edit Profile",
              style: headingStyle,
            ),
            const Text(
              "Edit your details here",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.screenHeight! * 0.05),
    
            CompleteProfileForm(typeIsEdit: true,),
          ],
        ),
      ),
    );
  }
}