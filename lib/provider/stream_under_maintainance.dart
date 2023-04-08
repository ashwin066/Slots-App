import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_ecommerce/models/under_maintainance_model.dart';
 
class UnderMaintainanceDB {
 
  Stream<UnderMaintainanceModel?>? get underMaintainance {
       return FirebaseFirestore.instance
          .collection("under_maintainance")
          
          .snapshots()
          .map((event) => UnderMaintainanceModel(isUnderMaintainance: event.docs[0]["isUnderMaintainance"]));
  }
}
