import 'package:get/get.dart';
import 'package:shop_ecommerce/models/product.dart';
import 'package:shop_ecommerce/service/db/firestore_db.dart';
 
 
class ProductController extends GetxController {
  // Add a list of Product objects.
  final products = <Product>[].obs;

  @override
  void onInit() {
    products.bindStream(FirestoreDB().getAllProducts());
    super.onInit();
  }
}
// import 'package:get/get.dart';
// import 'package:shop_ecommerce/models/product.dart';

// class ProductController extends GetxController {
//   final products = <Product>[].obs;
// }
