import 'package:flutter/material.dart';
import 'package:shop_ecommerce/components/custom_app_bar.dart';
import 'package:shop_ecommerce/components/default_button.dart';
import 'package:shop_ecommerce/components/simmerContainer.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/all_view/all_view.dart';
import 'package:shop_ecommerce/screens/details/components/top_rounded_container.dart';
import 'package:shop_ecommerce/screens/slot_selection/components/body.dart';
import 'package:shop_ecommerce/service/get_user_data/get_user_data.dart';
import 'package:shop_ecommerce/size_config.dart';

class SlotSelection extends StatefulWidget {
  const SlotSelection({
    super.key,
    required this.id,
    required this.quantity,
    required this.totalTicketsRequired,
    required this.rupeesRequired,
    this.productTitle,
  });
  static String routeName = "/slot_selection";

  final String id;
  final int quantity;
  final int totalTicketsRequired;
  final double rupeesRequired;
  final String? productTitle;
  @override
  State<SlotSelection> createState() => _SlotSelectionState();
}

class _SlotSelectionState extends State<SlotSelection> {
  String? email;
  @override
  void initState() {
    super.initState();
    getIt() async {
      final email11 = await GetUserData().getUserInfoAsString("email");
      setState(() {
        email = email11!;
      });
    }

    getIt();
  }

  @override
  Widget build(BuildContext context) {
    return AllView(
      body: Body(
        email1: email ?? "",
        id: widget.id,
        quantity: widget.quantity,
        totalTicketsRequired: widget.totalTicketsRequired,
        rupeesRequired: widget.rupeesRequired,
        productTitle: widget.productTitle,
      ),
    );
  }
}
