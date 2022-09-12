import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/get_put_data/fetch_product_with_id.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget fetchData(
  String collectionName,
  String type,
) {
  List _productData = [];

  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(collectionName)
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      var proID = snapshot.data?.docs.toList() ?? [];
      print("1:>> id length ${proID.length}");
      if (snapshot.hasError) {
        return Center(child: Text("Something went wrong"));
      }
      if (snapshot.data?.docs.length == 0) {
        return Center(child: Text("No products in your ${type.toUpperCase()}"));
      }
      if (snapshot.hasData)  
       return ListView.builder(
            itemCount: proID.length,
            itemBuilder: (context, index) {
              return fetchProductWithId(collectionName, proID[index], type);
            });
      
      return Center(
          heightFactor: 0,
          child: LinearProgressIndicator(
            color: TomatoRed,
            backgroundColor: aBlack,
            minHeight: 9.h,
          ));
    },
  );
}
