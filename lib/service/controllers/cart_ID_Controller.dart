import 'package:get/get.dart';
import 'package:shop_ecommerce/models/cart_ID.dart';
import 'package:shop_ecommerce/service/db/firebase_cartID_db.dart';
 
class CartIdController extends GetxController {
  final products = <CartIdModel>[].obs;
   
  @override
  void onInit() {
    products.bindStream(FirestoreCartIdDB().getAllProducts());
        super.onInit();

  }
}
