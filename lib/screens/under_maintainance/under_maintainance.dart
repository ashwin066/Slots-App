import 'package:flutter/material.dart';
import 'package:shop_ecommerce/components/custom_app_bar.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/under_maintainance/components/body.dart';
import 'package:shop_ecommerce/size_config.dart';

class UnderMaintainance extends StatefulWidget {
  const UnderMaintainance({
    super.key,
  });

  @override
  State<UnderMaintainance> createState() => _UnderMaintainanceState();
}

class _UnderMaintainanceState extends State<UnderMaintainance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         backgroundColor: backgroundColor,
       
        body: Body());
  }
}
