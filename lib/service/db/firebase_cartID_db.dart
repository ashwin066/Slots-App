import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_ecommerce/models/cart_ID.dart';

class FirestoreCartIdDB {
  // Initialise Firebase Cloud Firestore

  var currentUser = FirebaseAuth.instance.currentUser;
  Stream<List<CartIdModel>> getAllProducts() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users");
    return _collectionRef
        .doc(currentUser!.uid)
        .collection("users-cart-items")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => CartIdModel.fromSnapshot(doc)).toList();
    });
  }
}
