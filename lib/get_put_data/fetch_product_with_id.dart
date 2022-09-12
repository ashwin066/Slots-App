import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_ecommerce/components/product_item_card.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/get_put_data/remove_from_cart_wishlist.dart';
import 'package:shop_ecommerce/screens/details/details_screen.dart';
import 'package:shop_ecommerce/size_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget fetchProductWithId(
  String collectionName,
  id,
  String type,
) {
  List _productData = [];

  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection("Product Data")
        .where(FieldPath.documentId, isEqualTo: id["id"])
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      var proData = snapshot.data?.docs.toList() ?? [];
      print(snapshot.data?.docs.length);
      if (snapshot.hasError) {
        return Center(child: Text("Something went wrong"));
      }
      if (snapshot.data?.docs.length == 0) {
        return Center(child: Text("No products in your Wishlist"));
      }
      if (snapshot.hasData) {
        var _documentSnapshot = snapshot.data!.docs;
        print("document length : ${_documentSnapshot[0]["id"]}");
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Dismissible(
              onDismissed: (direction) async {
                WriteBatch batch = FirebaseFirestore.instance.batch();

                FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection(collectionName)
                    .where("id", isEqualTo: _documentSnapshot[0]["id"])
                    .get()
                    .then((querySnapshot) {
                  querySnapshot.docs.forEach((document) {
                    batch.delete(document.reference);
                  });

                  return batch.commit();
                });
                ;
              },
              key: Key(_documentSnapshot[0]["id"]), //check this later
              direction: DismissDirection.endToStart,
              background: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: LightRed,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    SvgPicture.asset("assets/icons/Trash.svg"),
                  ],
                ),
              ),
              // onDismissed: (direction) {
              //   setState(() {
              //     demoCarts.removeAt(index);
              //   });
              // },
              child: ProductItemCard(
                  product: _documentSnapshot[0],
                  index: 1,
                  type: type,
                  press: () {
                    Navigator.pushNamed(
                      context,
                      DetailsScreen.routeName,
                      arguments: ProductDetailsArguments(
                          product: _documentSnapshot[0]),
                    );
                  })),
        );
        // return Column(children: [
        //   Expanded(
        //     child: ListView.builder(
        //         itemCount: _documentSnapshot.length,
        //         itemBuilder: (context, index) {
        //           print(id[index]["id"]);

        //           DocumentSnapshot _documentSnapshot =
        //               snapshot.data!.docs[index];
        //           return

        //           Padding(
        //               padding: const EdgeInsets.symmetric(vertical: 10),
        //               child: Dismissible(
        //                   onDismissed: (direction) {
        //                     FirebaseFirestore.instance
        //                         .collection(collectionName)
        //                         .doc(FirebaseAuth.instance.currentUser!.uid)
        //                         .collection("items")
        //                         .doc(_documentSnapshot.id)
        //                         .delete();
        //                   },
        //                   key: Key(_documentSnapshot.id), //check this later
        //                   direction: DismissDirection.endToStart,
        //                   background: Container(
        //                     padding: const EdgeInsets.symmetric(horizontal: 20),
        //                     decoration: BoxDecoration(
        //                       color: LightRed,
        //                       borderRadius: BorderRadius.circular(15),
        //                     ),
        //                     child: Row(
        //                       children: [
        //                         const Spacer(),
        //                         SvgPicture.asset("assets/icons/Trash.svg"),
        //                       ],
        //                     ),
        //                   ),
        //                   // onDismissed: (direction) {
        //                   //   setState(() {
        //                   //     demoCarts.removeAt(index);
        //                   //   });
        //                   // },
        //                   child: ProductItemCard(
        //                       product: _documentSnapshot[0],
        //                       quantity: 1,
        //                       type: type,
        //                       press: () {})
        //                       )
        //                       );
        //         }),
        //   )
        // ]);
      }

      return Center(
          heightFactor: 0,
          child: LinearProgressIndicator(
            color: Success,
            backgroundColor: aBlack,
            minHeight: 9.h,
          ));
    },
  );
}
