import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/search/search_screen.dart';
import 'package:shop_ecommerce/size_config.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth! * 0.6,
      decoration: BoxDecoration(
        color: aWhite.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        readOnly: true,
        onTap: ()=>{
            Navigator.of(context)
          .pushReplacement(PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            duration: Duration(milliseconds: 450),
            reverseDuration: Duration(milliseconds: 400),
            child: SearchScreen())) 
        },
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "Search Product",
          prefixIcon: const Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenWidth(12),
          ),
        ),
      ),
    );
  }
}
