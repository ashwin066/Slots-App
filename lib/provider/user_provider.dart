import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_ecommerce/models/user_model.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/service/secure/shared_preferences_service.dart';

class Userprovider with ChangeNotifier {
  DocumentSnapshot? doc;
  UserModel? user;

  getUserDataSharedPref(String firstname, String? lastname, String phonenumber,
      String email) async {
    user =
        await UserModel.fromSharedPref(firstname, lastname, phonenumber, email);
    notifyListeners();
  }

  getUserData() async {
    final ServicePreferences _servicePreferences = ServicePreferences();

    _servicePreferences.readCache("fireBaseUID").then((value) {
      if (value != null) {
        if (FirebaseAuth.instance.currentUser != null) {
          FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("user_info")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get()
              .then((document) {
            user = UserModel.fromJson(document.data() as Map<String, dynamic>);

            notifyListeners();
          });
        }
      }
    });
  }
}
