import 'package:flutter/material.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/screens/details/components/body.dart';
import 'package:shop_ecommerce/screens/details/components/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;

    return Scaffold(
      backgroundColor: PrimaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height * 1.3.h),
        child: CustomAppBar(),
      ),
      body: Body(product: agrs.product),
    );
  }
}

class ProductDetailsArguments {
  final product;

  ProductDetailsArguments({required this.product});
}
