import 'package:flutter/material.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    required this.button_color,
    this.text_color,
    required this.press,
  }) : super(key: key);

  final String text;
  final GestureTapCallback press;
  final Color button_color;
  final Color? text_color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(53),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: button_color,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius13,
          ),
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
              fontSize: getProportionateScreenWidth(18),fontWeight: FontWeight.w500,
              color: text_color == null ? aWhite : text_color),
        ),
      ),
    );
  }
}
