import 'package:flutter/material.dart';
import 'package:shop_ecommerce/screens/home/components/popular_products.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return PopularProducts(needGrid:true);
  }
}