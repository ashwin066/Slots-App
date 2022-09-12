import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_ecommerce/models/product.dart';
 

class FirestoreDB {
  // Initialise Firebase Cloud Firestore
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Product>> getAllProducts() {
    return _firebaseFirestore
        .collection('Product Data')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
    
  }
}
