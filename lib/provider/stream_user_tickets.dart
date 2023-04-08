import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_ecommerce/models/tickets.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 // FirebaseService _service = FirebaseService();

  Stream<Tickets?>? get tickets {
    if (FirebaseAuth.instance.currentUser != null)
      return   FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("user_tickets")
          //.doc(_service.user!.uid)
          .snapshots()
          .map((event) => Tickets(ticketCount: event.docs[0]["tickets"]));
   
  }
}
