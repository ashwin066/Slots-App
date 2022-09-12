import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shop_ecommerce/components/icon_button.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/models/product.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_ecommerce/service/db/firestore_db.dart';

class CartController extends GetxController {
  var _products = {}.obs;
  var isEmpty = false.obs;

  void addProduct(product) {
    if (_products.containsKey(product)) {
      _products[product] += 1;
    } else {
      _products[product] = 1;
    }
    Get.snackbar(
        "Product Added", "You have added ${product.product_name} to cart",
        margin: EdgeInsets.all(10),
        colorText: aWhite,
        icon: IconButtonCustom(
            icon: "assets/icons/Success.svg",
            press: () {},
            height: 17,
            width: 17,
            color: SecondaryColor),
        borderRadius: 13,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        backgroundGradient: kBlackGradientColor,
        snackPosition: SnackPosition.TOP,
        dismissDirection: DismissDirection.horizontal,
        duration: Duration(milliseconds: 1500));
  }

  void removeProduct(product) {
    if (_products.containsKey(product) && _products[product] == 1) {
      _products.removeWhere((key, value) => key == product);
    } else {
      _products[product] -= 1;
    }
    Get.snackbar(
        "Product Removed", "Removed ${product.product_name} from your cart",
        margin: EdgeInsets.all(10),
        colorText: aWhite,
        icon: IconButtonCustom(
            icon: "assets/icons/Trash.svg",
            press: () {},
            height: 20,
            width: 20,
            color: TomatoRed),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        backgroundGradient: kBlackGradientColor,
        snackPosition: SnackPosition.TOP,
        dismissDirection: DismissDirection.horizontal,
        duration: Duration(seconds: 2));
    if (_products[product].length == 0) {
      isEmpty(true);
    } else {
      isEmpty(false);
    }
  }

  void removeCompleteProductQuantity(product) {
    if (_products.containsKey(product) && _products[product] >= 1) {
      _products.removeWhere((key, value) => key == product);
    }
    Get.snackbar(
        "Product Removed", "Removed ${product.product_name} from your cart",
        margin: EdgeInsets.all(10),
        colorText: aWhite,
        icon: IconButtonCustom(
            icon: "assets/icons/Trash.svg",
            press: () {},
            height: 20,
            width: 20,
            color: TomatoRed),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        backgroundGradient: kBlackGradientColor,
        snackPosition: SnackPosition.TOP,
        dismissDirection: DismissDirection.horizontal,
        duration: Duration(seconds: 2));
    if (_products[product].length == 0) {
      isEmpty(true);
    } else {
      isEmpty(false);
    }
  }

  get products => _products;

  get productSubtotal => _products.entries
      .map((product) => product.key.current_price * product.value)
      .toList();

  get total => _products.entries
      .map((product) => product.key.current_price * product.value)
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(2);
}
