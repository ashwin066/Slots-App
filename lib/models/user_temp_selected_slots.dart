import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';

class UserTempSelectedSlotsModel {
  UserTempSelectedSlotsModel({this.productId, this.tempSlotNo});

  UserTempSelectedSlotsModel.fromJson(Map<String, Object?> json)
      : this(
          productId: json['productId']! as String,
          tempSlotNo: json['tempSlotNo']! as List,
        );

  final String? productId;
  final List? tempSlotNo;

  Map<String, Object?> toJson() {
    return {
      "productId": productId,
      "tempSlotNo": tempSlotNo,
    };
  }
}

FirebaseService _service = FirebaseService();

getUserTempSelectedSlotsModel() {
  return FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("user_temp_selected_slots").doc()
      .withConverter<UserTempSelectedSlotsModel>(
        fromFirestore: (snapshot, _) =>
            UserTempSelectedSlotsModel.fromJson(snapshot.data()!),
        toFirestore: (product, _) => product.toJson(),
      );
}
