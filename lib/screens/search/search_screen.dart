import 'package:flutter/material.dart';
import 'package:shop_ecommerce/screens/search/components/body.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static String routeName = "/search";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SafeArea(child: const Body()),
    );
  }
}
