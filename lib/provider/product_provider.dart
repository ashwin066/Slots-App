import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  Map<String, dynamic>? productData = {"approved": false};

  getProductData({
    String? productName,
    int? regularPrice,
    int? slotPrice,
    double? slotPriceInRs,
    int? totalSlots,
     String? description,
    DateTime? scheduledDate,
    int? shippingCharge,
    String? otherDetails,
    List? imageURLs,
    Map<String, dynamic>? seller,
  }) {
    if (productName != null) {
      productData!['productName'] = productName;
    }
    if (description != null) {
      productData!['description'] = description;
    }
    if (regularPrice != null) {
      productData!['regularPrice'] = regularPrice;
    }

    if (slotPrice != null) {
      productData!['slotPrice'] = slotPrice;
    }
    if (slotPriceInRs != null) {
      productData!['slotPriceInRs'] = slotPriceInRs;
    }
    if (totalSlots != null) {
      productData!['totalSlots'] = totalSlots;
    }
   

    if (scheduledDate != null) {
      productData!['scheduledDate'] = scheduledDate;
    }

    if (shippingCharge != null) {
      productData!['shippingCharge'] = shippingCharge;
    }

    if (otherDetails != null) {
      productData!['otherDetails'] = otherDetails;
    }
    if (imageURLs != null) {
      productData!['imageURLs'] = imageURLs;
    }

    notifyListeners();
  }
}
