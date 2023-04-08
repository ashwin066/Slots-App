import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';

class UserPurchasedSlotsModel {
  UserPurchasedSlotsModel(
      {this.productId,
      this.slotNo});

  UserPurchasedSlotsModel.fromJson(Map<String, Object?> json)
      : this(
          productId: json['productId']! as String,
          slotNo: json['slotNo']! as List,
        
        );

  final String? productId;
  final List? slotNo;

  Map<String, Object?> toJson() {
    return {
      "productId": productId,
      "slotNo": slotNo,
      
    };
  }
}

FirebaseService _service = FirebaseService();

getUserPurchasedSlotsData() {
  return _service.users
      .doc(_service.user!.uid)
      .collection("user_purchased_slots")
      .withConverter<UserPurchasedSlotsModel>(
        fromFirestore: (snapshot, _) => UserPurchasedSlotsModel.fromJson(snapshot.data()!),
        toFirestore: (product, _) => product.toJson(),
      );
}
