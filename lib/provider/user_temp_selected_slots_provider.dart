import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_ecommerce/models/user_model.dart';
import 'package:shop_ecommerce/models/user_purchased_slots_model.dart';
import 'package:shop_ecommerce/models/user_temp_selected_slots.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/service/secure/shared_preferences_service.dart';

class UserTempSelectedSlotsProvider with ChangeNotifier {
  DocumentSnapshot? doc;
  UserTempSelectedSlotsModel? user;
  FirebaseService _service = FirebaseService();
  getUserTempSelectedSlotsProviderData(String productID) async {
    final ServicePreferences _servicePreferences = ServicePreferences();

    _servicePreferences.readCache("fireBaseUID").then((value) {
      if (value != null) {
        if (FirebaseAuth.instance.currentUser != null)
          FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("user_temp_selected_slots")
              .doc(productID)
              .get()
              .then((document) {
            doc = document;
            print(document);
            user = UserTempSelectedSlotsModel.fromJson(
                document.data() as Map<String, dynamic>);
            notifyListeners();
          });
      }
    });
  }
}
