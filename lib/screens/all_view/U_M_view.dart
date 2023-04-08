import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce/models/under_maintainance_model.dart';
import 'package:shop_ecommerce/provider/internet_check_provider.dart';
import 'package:shop_ecommerce/provider/stream_under_maintainance.dart';
import 'package:shop_ecommerce/screens/no_internet/no_internet.dart';
import 'package:shop_ecommerce/screens/under_maintainance/under_maintainance.dart';

class UnderMaintainanceView extends StatelessWidget {
  const UnderMaintainanceView({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Consumer<UnderMaintainanceModel>(builder: (context, data, child1) {
      return data.isUnderMaintainance == false||
              data.isUnderMaintainance == null ? child : UnderMaintainance();

              
    });
  }
}
