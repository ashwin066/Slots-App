import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

class MyFirestoreQueryBuilder extends StatelessWidget {
  const MyFirestoreQueryBuilder(
      {super.key, required this.query, required this.child});

  final Query query;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder(
        query: query,
        builder: (context, snapshot, _) {
          if (snapshot.isFetching) {
            return Center(child: const CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          }

          return child;
        });
  }
}
