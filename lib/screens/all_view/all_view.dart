import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce/models/under_maintainance_model.dart';
import 'package:shop_ecommerce/provider/internet_check_provider.dart';
import 'package:shop_ecommerce/provider/stream_under_maintainance.dart';
import 'package:shop_ecommerce/screens/no_internet/no_internet.dart';
import 'package:shop_ecommerce/screens/under_maintainance/under_maintainance.dart';

class AllView extends StatelessWidget {
  const AllView({super.key, required this.body});
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkStatus>(builder: (context, data, child) {
      return data == NetworkStatus.Online
          ? body
          : NoInternet();
    });
  }
}
