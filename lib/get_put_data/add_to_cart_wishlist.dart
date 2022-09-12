import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shop_ecommerce/service/controllers/cart_ID_Controller.dart';

class addToUserDB {
  addToUserDB(
      {required ProductData,  required whereToAdd}) {
    
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users");
         _collectionRef
        .doc(currentUser!.uid)
        .collection(whereToAdd)
        .doc(ProductData.id).get().then((value) {
       if (value.exists) {
        _collectionRef
            .doc(currentUser.uid)
            .collection(whereToAdd)
            .doc(ProductData.id)
            .update({
          'id': ProductData.id,
          'quantity': FieldValue.increment(1)
          // 'product_name': ProductData.product_name,
          // 'description': ProductData.description,
          // 'images': ProductData.images,
          // 'colors': ProductData.colors,
          // 'current_price': ProductData.current_price,
          // 'mrp': ProductData.mrp,
          // 'rating': ProductData.rating,
          // 'isWishlisted': ProductData.isWishlisted,
          // 'isPopular': ProductData.isPopular,
        }).then((value) => print("Added to Cart/firebase"));
        }else{
           _collectionRef
            .doc(currentUser.uid)
            .collection(whereToAdd)
            .doc(ProductData.id)
            .set({
          'id': ProductData.id,
          'quantity': FieldValue.increment(1)
         
        }).then((value) => print("Added to Cart/firebase"));
        }
        }
        );
    
  }
}
