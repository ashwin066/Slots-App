import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shop_ecommerce/models/cart.dart';
import 'package:shop_ecommerce/models/cart_ID.dart';
import 'package:shop_ecommerce/service/controllers/cart_ID_Controller.dart';

class FirestoreCartDB extends GetxController {
  // Initialise Firebase Cloud Firestore

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final cartIdController = Get.put(CartIdController());

  Stream<List<CartModel>> getAllProducts() {
    List data = cartIdController.products.map((message) => message.id).toList();

    print(data);
    
      return _firebaseFirestore
          .collection('Product Data')
          .where("id", whereIn: data.length>0?data:[""])
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => CartModel.fromSnapshot(doc)).toList();
      });
    
   
  }
}
