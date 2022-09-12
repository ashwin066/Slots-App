import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_ecommerce/service/controllers/cart_ID_Controller.dart';


class CartModel extends GetxController {
  final String id;
  final String product_name;
  final String description;
  final double rating;
  final List images;
  final List colors;
  final current_price, mrp;
  final bool isWishlisted, isPopular;
 

  CartModel(
      {required this.id,
      required this.product_name,
      required this.description,
      required this.images,
      required this.colors,
      required this.current_price,
      required this.mrp,
      required this.isWishlisted,
      required this.isPopular,
      required this.rating,
      });

  static CartModel fromSnapshot(QueryDocumentSnapshot snap) {
 

     CartModel product = CartModel(
      id: snap["id"],
      product_name: snap['product_name'],
      description: snap['description'],
      images: snap['images'],
      colors: snap['colors'],
      current_price: snap['current_price'],
      mrp: snap['mrp'],
      rating: snap['rating'],
      isWishlisted: snap['isWishlisted'],
      isPopular: snap['isPopular'],
     );
    return product;
  }

// Our demo Products

//   static List<CartModel> products = [
//   CartModel(
//     id: 1,
//     images: [
//       "assets/images/ps4_console_white_1.png",
//       "assets/images/ps4_console_white_2.png",
//       "assets/images/ps4_console_white_3.png",
//       "assets/images/ps4_console_white_4.png",
//     ],
//     colors: [
//       const Color(0xFFF6625E),
//       const Color(0xFF836DB8),
//       const Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     product_name: "Wireless Controller for PS4™",
//     current_price: 64.99,
//     mrp: 180.9,
//     description: "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …",
//     rating: 4.8,
//     isWishlisted: true,
//     isPopular: true,
//   ),
//   CartModel(
//     id: 2,
//     images: [
//       "assets/images/Image Popular CartModel 2.png",
//     ],
//     colors: [
//       const Color(0xFFF6625E),
//       const Color(0xFF836DB8),
//       const Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     product_name: "Nike Sport White - Man Pant",
//     current_price: 50.5,
//     mrp: 180.9,
//     description: "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …",
//     rating: 4.1,
//     isPopular: true,
//   ),
//   CartModel(
//     id: 3,
//     images: [
//       "assets/images/glap.png",
//     ],
//     colors: [
//       const Color(0xFFF6625E),
//       const Color(0xFF836DB8),
//       const Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     product_name: "Gloves XC Omega - Polygon",
//     current_price: 36.55,
//     mrp: 180.9,
//     description: "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …",
//     rating: 4.1,
//     isWishlisted: true,
//     isPopular: true,
//   ),
//   CartModel(
//     id: 4,
//     images: [
//       "assets/images/wireless headset.png",
//     ],
//     colors: [
//       const Color(0xFFF6625E),
//       const Color(0xFF836DB8),
//       const Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     product_name: "Logitech Head",
//     current_price: 20.20,
//     mrp: 180.9,
//     description: "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …",
//     rating: 4.1,
//     isWishlisted: true,
//   ),
// ];

}
