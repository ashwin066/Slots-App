import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_ecommerce/service/firebase_service.dart';

class Product {
  Product({
    this.slotPrice,
    this.slotPriceInRs,
    this.totalSlots,
    this.approved,
    this.productName,
    this.regularPrice,
    this.description,
    this.scheduledDate,
    this.shippingCharge,
    this.otherDetails,
    this.imageURLs,
    this.reservedSlots,
    this.id,
  });

  Product.fromJson(Map<String, Object?> json,String id)
      : this(
          approved: json['approved']! as bool,
          productName: json['productName']! as String,
          regularPrice: json['regularPrice'] == null
              ? null
              : json['regularPrice']! as int,
          slotPrice:
              json['slotPrice'] == null ? null : json['slotPrice']! as int,
          slotPriceInRs: json['slotPriceInRs'] == null
              ? null
              : json['slotPriceInRs']! as double,
          totalSlots:
              json['totalSlots'] == null ? null : json['totalSlots']! as int,
          description: json['description'] == null
              ? null
              : json['description']! as String,
          scheduledDate: json['scheduledDate'] == null
              ? null
              : json['scheduledDate']! as Timestamp,
          shippingCharge: json['shippingCharge'] == null
              ? null
              : json['shippingCharge']! as int,
          otherDetails: json['otherDetails'] == null
              ? null
              : json['otherDetails']! as String,
          imageURLs: json['imageURLs']! as List,
          reservedSlots: json['reservedSlots'] == null
              ? null
              : json['reservedSlots']! as List,
          id: id,
        );

  final String? productName;
  final int? regularPrice;
  final int? slotPrice;
  final double? slotPriceInRs;
  final int? totalSlots;

  final String? description;
  final Timestamp? scheduledDate;

  final int? shippingCharge;
  final String? otherDetails;
  final String? id;
  final List? imageURLs;
  final List? reservedSlots;
  final bool? approved;

  Map<String, Object?> toJson() {
    return {
      "approved": approved,
      "productName": productName,
      "regularPrice": regularPrice,
      "slotPrice": slotPrice,
      "slotPriceInRs": slotPriceInRs,
      "totalSlots": totalSlots,
      "description": description,
      "scheduledDate": scheduledDate,
      "shippingCharge": shippingCharge,
      "otherDetails": otherDetails,
      "imageURLs": imageURLs,
      "reservedSlots": reservedSlots,
      "id": id,
    };
  }
}

FirebaseService _service = FirebaseService();

productQuery(bool approved, String id) {
  return FirebaseFirestore.instance
      .collection('products')
      .where('approved', isEqualTo: approved)
      .where(FieldPath.documentId, isEqualTo: id)
      .withConverter<Product>(
        fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!,snapshot.id),
        toFirestore: (product, _) => product.toJson(),
      );
}

featuredProductQuery(bool approved, bool featured) {
  return FirebaseFirestore.instance
      .collection('products')
      .where('approved', isEqualTo: approved)
      .where('featured', isEqualTo: featured)
      .orderBy('createdAt')
      .withConverter<Product>(
        fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!,snapshot.id),
        toFirestore: (product, _) => product.toJson(),
      );
}
