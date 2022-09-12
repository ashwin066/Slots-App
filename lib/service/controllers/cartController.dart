import 'package:get/get.dart';
import 'package:shop_ecommerce/models/cart.dart';
import 'package:shop_ecommerce/models/cart_ID.dart';
import 'package:shop_ecommerce/service/controllers/cart_ID_Controller.dart';
import 'package:shop_ecommerce/service/db/firestore_cart_db.dart';

class CartController extends GetxController {
  final products = <CartModel>[].obs;
  final cartIdcontroller = Get.put(CartIdController());

  get total => products.map((product) => product.current_price).toList()
      //  .reduce((value, element) => value + element)
      ;

  get quantity =>
      cartIdcontroller.products.map((product) => product.quantity).toList()
      //  .reduce((value, element) => value + element)
      ;
  int? qt;
  double? tt;
  get  ggg => [ total ,quantity];

  get fullTOTAL => ggg
      .map((product) => product.tt * product.qt)
      .toList()
      .reduce((value, element) => value + element);

  @override
  void onInit() {
    products.bindStream(FirestoreCartDB().getAllProducts());
    super.onInit();
  }
}
