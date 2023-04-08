import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/size_config.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key, required this.imageUrl,
  }) : super(key: key);
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(65),
      width: getProportionateScreenHeight(65),
      child: ClipRRect(
        borderRadius: borderRadius150,
        child: Image.asset(
          "assets/images/Profile Image.png",
          height: getProportionateScreenHeight(80),
          width: getProportionateScreenHeight(80),
        ),
      ),
    );
  }
}
