import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shop_ecommerce/components/product_item_card.dart';
import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/get_put_data/remove_from_cart_wishlist.dart';
import 'package:shop_ecommerce/screens/details/details_screen.dart';
import 'package:shop_ecommerce/service/controllers/cartController.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

onBack() {
  Get.delete<CartController>();
  Get.back();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    // TODO: implement initState

    Get.put(CartController());
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CartController controller = Get.find();

    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }

    return WillPopScope(
      onWillPop: () {
        return onBack();
      },
      
        child: Obx(() {
          return ListView.builder(
            //   itemCount: demoCarts.length,
            itemCount: controller.products.length,
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Dismissible(
                key: Key(controller.products[index].id),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
          
                  removeFromUserDB(
                      id: controller.products[index].id,
                      whereToRemove: "users-cart-items");
                  controller.products.value.removeWhere(
                      ((item) => item.id == controller.products[index].id));
                },
                background: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFE6E6),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Row(
                      children: [
                        Spacer(),
                        SvgPicture.asset("assets/icons/Trash.svg"),
                      ],
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    ProductItemCard(
                        //   controllerForCart: controller,
                        product: controller.products[index],
                        index: index,
                        //     index: index,
                        press: () {
                          Navigator.pushNamed(
                            context,
                            DetailsScreen.routeName,
                            arguments: ProductDetailsArguments(
                                product: controller.products.toList()[index]),
                          );
                        },
                        type: "cart"),
                         Container(
                          height: 2,
                          width: MediaQuery.of(context).size.width/1.1,
                       decoration: BoxDecoration(
                        color: MuchLightGray,
                        borderRadius: BorderRadius.all(Radius.circular(15.r))
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      
    );

    // fetchData("users-cart-items", "cart");
  }
}
