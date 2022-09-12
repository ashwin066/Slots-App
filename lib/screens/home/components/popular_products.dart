import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_ecommerce/components/product_card.dart';

import 'package:shop_ecommerce/screens/details/details_screen.dart';
import 'package:shop_ecommerce/screens/home/components/section_title.dart';
import 'package:shop_ecommerce/service/controllers/product_controller.dart';
import 'package:shop_ecommerce/size_config.dart';

class PopularProducts extends StatelessWidget {
  PopularProducts({
    Key? key,
  }) : super(key: key);

  final productController = Get.put(ProductController());

  // List demoProducts = [];

  // fetchProducts() async {
  //   var _firestoreInstance = FirebaseFirestore.instance;
  //   QuerySnapshot qn =
  //       await _firestoreInstance.collection("Product Data").get();
  //   print(demoProducts.toString());
  //   setState(() {
  //     for (int i = 0; i < qn.docs.length; i++) {
  //       demoProducts.add({
  //         "product_name": qn.docs[i]["product_name"],
  //         "id": qn.docs[i]['id'],
  //         "current_price": qn.docs[i]["current_price"],
  //         "mrp": qn.docs[i]["mrp"],
  //         "images": qn.docs[i]["images"],
  //         "description": qn.docs[i]["description"],
  //         "rating": qn.docs[i]["rating"],
  //         "colors": qn.docs[i]["colors"],
  //         "seller": qn.docs[i]["seller"],
  //         "category": qn.docs[i]["category"],
  //         "isPopular": qn.docs[i]["isPopular"],
  //         "isWishlisted": qn.docs[i]["isWishlisted"],
  //         "seller": qn.docs[i]["seller"],
  //       });
  //     }
  //   });

  //   return qn.docs;
  // }

  @override
  Widget build(BuildContext context) {
     return Obx(
      () => Column(
        children: [
          SectionTitle(text: "Popular Products", press: () {}),
          SizedBox(height: getProportionateScreenWidth(20)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  productController.products.length,
                  (index) {
                    //  if (productController.products[index].isPopular) {
                    return ProductCard(
                      index: index,
                      press: () {
                        Navigator.pushNamed(
                          context,
                          DetailsScreen.routeName,
                          arguments: ProductDetailsArguments(
                              product: productController.products[index]),
                        );
                      },
                    );
                    //  }
                    // return SizedBox
                    //     .shrink(); // here by default width and height is 0
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
