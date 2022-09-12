import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class removeFromUserDB {
  removeFromUserDB({
    required id,
    required whereToRemove,
  }) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectioRef =
        FirebaseFirestore.instance.collection("users");
    _collectioRef
        .doc(currentUser!.uid)
        .collection(whereToRemove)
        .doc(id)
        .delete()
        .then((value) => print("Removed From Cart/firebase"));
  }
}
