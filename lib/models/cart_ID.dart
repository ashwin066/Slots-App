import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartIdModel {
  final id;
  final int  quantity;

  CartIdModel({
    required this.id,
    required this.quantity,
  });

  static CartIdModel fromSnapshot(DocumentSnapshot snap) {
    CartIdModel products = CartIdModel(
      id: snap["id"],
      quantity: snap["quantity"]
    );
    return products;
  }
}
