import 'package:flutter/material.dart';
import 'package:shop_ecommerce/components/bg_box.dart';
import 'package:shop_ecommerce/constants.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key});

    @override
  Widget build(BuildContext context) {
    return BgBox(bgColor: DarkPurple,borderRadius: BorderRadius.zero,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("No Results",style: text16LightFw800,),
            SizedBox(height: 20),
            Text("Sorry, we couldn't find any results.",style: text13LightFw500,),
          ],
        ),
      ),
    );
  }
}