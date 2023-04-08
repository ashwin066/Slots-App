import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';

class MinimumProduct {
  MinimumProduct({
    this.slotPrice,
    this.slotPriceInRs,
    this.totalSlots,
     this.approved,
    this.productName,
    this.imageURLs,
    this.reservedSlots,
    this.tempReservedSlots,
    this.winningSlot,
    this.winnerUid,
    this.regularPrice, 
  });

  MinimumProduct.fromJson(Map<String, Object?> json,String id)
      : this(
          approved: json['approved']! as bool,
          productName: json['productName']! as String,
          slotPrice:
              json['slotPrice'] == null ? null : json['slotPrice']! as int,
          slotPriceInRs: json['slotPriceInRs'] == null
              ? null
              : json['slotPriceInRs']! as double,
          regularPrice: json['regularPrice'] == null
              ? null
              : json['regularPrice']! as int,
          totalSlots:
              json['totalSlots'] == null ? null : json['totalSlots']! as int,
          
          imageURLs: json['imageURLs']! as List,
          reservedSlots: json['reservedSlots'] == null
              ? null
              : json['reservedSlots']! as List,
          tempReservedSlots: json['tempReservedSlots'] == null
              ? null
              : json['tempReservedSlots']! as List,
          winningSlot:
              json['winningSlot'] == null ? null : json['winningSlot']! as int,
          winnerUid:
              json['winnerUid'] == null ? null : json['winnerUid']! as String,
        );

  final String? productName;
  final int? slotPrice;
  final double? slotPriceInRs;
  final int? totalSlots;
   final bool? approved;
  final List? imageURLs;
  final List? reservedSlots;
  final List? tempReservedSlots;
  final int? winningSlot;
  final String? winnerUid;
  final int? regularPrice;

  Map<String, Object?> toJson() {
    return {
      "productName": productName,
      "slotPrice": slotPrice,
      "slotPriceInRs": slotPriceInRs,
      "regularPrice": regularPrice,
      "totalSlots": totalSlots,
       "imageURLs": imageURLs,
      "reservedSlots": reservedSlots,
      "tempReservedSlots": tempReservedSlots,
      "winningSlot": winningSlot,
    };
  }
}

minimumProductQuery(bool approved) {
  return FirebaseFirestore.instance
      .collection('products')
      .where('approved', isEqualTo: approved)
      .orderBy('createdAt', descending: true)
      .withConverter<MinimumProduct>(
        fromFirestore: (snapshot, _) =>
            MinimumProduct.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (product, _) => product.toJson(),
      );
}

minimumProductQueryWinnerList(bool approved) {
  return FirebaseFirestore.instance
      .collection('products')
      .where('approved', isEqualTo: approved)
      .where('winnerUid', isNull: false)

      // .orderBy('createdAt' )
      .withConverter<MinimumProduct>(
        fromFirestore: (snapshot, _) =>
            MinimumProduct.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (product, _) => product.toJson(),
      );
}

muchMinimumProductQuery(bool approved, String id) {
  return FirebaseFirestore.instance
      .collection('products')
      .where('approved', isEqualTo: approved)
      .where(FieldPath.documentId, isEqualTo: id)
      .withConverter<MinimumProduct>(
        fromFirestore: (snapshot, _) =>
            MinimumProduct.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (product, _) => product.toJson(),
      );
}

featuredMinimumProductQuery(bool approved, bool featured) {
  return FirebaseFirestore.instance
      .collection('products')
      .where('approved', isEqualTo: approved)
      .where('featured', isEqualTo: featured)
      .orderBy('createdAt')
      .withConverter<MinimumProduct>(
        fromFirestore: (snapshot, _) =>
            MinimumProduct.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (product, _) => product.toJson(),
      );
}
