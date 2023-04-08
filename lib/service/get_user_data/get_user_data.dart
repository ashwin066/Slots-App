import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce/models/user_model.dart';
import 'package:shop_ecommerce/provider/user_provider.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';
import 'package:shop_ecommerce/service/secure/shared_preferences_service.dart';

class GetUserData with ChangeNotifier {
  Map<String, dynamic>? myData;
  final ServicePreferences _servicePreferences = ServicePreferences();
  UserModel? user;

  Future<String>? getUserInfoAsString(
      String whatDataYouWantTypeInString) async {
    String? value1;

  await  _servicePreferences
        .readUserDataCache(whatDataYouWantTypeInString)
        .then((value) {
      value1 = value;
      //print(getUserInfoAsString("email"));
      // return value;
    });
 
    return value1 ?? "404";
  }
 
  loadUserData(BuildContext context) async {
    _servicePreferences.readUserDataCache("firstname").then((value) async {
      if (value == null) {
        GetUserData().getUserData();
      }
    });
  }

  getUserData() async {
    _servicePreferences.readCache("fireBaseUID").then((value) {
      if (value != null) {
        if (FirebaseAuth.instance.currentUser != null) {
          FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("user_info")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get()
              .then((document) async {
            myData = document.data() as Map<String, dynamic>;
            await _servicePreferences.createUserData(myData!["firstname"],
                myData!["lastname"], myData!["phonenumber"], myData!["email"]);
          });
        }
      }
    });
  }
}
