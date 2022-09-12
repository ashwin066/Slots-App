import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_ecommerce/components/default_button.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/get_put_data/add_to_cart_wishlist.dart';
import 'package:shop_ecommerce/screens/details/components/color_dots.dart';
import 'package:shop_ecommerce/screens/details/components/product_description.dart';
import 'package:shop_ecommerce/screens/details/components/product_image.dart';
import 'package:shop_ecommerce/screens/details/components/top_rounded_container.dart';
import 'package:shop_ecommerce/service/controllers/cartController.dart';
import 'package:shop_ecommerce/service/controllers/cart_ID_Controller.dart';
  import 'package:shop_ecommerce/size_config.dart';

class Body extends StatelessWidget {
    Body({Key? key, required this.product}) : super(key: key);
  final product;

  @override
  Widget build(BuildContext context) {
  //  final controller = Get.put(CartController());
 //  final cartIDController = Get.put(CartIdController());

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(), // new

        children: [
          Container(
              margin: EdgeInsets.only(top: 10),
              child: ProductImages(product: product)
              ),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  product: product,
                  pressOnSeeMore: () {},
                ),
                TopRoundedContainer(
                  color: const Color(0xFFF6F7F9),
                  child: Column(
                    children: [
                      //   ColorDots(product: product), //check this later
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: TopRoundedContainer(
        color: SecondaryColor.withOpacity(0.2),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: getProportionateScreenWidth(15),
          ),
          child: Row(
            children: [
              Container(
                width: SizeConfig.screenWidth! / 2,
                padding: EdgeInsets.only(left: 15, right: 7.5),
                child: DefaultButton(
                  text: "Buy Now",
                  button_color: PrimaryColor,
                  press: () {},
                ),
              ),
              Container(
                width: SizeConfig.screenWidth! / 2,
                padding: EdgeInsets.only(left: 7.5, right: 15),
                child: DefaultButton(
                  text: "Add To Cart",
                  button_color: SecondaryColor,
                  press: () {
                  //  cartController.addProduct(product);
                    
                    addToUserDB(
                        ProductData: product, whereToAdd: "users-cart-items");
            //  controller.products.refresh();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
