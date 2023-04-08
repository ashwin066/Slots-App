import 'package:flutter/material.dart';

class MinimumProductProvider with ChangeNotifier {
  Map<String, dynamic>? productData = {"approved": false};

  getProductData({
    String? productName,
    int? slotPrice,
    double? slotPriceInRs,
    int? totalSlots,
     List? imageURLs,
    Map<String, dynamic>? seller,    
 
  }) {
    if (productName != null) {
      productData!['productName'] = productName;
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
     

    if (imageURLs != null) {
      productData!['imageURLs'][0] = imageURLs;
    }
    if (seller != null) {
      productData!['seller'] = seller;
    }
  
    notifyListeners();
  }
}
