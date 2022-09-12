import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shop_ecommerce/components/icon_button.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/product.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishlistController extends GetxController {
  var _products = {}.obs;
  void addProductToWishlist(product) {
    if (_products.containsKey(product)) {
      removeProductFromWishlist(product);
    } else {
      _products[product] = 1;
       Get.snackbar(
          "Wishlist Added", "Added to wishlist",
          margin: EdgeInsets.all(10),
          colorText: aWhite,
          icon: IconButtonCustom(
              icon: "assets/icons/Heart filled.svg",
              press: () {},
              height: 27.h,
              width: 27.h,
              color: TomatoRed),
          borderRadius: 13,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          backgroundGradient: kBlackGradientColor,
          snackPosition: SnackPosition.TOP,
          dismissDirection: DismissDirection.horizontal,
          duration: Duration(milliseconds: 1500));
    }
   
  }

  void removeProductFromWishlist(product) {
    if (_products.containsKey(product) && _products[product] >= 1) {
      _products.removeWhere((key, value) => key == product);
    }
    Get.snackbar(
        "Wishlist Removed", "Removed from wishlist",
        margin: EdgeInsets.all(10),
        colorText: aWhite,
        icon: IconButtonCustom(
            icon: "assets/icons/Broken Heart Icon.svg",
            press: () {},
            height: 25.h,
            width: 25.w,
            color: TomatoRed),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        backgroundGradient: kBlackGradientColor,
        snackPosition: SnackPosition.TOP,
        dismissDirection: DismissDirection.horizontal,
        duration: Duration(seconds: 2));
  }

  get products => _products;
}
